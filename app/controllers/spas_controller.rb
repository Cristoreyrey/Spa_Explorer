class SpasController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_user

  def home
    @spas = Spa.all.order(created_at: :desc)
    @user = current_user
    @spas = policy_scope(Spa)
    @spa = Spa.new
    @spa_map = Spa.geocoded
    @markers = @spas.geocoded.map do |spa|
      {
        lat: spa.latitude,
        lng: spa.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { spa: spa }),
        marker_html: render_to_string(partial: 'marker', locals: { spa: spa })
      }
    end
    if params[:query].present?
      @spas = Spa.search_by_name_and_address(params[:query])
    end
  end

  def index
    authorize @spa
    @spas = Spa.all
  end

  def show
    @spa = Spa.find(params[:id])
    authorize @spa
  end

  def new
    authorize @spa
    @spa = Spa.new
  end

  def create
    @spa = Spa.new(spa_params)
    @spa.user = current_user
    authorize @spa
    if @spa.save
      update_user_to_host
      redirect_to root_path, notice: 'Your Spa was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @spa = Spa.find(params[:id])
    authorize @spa
  end

  def update
    @spa = Spa.find(params[:id])
    authorize @spa
    if @spa.update(spa_params)
      redirect_to @spa, notice: 'Spa was successfully updated!'
    else
      render :edit
    end
  end

  def destroy
    @spa = Spa.find(params[:id])
    authorize @spa
    @spa.destroy

    redirect_to dashboard_path notice: 'Spa was successfully erased'
  end


  private

  def set_user
    @user = current_user
  end

  def spa_params
    params.require(:spa).permit(:name, :address, :price, :rating, images: [])
  end

  def update_user_to_host
    current_user.update!(role: 'host')
  end
end
