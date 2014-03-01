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
	this.calenMonth = month;
	this.calenYear = year;
  this.htmlCode = '';
}

//A prototype to get the htmlCode generated table for the month.
Calendar.prototype.gethtmlCode = function() 
{
  return this.htmlCode;
}

Calendar.prototype.calculateCalendar = function(obligations)
{
	//First, grab the first day of the month
	var startingDay = new Date(this.calenYear, this.calenMonth, 1).getDay();
	var monthLength = numDaysInMonth[this.calenMonth];
	//If it's feburary, do calculation for leap year
	if (this.calenMonth == 1) 
	{
	//A calculation for leap year.
		if((this.calenYear % 4 == 0 && this.calenYear % 100 != 0) || this.calenYear % 400 == 0)
		{
		//If its a leap year, make the day longer.
		monthLength = 29;
		}
	}

	//Create the table, start with the month and the year
	var monthName = monthsOfYear[this.calenMonth]
	var htmlCode = '<table border=3 style="line-height: 4;" class="calendar-table">';
	htmlCode += '<tr><th colspan="7">';
	htmlCode +=  monthName + "&nbsp;" + this.calenYear;
	htmlCode += '</th></tr>';
	htmlCode += '<tr class="calendar-header">';
	//Initialize Monday-Sunday headers
	for(var i = 0; i <= 6; i++ )
	{
		htmlCode += '<td  width="100">';
		htmlCode += weekDays[i];
		htmlCode += '</td>';
	}
	htmlCode += '</tr><tr>';
	var day = 1;
	//Maximum amount of weeks to print on one month
	var maxWeekLines = 6;
	var outOfDays = 0;
	var dateString = 0;
	var status = 0;
	var color = 'black';
	var date = 0;
	var month = 0;
	var year = 0;
	for (var i = 0; i < maxWeekLines; i++) 
	{
		//if we haven't printed all the days in the month yet, print more.
		if(outOfDays == 0)
		{
			// this loop is for weekdays (cells)
			for (var j = 0; j <= 6; j++) 
			{ 
				htmlCode += '<td>';
				if (day <= monthLength && (i > 0 || j >= startingDay)) 
				{
				
					if(day == currentDay && currentMonth == this.calenMonth && currentYear == this.calenYear)
						htmlCode += '<p style="color:red;">'+day+'<p>';
					else
						htmlCode += day;
						
					//Iterate through the obligations, print the ones today
					for(var k = 0 ; k < obligations.length; k++)
					{
						status = obligations[k].status;
						color = this.getColor(status);
						//alert(color);
						//alert(status);
						dateString = JSON.stringify(obligations[k].startTime);
						dateString = dateString.split(" ");
						dateString = dateString[1].split("-");
						date = dateString[2];
						//Set the month -1 to match the algorithm (jan = 0, etc)
						month = dateString[1] - 1;
						year = dateString[0];
						//alert("Testing: YYYY-MM-DD" +year +"-"+month+"-"+date);
						//If our obligation is today.. Show it
						//alert(date+":"+day+" "+month+":"+this.calenMonth+" "+year+":"+this.calenYear);
						if(date == day && month == this.calenMonth && year == this.calenYear)
						{
							htmlCode += '<input type="button" style="width: 80px; height: 30px; background-color:'+color +'" value=";'+obligations[k].name+'"></button>';
							//alert(JSON.stringify(obligations[k]));
						}
					}
					
					day++;
				}
				htmlCode += '</td>';
			}
			//When we have filled enough days out enough days, we stop the loop.
			if (day > monthLength) 
				outOfDays = 1;
			else 
			htmlCode += '</tr><tr>'; 
		}
	}

  
  htmlCode += '</tr></table>';
  this.htmlCode = htmlCode;
}


Calendar.prototype.getColor = function(status)
{
	var color = 'gray';
	if(status == 1)
		color = 'yellow';
	else if(status == 1)
		color = 'green';
	else if(status == 1)
		color = 'blue';
	else if(status == 1)
		color = 'red';
	return color;
}