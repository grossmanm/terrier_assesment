class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]

  def import 
    file = params[:file]

    # redirect if bad data 
    return redirect_to root_path, alert: "No file selected" unless file
    return redirect_to root_path, alert: 'Please select CSV file instead' unless file.content_type == 'text/csv'

    headers = CSV.read(file.path, headers: true).headers
    if (headers.include? "name" == false or headers.include? "city" == false or headers.length() != 3)
      return redirect_to root_path, alert: "Location file has incorrect headers"
    end
    
    # import data
    csvImportService = CsvImportService.new(file)
    csvImportService.import_loc

    # redirect with notice
    redirect_to root_path,
    notice: "#{csvImportService.number_imported_with_last_run} locations imported"
  end 
  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1 or /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: "Location was successfully created." }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: "Location was successfully updated." }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy!

    respond_to do |format|
      format.html { redirect_to locations_path, status: :see_other, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def destroy_all
    Location.delete_all
    flash[:notice] = "All locations have been deleted"
    redirect_to root_path
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.expect(location: [ :name, :city ])
    end
end
