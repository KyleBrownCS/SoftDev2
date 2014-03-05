$(document).ready(function(e) { 
    $.get('/obligations', function(data) {
    	//Properly format data for exit.
    	var mydata = data.trim().replace(/\(/g, "");
    	mydata = mydata.replace(/\)/g, "");
    	var datas = mydata.split("|");
		//The column for status
		var statusNum = 0;
		var statusCol = 7;
		var statuses = ['none','In Progress','Completed','Important','Requires Assistance'];
		var obligationFields = ['obligationid','userid','name','description','startTime','endTime','priority','status','category'];
		var obligations = new Array();
    	var heading = "<table border='1'><th>ObligationID</th><th>UserID</th><th>Name</th><th>Description</th><th>StartTime</th><th>EndTime</th><th>Priority</th><th>Status</th><th>Category</th>";
    	var mainData = "";
    	var currline = "<tr>";
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
					//If it's processing a status, show the string instead of the integer value
					obligation[obligationFields[j]] = miniparts[j];
					if(j == statusCol)
					{
						statusNum = parseInt(obligation[obligationFields[j]]);
						currline = currline + "<td>" + statuses[statusNum] + "</td>";
					}
					else
					{
						currline = currline + "<td>" + obligation[obligationFields[j]] + "</td>";
					}

				}
				heading = heading + currline + "</tr>";
				currline = "<tr>";
				obligations.push(obligation);
			}
    	}
    	heading = heading + "</table>";




    	//Push data to screen in a presentable matter
    	$("#sendTo").append(heading);
		var currentDate = new Date();
		var currentMonth = currentDate.getMonth();
		var currentYear = currentDate.getFullYear();
		var calen = new Calendar(currentMonth,currentYear, obligations);
		calen.calculateCalendar();
		$('#sendTo').append(calen.gethtmlCode());
    });
});
