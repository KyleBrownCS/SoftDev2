$(document).ready(function(e) { 
    $.get('/obligations', function(data) {

    	//Properly format data for exit.
    	var mydata = data.trim().replace(/\(/g, "");
    	mydata = mydata.replace(/\)/g, "");
    	var datas = mydata.split("|");

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
    			currline = currline + "<td>" + miniparts[j] + "</td>";
    		}
    		heading = heading + currline + "</tr>";
    		currline = "<tr>";
    	}
    	heading = heading + "</table>";




    	//Push data to screen in a presentable matter
    	$("#sendTo").append(heading);

    });
});
