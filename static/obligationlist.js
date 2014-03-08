$(document).ready(function(e) {
    $.get('/obligations', function(data) {
        obligationList = eval (data)

        obligationList.sort(function(a,b){
        if (a.priority < b.priority)
            return 1;
        if (a.priority > b.priority)
            return -1;
        return 0;
        });

        var statuses = ['none','In Progress','Completed','Important','Requires Assistance'];

        //generate the table
        var heading = "<table border='1'><th>ObligationID</th><th>UserID</th><th>Name</th><th>Description</th><th>StartTime</th><th>EndTime</th><th>Priority</th><th>Status</th><th>Modify</th>";
        for (var i = 0; i < obligationList.length; i++)
        {
            var currObligation = obligationList[i];
            var currline = "<tr><td>";
            currline += currObligation.obligationid + "<td>";
            currline += currObligation.userid + "<td>";
            currline += currObligation.name + "<td>";
            currline += currObligation.description + "<td>";
            currline += currObligation.starttime + "<td>";
            currline += currObligation.endtime + "<td>";
            currline += String(currObligation.priority) + "<td>";
            currline += statuses[currObligation.status]  + "<td>";

            heading += currline + "</tr>";
        }
        heading += "</table>";

        $('#sendTo').html(heading);
    });
});
