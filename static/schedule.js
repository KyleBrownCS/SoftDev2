$(document).ready(function(e) { 
    $.get('/obligations', function(data) {
    	obligations = eval(data)

    	//Push data to screen in a presentable matter
    	//$("#sendTo").append(heading);
		var currentDate = new Date();
		var currentMonth = currentDate.getMonth();
		var currentYear = currentDate.getFullYear();
		var calen = new Calendar(currentMonth,currentYear, obligations);
		calen.calculateCalendar();
		$('#sendTo').html(calen.gethtmlCode());
    });
});
