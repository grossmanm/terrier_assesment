namespace :import do

  desc "Import locations from csv"
  task users: :environment do
    filename = File.join Rails.rootm, "locations.csv"
    CSV.foreach(filename) do |row|
      p row
  end 
    
end 