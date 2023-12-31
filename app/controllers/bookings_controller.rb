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
    authorize @booking

    render turbo_stream: turbo_stream.replace(:spas, partial: "bookings/turbo_frames/new", locals: { spa: @spa, booking: @booking })
  end

  def create
    @booking = Booking.new(booking_params)
    @spa = Spa.find(params[:spa_id])
    @user = current_user
    @booking.spa = @spa
    @booking.guest = @user
    authorize @booking

    if @booking.save
      redirect_to dashboard_path, notice: 'Booking was successfully created!'
    else
      render :new, status => :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy

    redirect_to dashboard_path, notice: 'Booking was successfully deleted!'
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.update!(status: 1)
    authorize @booking
    redirect_to dashboard_path, notice: 'Booking was successfully accepted!'
  end

  def reject
    @booking = Booking.find(params[:id])
    @booking.update!(status: 2)
    authorize @booking
    redirect_to dashboard_path, notice: 'Booking was successfully rejected!'
  end


  private

  def booking_params
    params.require(:booking).permit(:date, :spa_id, :user_id)
  end
end
