class PagesController < ApplicationController
  def home
    @technicians = Technician.all
    @locations = Location.all
  end

  def about
  end
end
