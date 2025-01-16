module ApplicationHelper

    # In the controller or a helper module
  def work_order_exists?(tech_id, hour)
    # Check if a work order exists for this technician and time
    @work_orders.any? { |wo| wo.technician_id == tech_id && wo.start_time.hour == hour }
  end

  def work_order_details(tech_id, hour)
    # Get the work order details if it exists for this technician and time
    work_order = @work_orders.find { |wo| wo.technician_id == tech_id && wo.start_time.hour == hour }
    location = @locations.find { |loc| loc.id == work_order.location_id }
    hour_and_minute = work_order.start_time.strftime("%H:%M")
    "#{location.name} - #{location.city} - #{hour_and_minute} - $#{work_order.price}"
  end

  def work_order_class(tech_id, hour)
    # Add a class for work orders to distinguish them visually
    work_order_exists?(tech_id, hour) ? 'work-order' : 'empty'
  end

  def next_work_order_time(tech_id, hour)
    # Find the next work order's time
    work_order = @work_orders.find { |wo| wo.technician_id == tech_id && wo.start_time.hour > hour }
    work_order ? work_order.start_time :  DateTime.new(2025, 1, 2, 0, 0, 0, Rational(-6, 24)) # Return the start time as a Time object
  end
  
  def prev_work_order_end_time(tech_id, hour)
    # Find the previous work order's end time
    now = DateTime.now
    work_order = @work_orders
      .select { |wo| wo.technician_id == tech_id && wo.start_time.hour <= hour}
      .max_by { |wo| wo.start_time + wo.duration * 60 }
    work_order ? (work_order.start_time + work_order.duration * 60) : DateTime.new(2025, 1, 1, 0, 0, 0, Rational(-6, 24))  # Return the end time as a Time object
  end
  
  def time_difference(tech_id, hour)
    # Fetch the next work order's start time
    next_work_order = next_work_order_time(tech_id, hour)
    # Fetch the previous work order's end time
    prev_work_order_end = prev_work_order_end_time(tech_id, hour)
  
    if next_work_order && prev_work_order_end
      # Convert Time objects to seconds since the Unix epoch
      next_time_in_seconds = next_work_order.to_i
      prev_time_in_seconds = prev_work_order_end.to_i
      # Subtract the times in seconds
      time_diff_in_seconds = next_time_in_seconds - prev_time_in_seconds
  
      # Convert seconds to minutes
      time_diff_in_minutes = time_diff_in_seconds / 60.0
      time_diff_in_minutes
    else
      "No valid work orders"
    end
  end
end   