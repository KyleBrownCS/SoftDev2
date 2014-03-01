//Days of the week.
var weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

//Months full name
var monthsOfYear = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

//How many days are in each month, Leap year is calculated seperately later.
var numDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

//Let's get today...
var currentDate = new Date();
var currentDay = currentDate.getDate();
var currentMonth = currentDate.getMonth();
var currentYear = currentDate.getFullYear();

//Constructor for the calendar. Useful
//when we need to construct next/previous month
function Calendar(month, year)
{
  this.htmlCode = '';
}

//A prototype to get the htmlCode generated table for the month.
Calendar.prototype.gethtmlCode = function() 
{
  return this.htmlCode;
}

Calendar.prototype.calculateCalendar = function()
{
  //First, grab the first day of the month
  var startingDay = new Date(currentYear, currentMonth, 1).getDay();
  var monthLength = numDaysInMonth[currentMonth];
  //If it's feburary, do calculation for leap year
  if (currentMonth == 1) 
  {
  //A calculation for leap year.
    if((currentYear % 4 == 0 && currentYear % 100 != 0) || currentYear % 400 == 0)
	{
		//If its a leap year, make the day longer.
      monthLength = 29;
    }
  }
  
	//Create the table, start with the month and the year
  var monthName = monthsOfYear[currentMonth]
  var htmlCode = '<table border=3 style="line-height: 4;" class="calendar-table">';
  htmlCode += '<tr><th colspan="7">';
  htmlCode +=  monthName + "&nbsp;" + currentYear;
  htmlCode += '</th></tr>';
  htmlCode += '<tr class="calendar-header">';
  //Initialize Monday-Sunday headers
  for(var i = 0; i <= 6; i++ ){
    htmlCode += '<td  width="100" class="calendar-header-day">';
    htmlCode += weekDays[i];
    htmlCode += '</td>';
  }
  htmlCode += '</tr><tr>';
  var day = 1;
  var outOfDays = 0;
  for (var i = 0; i < 9; i++) 
  {
	//if we haven't printed all the days in the month yet, print more.
	if(outOfDays == 0)
	{
    // this loop is for weekdays (cells)
    for (var j = 0; j <= 6; j++) 
	{ 
      htmlCode += '<td class="calendar-day">';
      if (day <= monthLength && (i > 0 || j >= startingDay)) 
	  {
		if(day == currentDay)
			htmlCode += '<p style="color:red;">'+day+'<p>';
		else
			htmlCode += day;
        day++;
      }
      htmlCode += '</td>';
    }
    if (day > monthLength) 
	{
	//When we have filled enough days out enough days, we stop the loop.
      outOfDays = 1;
    } 
	else 
	{
      htmlCode += '</tr><tr>';
	}   
   }
  }
  htmlCode += '</tr></table>';
  this.htmlCode = htmlCode;
}

$(document).ready(function(e) 
{ 
  var calen = new Calendar(currentMonth,currentYear);
  calen.calculateCalendar();
  $('#sendTo').append(calen.gethtmlCode());
  });