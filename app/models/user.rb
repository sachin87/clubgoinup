class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :goings
  has_many :venues, through: :goings
  has_many :likes, foreign_key: :liker_id
  has_many :received_likes, class_name: "Like", foreign_key: :likee_id
  has_one :promotor
  has_many :quotes
  acts_as_messageable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.image    = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.name     = auth.info.name
      user.email = auth.info.email
      user.save
    end
  end

  def facebook()
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end
end
