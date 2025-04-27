document.addEventListener('DOMContentLoaded', function () {
    const calendarEl = document.getElementById('calendar');

    const calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: ''
        },
        height: '100%',
        dayMaxEventRows: true,
        fixedWeekCount: true,
        selectable: true,
        dateClick: function(info) {
            alert('Clicked on: ' + info.dateStr);
        }
    });

    calendar.render();
});
