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
function getCurrTime()
{
	var currentDat = new Date();
	return currentDat;
}
function getCurrDay()
{
	var currentDat = new Date();
	var currentDay = currentDat.getDate();
	return currentDay;
}
function getCurrMonth()
{
	var currentDat = new Date();
	var currentMonth = currentDat.getMonth();
	return currentMonth;
}
function getCurrYear()
{
	var currentDat = new Date();
	var currentYear = currentDat.getFullYear();
	return currentYear;
}