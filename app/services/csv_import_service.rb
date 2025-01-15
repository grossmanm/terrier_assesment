class CsvImportService
  def initialize(file)
      @file = file
      @count = 0
  end 

  def import_tech
    @count = 0
    CSV.foreach(@file.path, headers: true) do |row|
      technician_data = row.to_hash

      technician = Technician.find_or_create_by(id: technician_data["id"]) do |tech|
        tech.name = technician_data["name"]
      end 

      @count += 1 if technician.persisted?
    end 
  end
  
  def import_loc
    @count = 0
    CSV.foreach(@file.path, headers: true) do |row|
      location_data = row.to_hash
      
      location = Location.find_or_create_by(id: location_data["id"]) do |loc|
        loc.name = location_data["name"]
        loc.city = location_data["city"]
      end 
      
      @count += 1 if location.persisted?
    end
  end 
  
  def number_imported_with_last_run
    @count
  end

end