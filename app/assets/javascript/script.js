function showPopup(technicianName, startTime, endTime, diff) {
    const popupMessage = document.getElementById("popup-message");
    popupMessage.textContent = `Technician: ${technicianName} is free from ${startTime} to ${endTime}, that is ${diff} minutes`;
    const popup = document.getElementById("popup");
    popup.style.display = "flex";
}

function closePopup() {
    const popup = document.getElementById("popup");
    popup.style.display = "none";
}

window.addEventListener("click", function (event) {
    const popup = document.getElementById("popup");
    if (event.target === popup) {
        closePopup();
    }
});
