class PromotorsController < ApplicationController
  def new
    @promotor = Promotor.new()
  end

  def create
    @promotor = Promotor.new(promotor_params)
    if @promotor.save
      redirect_to quotes_path
    end
  end

  def delete
  end

  private
  def promotor_params
    params.require(:promotor).permit(:user_id)
  end

end