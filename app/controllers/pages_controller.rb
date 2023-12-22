class PagesController < ApplicationController
  def dashboard
    @spas = current_user.host_spas
    @bookings = current_user.guest_bookings
    @spa = Spa.new
    if params[:query].present?
      @spas = Spa.search_owned(params[:query])
    end
  end
end
