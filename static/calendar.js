//Days of the week.
var weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

//Months full name
var monthsOfYear = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

//How many days are in each month, Leap year is calculated seperately later.
var numDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

//Status names
var statuses = ['none','In Progress','Completed','Important','Requires Assistance'];
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
	var prevYear;
	var prevMonth;
	var nextYear;
	var nextMonth;

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
	var monthName = monthsOfYear[this.calenMonth];
	var htmlCode = '<table border=3 style="line-height: 4;" class="calendar-table">';
	prevYear = this.calenYear;
	prevMonth = this.calenMonth -1;
	nextYear = this.calenYear;
	nextMonth = this.calenMonth + 1;
	if(prevMonth == -2)
	{
		prevYear = this.calenYear - 1;
		prevMonth = 11;
	}
	if (nextMonth == 12)
	{
		nextYear = this.calenYear + 1;
		nextMonth = 0;
	}
	htmlCode += '<tr><th colspan="7" style="text-align:center;">';
	htmlCode += "<input type='button' value='Previous month' onclick='generateNextMonth("+prevMonth+", "+prevYear+")'></input>";
	htmlCode +=  monthName + "&nbsp;" + this.calenYear;
	htmlCode += "<input type='button' value='Next month' onclick='generateNextMonth("+nextMonth+", "+nextYear+")'></input>"
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
					if(day == currentDay && currentMonth == this.calenMonth && currentYear == this.calenYear)
						htmlCode += '<span style="color:red;">'+day+'</span>';
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
	while(i < obligations.length)
	{
		if(obgFound != 1)
		{
			tempDate = obligations[i].startTime;
			tempDate = tempDate.split(/\s+/);
			tempDate = tempDate[0];
			if(tempDate == startTime)
			{
				obgFound = 1;
			}
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
							currline = currline + '<td><input type="button" value="Edit" onclick="editOglibation('+obgid+')"></td>'
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

function generateNextMonth(currMonth, currYear)
{
	var calen = new Calendar(currMonth,currYear, obligations);
	calen.calculateCalendar();
	$('#sendTo').html(calen.gethtmlCode());
}

function editOglibation(obgid)
{
    $.get('/obligations/'+obgid+"", function(data) 
	{

		var heading = "";
		var statusNum = 0;
		var obligid;
		heading += "<div id='name2'>name: <input type='text' id='name' value='"+obligations[obgid-1].name+"'></input></div>";
		heading += "<div id='description2'>Description: <input id='text' name='description' value='"+obligations[obgid-1].description+"'></input></div>";
		heading += "<div id='stime2'>Start Time: <input type='text' id='stime' value='"+obligations[obgid-1].startTime+"'></input></div>";
		heading += "<div id='etime2'>End Time: <input type='text' name='etime' value='"+obligations[obgid-1].endTime+"'></input></div>";
		heading += "<div id='pri2'>Priority: <input type='text' name='pri' value='"+obligations[obgid-1].priority+"'></input></div>";
		heading += "<div id='cat2'>Category: <input type='text' name ='cat' value='"+obligations[obgid-1].category+"'></input></div>";
		statusNum = parseInt(obligations[obgid-1].status);
		heading += "Status: <br> <select id='stat' selected="+statusNum+">";
		heading += "<option value=0>None</option>";
		heading += "<option value=1>In Progress</option>";
		heading += "<option value=2>Completed</option>";
		heading += "<option value=3>Important</option>";
		heading += "<option value=4>Requires Assistance</option></select></br>";
		obligid = parseInt(obligations[obgid-1].obligationid);
		heading += '<input type="button" value="close" onclick="closeView(this.value,'+obligid+')"/>';
		heading += '<input type="button" value="submit" onclick="closeView(this.value,'+obligid+' )"/>';
		$("#editContent").html(heading);
		$("#dial").show();
		var editor = document.getElementById( 'editForm' );
		editor.style.display = 'block';
		$("#obligations").hide();
		$("#sendTo").hide();
	});
}

function closeView(data, obgid)
{
    var nm = $("#name").val();
    var desc = $("#description").val();
    var startim = $("#stime").val();
    var endtim = $("#etime").val();
    var pri = $("#pri").val();
    var stat = $("#stat").val();
    var cat = $("#cat").val();
    var errMsg = "";
    var cont = true;

	if('close' == data)
	{
		$("#obligations").show();
		$("#sendTo").show();
		$("#dial").hide();
	}
	else if('submit' == data)
	{
        $.post('/obligations/'+obgid+"",{
                userid:"1",
                name: nm,
                description: desc,
                starttime: startim,
                endtime: endtim,
                priority: pri,
                status: stat,
                category: cat
            })
            .done(function (data) {
                  setTimeout(function() {
                    $.bootstrapGrowl("Data successfully received!", { 
                            type: 'success',
                            allow_dismiss: true,
                            align: 'center',
                            width: 'auto',
                            offset: {from: 'left', amount: 800}
                             });
                });
            })
            .fail(function (data) 
			{
                $.bootstrapGrowl("Failed to send in Obligation information! Please retry.", 
				{
                type: 'error',
                align: 'center',
                width: 'auto',
                offset: {from: 'top', amount: 200},
                allow_dismiss: true,
                delay: 5000,
				});
			});
			
		$("#obligations").show();
		$("#sendTo").show();
		$("#dial").hide();
	}
}
