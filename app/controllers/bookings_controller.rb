class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    @user = current_user
  end

  def show
    @booking = Booking.find(params[:id])
    @user = current_user
  end

  def new
    @user = current_user
    @spa = Spa.find(params[:spa_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @spa = Spa.find(params[:spa_id])
    @user = current_user
    @booking.spa = @spa
    @booking.user = @user

    if @booking.save
      redirect_to spa_booking_path(@booking)
    else
      render :new, status => :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :spa_id, :user_id)
  end
end
