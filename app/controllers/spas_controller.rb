class SpasController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_user


  def home
    @spas = Spa.all
    @user = current_user
    @spa = Spa.new
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
    @spa.user = current_user
    if @spa.save
      @spa.user.role = "host"
      redirect_to spa_path(@spa)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @spa = Spa.find(params[:id])
  end

  def update
    @spa = Spa.find(params[:id])
    if @spa.update(spa_params)
      redirect_to @spa, notice: 'Spa was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @spa = Spa.find(params[:id])
    @spa.destroy

    redirect_to root_path notice: 'Spa was successfully erased'
  end


  private

  def set_user
    @user = current_user
  end

  def spa_params
    params.require(:spa).permit(:name, :address, :price, :rating, :image)
  end
end
