class PagesController < ApplicationController
  def dashboard
    @spas = current_user.host_spas
    if params[:query].present?
      @spas = Spa.search_owned(params[:query])
    end
  end
end
