class PagesController < ApplicationController
  def dashboard
    @spas = Spa.all
    if params[:query].present?
        @spas = Spa.search_by_name_and_address(params[:query])
    end
  end
end
