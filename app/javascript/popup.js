document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".technician-column").forEach((column) => {
      column.addEventListener("click", (e) => {
        if (e.target.classList.contains("work-order")) return;
  
        const technicianId = column.getAttribute("data-technician-id");
        const orders = Array.from(column.querySelectorAll(".work-order"));
        const y = e.clientY;
        const clickedHour = Math.floor(y / 50);
        const availableTime = calculateAvailableTime(clickedHour, orders);
  
        alert(`Technician ID: ${technicianId}\nAvailable time: ${availableTime} minutes`);
      });
    });
  
    function calculateAvailableTime(hour, orders) {
      // Calculate the time available between work orders
      return 60; // Example logic
    }
  });
  