namespace :import do
  require 'csv'

  desc 'Import technicians, locations, and work orders from CSV'
  task load_csv: :environment do
    files = {
      technicians: 'technicians.csv',
      locations: 'locations.csv',
      work_orders: 'work_orders.csv'
    }

    # import Techicians
    CSV.foreach(Rails.root.join(files[:technicians]), headers: true) do |row|
      Technician.find_or_create_by!(id: row['id'], name: row['name'])
    end

    # import Locations
    CSV.foreach(Rails.root.join(files[:locations]), headers: true) do |row|
      Location.find_or_create_by!(id: row['id'], name: row['name'], city: row['city'])
    end

    # import work orders
    CSV.foreach(Rails.root.join(files[:work_orders]), headers: true) do |row|
      technician = Technician.find_by(id: row['technician_id'])
      location = Location.find_by(id: row['location_id'])
      if technician && location
        WorkOrder.create_with(
          id: row['id'],
          duration: row['duration'],
          price: row['price']
        ).find_or_create_by!(
          technician: technician,
          location: location,
          start_time: Time.strptime(row['time'], "%m/%d/%y %H:%M")
        )
      else
        puts "Skipping work order due to missing technician or location."
      end 
    end
  end 

  task delete_data: :environment do
    WorkOrder.delete_all
    Technician.delete_all
    Location.delete_all
  end 
end 