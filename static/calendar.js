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
var obligations = null;

//Constructor for the calendar. Useful
//when we need to construct next/previous month
function Calendar(month, year, obligs)
{
	obligations = obligs;
	this.calenMonth = month;
	this.calenYear = year;
	this.htmlCode = '';
}

Calendar.prototype.calculateCalendar = function()
{
	var day = 1;
	//Maximum amount of weeks to print on one month
	var maxWeekLines = 6;
	var outOfDays = 0;
	var dateString = "";
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
	if(prevMonth == -1)
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
	htmlCode += '<img src="static/img/leftArrow.png" onclick="generateNextMonth('+prevMonth+', '+prevYear+')"/>'
	htmlCode +=  monthName + "&nbsp;" + this.calenYear;
	htmlCode += '<img src="static/img/rightArrow.png" onclick="generateNextMonth('+nextMonth+', '+nextYear+')"/>'
	htmlCode += '</th></tr>';
	htmlCode += '<tr class="calendar-header">';
	//Initialize Monday-Sunday headers
	for(var i = 0; i <= 6; i++ )
	{
		htmlCode += '<td  width="130">';
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
					if(day == currentDay && currentMonth == this.calenMonth && currentYear == this.calenYear)
					{
						//alert("You have one or more obligation today! Check them on your schedule");
						if(this.checkDayForObligations(dateString) == 1)
							alert("You have one or more obligation today! Check them on your schedule");
						htmlCode += '<b><span style="color:red; ">'+day+'</span></b>';
					}
					else
						htmlCode += day;
						
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

//A prototype to get the htmlCode generated table for the month.
Calendar.prototype.gethtmlCode = function() 
{
  return this.htmlCode;
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
			tempDate = obligations[i].starttime;
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
	var obligationList = null;
	
    $.get('/obligations/'+startTime, function(data) 
	{
		obligationList = eval(data);
		
		var heading = "<table border='1'><th>Name</th><th>Description</th><th>StartTime</th><th>EndTime</th><th>Priority </th><th>Status</th><th>Modify</th><th>Delete</th>";
		for (var i = 0; i < obligationList.length; i++)
		{
			var currObligation = obligationList[i];
			var obgid = currObligation.obligationid;
			var currline = "<tr><td>";
			currline += currObligation.name + "<td>";
			currline += currObligation.description + "<td>";
			currline += currObligation.starttime + "<td>";
			currline += currObligation.endtime + "<td>";
			currline += String(currObligation.priority) + "<td>";
			currline += statuses[currObligation.status]  + "<td>";

			heading += currline + '<button onclick="editOglibation('+(obgid-1)+')">Edit</button>' + '<td>';
			heading += "<button onclick='deleteObligation("+ (obgid-1) +")'>Delete</button>" + "</tr>";
		}
		heading += "</table>";
		$("#obligations").html(heading);
		window.scrollTo(0,document.body.scrollHeight);
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

		$("#editContent").append('<form> \
  <div id="name2">Name: <input type="text" id="name"></div>\
  <div id="description2">Description: <input type="text" id="description"></div>\
  <div id="datepickerstart2">Start Date: <input type="text" id="datepickerstart"></div>\
  <div id="stime2">Start time (If Applicable): <input id="stime" type="text" class="time ui-timepicker-input" autocomplete="off"></div>\
  <div id="datepickerend2">End Date: <input type="text" id="datepickerend"></div>\
  <div id="etime2">End time (If Applicable): <input id="etime" type="text" class="time ui-timepicker-input" autocomplete="off"></div>\
  <div id="pri2">Priority: <input type="text" id="pri"></div>\
  <div id="cat2">Category: <input type="text" id="cat"></div>\
  Status:\
  <select id="stat">\
  <option value=0>None</option>\
  <option value=1>In Progress</option>\
  <option value=2>Completed</option>\
  <option value=3>Important</option>\
  <option value=4>Requires Assistance</option>\
  </select><br>\
</form>');
		$("#name").val(obligations[obgid-1].name);
		$("#description").val(obligations[obgid-1].description);

		bootdatepickers();  //External file datepickerLoad.js

		var timeParts;
		var values;
		var startDate;
		var startTime;
		var endDate;
		var endTime;

		timeParts = obligations[obgid-1].starttime
		timeParts = timeParts.split(" ");
		values = timeParts[0].split('-');
		startDate = new Date(values[0], (parseInt(values[1])-1).toString(), values[2]);

		if(timeParts.length == 2)
		{
			var values2 = timeParts[1].replace(".", ":").split(":");
			startTime = new Date(values[0], (parseInt(values[1]) - 1).toString(), values[2], values2[0], values2[1], values2[2], values2[3]);
		}
		else
		{
			startTime = "";
		}

		timeParts = obligations[obgid-1].endtime.split(" ");
		values = timeParts[0].split('-');
		endDate = new Date(values[0], (parseInt(values[1]) - 1).toString(), values[2], 0, 0, 0, 0);

		if(timeParts.length == 2)
		{
			var values2 = timeParts[1].replace(".", ":").split(":");
			endTime = new Date(values[0], (parseInt(values[1]) - 1).toString(), values[2], values2[0], values2[1], values2[2], values2[3]);
		}
		else
		{
			endTime = "";
		}

		$("#datepickerstart").datepicker("setDate", startDate);
		$("#datepickerend").datepicker("setDate", endDate);

		$("#stime").timepicker({ 'scrollDefaultNow': true });
    	$("#etime").timepicker({ 'scrollDefaultNow': true });
		$("#stime").timepicker('setTime', startTime);
		$("#etime").timepicker('setTime', endTime);


		$("#pri").val(obligations[obgid-1].priority);
		$("#cat").val(obligations[obgid-1].category);
		statusNum = parseInt(obligations[obgid-1].status);
		$("#stat").val(statusNum);
		obligid = parseInt(obligations[obgid-1].obligationid);

		heading += '<input type="button" value="close" onclick="closeView(this.value,' + obligid + ')"/>';
		heading += '<input type="button" value="submit" onclick="closeView(this.value,' + obligid + ' )"/>';
		heading += '<input type="button" value="clear" onclick="closeView(this.value,' + obligid + ' )"/>';
		$("#editContent").append(heading);
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
    var stardate = $("#datepickerstart").datepicker('getDate');
    var enddate = $("#datepickerend").datepicker('getDate');
    var startim = $("#stime").timepicker('getTime');
    var endtim = $("#etime").timepicker('getTime');
    var pri = $("#pri").val();
    var stat = $("#stat").val();
    var cat = $("#cat").val();
    var errMsg = "";
    var cont = true;
	
	
	
	if('clear' == data)
	{
		$("#name").val("");
		$("#description").val("");
		$("#datepickerstart").val("");
		$("#datepickerend").val("");
		$('#stime').val("");
		$('#etime').val("");
		$("#pri").val("");
		$("#stat").val("");
		$("#cat").val("");
	}
	if('close' == data)
	{
		$("#obligations").show();
		$("#sendTo").show();
		$("#dial").hide();
	}
	else if('submit' == data)
	{
		if(nm.length > 20 || nm.length == 0 )
		{
			cont = false;
			$('#name2').css('background-color', 'red');
		}
		if(desc.length > 200)
		{
			cont = false;
			$('#description2').css('background-color', 'red');
		}
		if(!$.isNumeric(pri))
		{
			cont = false;
			$('#pri2').css('background-color', 'red');
		}
		//New errorcheck for dropdown status bar
		if(stat > 4 && stat < 0)
		{
			cont = false;
			$('#stat2').css('background-color', 'red');
		}
		if(!$.isNumeric(cat))
		{
			cont = false;
			$('#cat2').css('background-color', 'red');
		}
			
		//Convert dates into properly formatted types
		startim = convertDateTimes(stardate, startim);   //external file datePickerLoad.js
		endtim = convertDateTimes(enddate, endtim);       //external file datePickerLoad.js
		if (cont)
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
	                    $.bootstrapGrowl("Your settings have been changed!", { 
	                        type: 'success',
	                        allow_dismiss: true,
	                        align: 'center',
	                        width: 'auto',
	                        offset: {from: 'top', amount: 200}
	                    });
	                });
					
					$("#obligations").show();
					$("#sendTo").show();
					$("#dial").hide();
					location.reload();
			    })
	            .fail(function (data) {
	                $.bootstrapGrowl("Failed to send in data. Please try again.", {
	                type: 'info',
	                align: 'center',
	                width: 'auto',
	                offset: {from: 'top', amount: 200},
	                allow_dismiss: true,
	                delay: 5000,
	              });
	        });
	    }
	    else
		{
			$.bootstrapGrowl("Please fix the selections labeled in red before trying to submit your obligation", {
				type: 'info',
				align: 'center',
				width: 'auto',
				offset: {from: 'top', amount: 200},
				allow_dismiss: true,
				delay: 5000,
			  });
		}
	}
}
