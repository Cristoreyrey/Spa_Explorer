class SpasController < ApplicationController
  skip_before_action :authenticate_user!, only: :home


def home
  @spas = Spa.all
  @user = current_user
end


  def index
    @spas = Spa.all
  end

  def show
    @spa = Spa.find(params[:id])
  end


  def new
    @spa = Spa.new
  end

  def create
    @spa = Spa.new(spa_params)
    @spa.save
    redirect_to spa_path(@spa)

  end



  def spa_params
    params.require(:spa).permit(:name, :address, :price, :rating)
  end


  def destroy
    @spa = Spa.find(params[:id])
    @spa.destroy

    redirect_to root_path notice: 'Your Spa was successfully destroyed.'
  end


end
