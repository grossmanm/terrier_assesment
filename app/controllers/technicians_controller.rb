class TechniciansController < ApplicationController
  before_action :set_technician, only: %i[ show edit update destroy ]

  def import 
    file = params[:file]

    #redirect if bad data
    return redirect_to root_path, alert: 'No file selected' unless file 
    return redirect_to root_path, alert: 'Please select CSV file instead' unless file.content_type == 'text/csv'
    
    headers = CSV.read(file.path, headers: true).headers
    if (headers.include? "name" == false or headers.length() != 2)
       return redirect_to root_path, alert: 'Technician file has incorrect headers'
    end 

    # import data
    csvImportService = CsvImportService.new(file)
    csvImportService.import_tech

    #redirect with notice
    redirect_to root_path, 
    notice: "#{csvImportService.number_imported_with_last_run} technicians imported"
  end

  # GET /technicians or /technicians.json
  def index
    @technicians = Technician.all
  end

  # GET /technicians/1 or /technicians/1.json
  def show
  end

  # GET /technicians/new
  def new
    @technician = Technician.new
  end

  # GET /technicians/1/edit
  def edit
  end

  # POST /technicians or /technicians.json
  def create
    @technician = Technician.new(technician_params)

    respond_to do |format|
      if @technician.save
        format.html { redirect_to @technician, notice: "Technician was successfully created." }
        format.json { render :show, status: :created, location: @technician }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @technician.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /technicians/1 or /technicians/1.json
  def update
    respond_to do |format|
      if @technician.update(technician_params)
        format.html { redirect_to @technician, notice: "Technician was successfully updated." }
        format.json { render :show, status: :ok, location: @technician }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @technician.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /technicians/1 or /technicians/1.json
  def destroy
    @technician.destroy!

    respond_to do |format|
      format.html { redirect_to technicians_path, status: :see_other, notice: "Technician was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def destroy_all
    Technician.delete_all
    flash[:notice] = "All technicians have been deleted"
    redirect_to root_path
  end
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_technician
      @technician = Technician.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def technician_params
      params.expect(technician: [ :name ])
    end
end
