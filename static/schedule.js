$(document).ready(function(e) { 
    $.get('/obligations', function(data) {
    	//Properly format data for exit.
    	var mydata = data.trim().replace(/\(/g, "");
    	mydata = mydata.replace(/\)/g, "");
    	var datas = mydata.split("|");
		//The column for status
		var statusNum = 0;
		var statuses = ['none','In Progress','Completed','Important','Requires Assistance'];
		var obligationFields = ['obligationid','userid','name','description','startTime','endTime','priority','status','category'];
		var obligations = new Array();
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
				}
				obligations.push(obligation);
			}
    	}




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
