# app/controllers/tasks_controller.rb
class TasksController < ApplicationController

  def run_import
    begin 
      result = system("bundle exec rake import:load_csv")
      
      if result 
        respond_to do |format|
          format.js {render js: "Data has been imported."}
        end
      else
        # If the rake task failed
        respond_to do |format|
          format.js { render js: "alert('An error occurred while importing the data.');" }
        end 
      end 
    rescue StandardError => e
      # Handle any exceptions and provide error feedback
      redirect_to root_path, alert: "An error occurred: #{e.message}"
    end
  end

  def run_delete
    begin
      result = system("bundle exec rake import:delete_data")

      if result 
        respond_to do |format|
          format.js {render js: "Data has been deleted."}
        end
      else
        # If the rake task failed
        respond_to do |format|
          format.js { render js: "alert('An error occurred while deleting the imported data.');" }
        end 
      end 
      
    rescue StandardError => e
      redirect_to root_path, alert: "An error occured: #{e.message}"
    end 
  end
end
