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
var obligations;

//Constructor for the calendar. Useful
//when we need to construct next/previous month
function Calendar(month, year, obligs)
{
	obligations = obligs;
	this.calenMonth = month;
	this.calenYear = year;
	this.htmlCode = '';
}

//A prototype to get the htmlCode generated table for the month.
Calendar.prototype.gethtmlCode = function() 
{
  return this.htmlCode;
}

Calendar.prototype.calculateCalendar = function()
{
	var day = 1;
	//Maximum amount of weeks to print on one month
	var maxWeekLines = 6;
	var outOfDays = 0;
	var dateString = "";
	var tempDate = 0;
	var status = 0;
	var color = 'black';
	var date = 0;
	var month = 0;
	var year = 0;

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
		htmlCode += '<td  width="120">';
		htmlCode += weekDays[i];
		htmlCode += '</td>';
	}
	htmlCode += '</tr><tr>';
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
					//alert("test: "+day+" "+currentDay + " Month: "+currentMonth+ " "+this.calenMonth + " Year "+currentYear+ " "+this.calenYear);
					if(day == currentDay && currentMonth == this.calenMonth && currentYear == this.calenYear)
					{
						htmlCode += '<span style="color:red;">'+day+'</span>';
						alert("testing!");
					}
					else
						htmlCode += day;
					
					year = this.calenYear;
					month = this.calenMonth +1;
					if(month <= 9)
					{
						month = '0'+month;
					}
					date = day;
					if(date <= 9)
					{
						date = '0'+date;
					}
					dateString = ""+year+"-"+month+"-"+date;	
					 if(this.checkDayForObligations(dateString) == 1)
					 {
						 htmlCode += '<input type="button" onclick="getObligationsFromDB(\''+dateString.toString()+'\')" style="width: 110px; height: 40px;" value="View Obligations"></button>';
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
	else if(status == 2)
		color = 'green';
	else if(status == 3)
		color = 'blue';
	else if(status == 4)
		color = 'red';
	return color;
}

Calendar.prototype.checkDayForObligations = function(startTime)
{
	var tempDate = 0;
	var obgFound = 0;
	var i = 0;
	while(i < obligations.length && obgFound == 0)
	{
		tempDate = JSON.stringify(obligations[i].startTime);
		tempDate = tempDate.split(" ");
		tempDate = tempDate[1];
		if(tempDate == startTime)
		{
			obgFound = 1;
		}
		i++;
	}
	return obgFound;
}

function getObligationsFromDB(startTime)
{
	var gotData = 0;
    $.get('/obligations/'+startTime, function(data) 
	{
		if(data != null && data != "")
		{
			gotData = 1;
			var mydata = data.trim().replace(/\(/g, "");
			mydata = mydata.replace(/\)/g, "");
			var datas = mydata.split("|");
			var statusNum = 0;
			var colors = ['black', 'yellow', 'green', 'blue', 'red'];
			var statuses = ['none','In Progress','Completed','Important','Requires Assistance'];
			var obligationFields = ['obligationid','userid','name','description','startTime','endTime','priority','status','category'];
			var heading = "<table border='1'><th>ObligationID</th><th>UserID</th><th>Name</th><th>Description</th><th>StartTime</th><th>EndTime</th><th>Priority</th><th>Status</th><th>Modify</th>";
			var mainData = "";
			var currline = "<tr>";
			var obgid = 0;
			var statusCol = 7;
			var obgidCol = 0;
			var editCol = 8;
			for (var i = 0; i < datas.length; i++)
			{
				var miniparts = datas[i].trim().split(",");
				//if we get an object, create an obligation
				if(9 == miniparts.length)
				{
					var obligation = new Obligation(0,0,'','','','',1,1,1);
					for (var j = 0; j < miniparts.length; j++)
					{
						miniparts[j] = miniparts[j].replace(/\u'/g, "");
						miniparts[j] = miniparts[j].replace(/\'/g, "");
						if(j == obgidCol)
						{
							obgid = miniparts[j];
						}
						//If it's processing a status, show the string instead of the integer value
						if(j == statusCol)
						{
							statusNum = parseInt(miniparts[j]);
							color = colors[statusNum];
							currline = currline + "<td style=\"color:"+color+";\">" + statuses[statusNum] + "</td>";
						}
						else if(j == editCol)
						{
							currline = currline + '<td><input type="button" value="Edit" onclick="myFunction('+obgid+')"></td>'
						}
						else
						{
							currline = currline + "<td>" + miniparts[j] + "</td>";
						}
					}
					heading = heading + currline + '</tr>';
					currline = "<tr>";
				}
				
			}
			heading = heading + "</table>";
			$("#obligations").html(heading);
		}
	});
	return gotData;
}

function myFunction(obgid)
{
    $.get('/obligations/'+obgid+"", function(data) 
	{

		alert(data);
	});
}
