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

    	var heading = "<table border='1'><th>ObligationID</th><th>UserID</th><th>Name</th><th>Description</th><th>StartTime</th><th>EndTime</th><th>Priority</th><th>Status</th><th>Category</th>";
    	var mainData = "";
    	var currline = "<tr>"
    	for (var i = 0; i < datas.length; i++)
    	{
    		var miniparts = datas[i].trim().split(",");
    		for (var j = 0; j < miniparts.length; j++)
    		{
    			miniparts[j] = miniparts[j].replace(/\u'/g, "");
    			miniparts[j] = miniparts[j].replace(/\'/g, "");
				//If it's processing a status, show the string instead of the integer value
				if(j == statusCol)
				{
					statusNum = parseInt(miniparts[j]);
					currline = currline + "<td>" + statuses[statusNum] + "</td>";
				}
				else
				{
					currline = currline + "<td>" + miniparts[j] + "</td>";
				}
    		}
    		heading = heading + currline + "</tr>";
    		currline = "<tr>";
    	}
    	heading = heading + "</table>";




    	//Push data to screen in a presentable matter
    	$("#sendTo").append(heading);

    });
});
