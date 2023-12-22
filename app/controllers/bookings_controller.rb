class BookingsController < ApplicationController

  def index
    @bookings = current_user.guest_bookings
    @user = current_user
  end

  def show
    @booking = Booking.find(params[:id])
    @user = current_user
    @spa = @booking.spa
  end

  def new
    @spa = Spa.find(params[:spa_id])
    @booking = Booking.new

    render turbo_stream: turbo_stream.replace(:spas, partial: "bookings/turbo_frames/new", locals: { spa: @spa, booking: @booking })
  end

  def create
    @booking = Booking.new(booking_params)
    @spa = Spa.find(params[:spa_id])
    @user = current_user
    @booking.spa = @spa
    @booking.guest = @user

    if @booking.save
      redirect_to dashboard_path, notice: 'Booking was successfully created!'
    else
      render :new, status => :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    redirect_to dashboard_path, notice: 'Booking was successfully deleted!'
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :spa_id, :user_id)
  end
end
