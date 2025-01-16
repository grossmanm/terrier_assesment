class WorkOrdersController < ApplicationController
  def index
    @locations = Location.all
    @technicians = Technician.all
    @work_orders = WorkOrder.includes(:technician, :location).order(:start_time)
  end 
end