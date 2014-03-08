var sortTypeObligationId = 0;
var sortTypeUserId = 1;
var sortTypePriority = 2;
var sortTypeStatus = 3;

$(document).ready(function(e) {
    createSortedList(sortTypePriority)
});

function createSortedList(orderby){
    $.get('/obligations', function(data) {
        obligationList = eval (data);

        switch(orderby)
        {
            case sortTypeUserId: 
                obligationList.sort(function(a,b) {
                if (a.userid < b.userid)
                    return 1;
                if (a.userid > b.userid)
                    return -1;
                return 0;
                });
                break;
            case sortTypeObligationId:
                obligationList.sort(function(a,b) {
                if (a.obligationId < b.obligationId)
                    return 1;
                if (a.obligationId > b.obligationId)
                    return -1;
                return 0;
                });
                break;
            case sortTypePriority:
                obligationList.sort(function(a,b) {
                if (a.priority < b.priority)
                    return 1;
                if (a.priority > b.priority)
                    return -1;
                return 0;
                });
                break;
            case sortTypeStatus:
                obligationList.sort(function(a,b) {
                if (a.status < b.status)
                    return 1;
                if (a.status > b.status)
                    return -1;
                return 0;
                });
                break;
        }

        var statuses = ['none','In Progress','Completed','Important','Requires Assistance'];

        //generate the table
        var heading = "<table border='1'><th>ObligationID <button onclick='reorderListObligationId()'>Reorder</button></th><th>UserID <button onclick='reorderListUserId()'>Reorder</button></th><th>Name</th><th>Description</th><th>StartTime</th><th>EndTime</th><th>Priority <button onclick='reorderListPriority()'>Reorder</button></th><th>Status <button onclick='reorderListStatus()'>Reorder</button></th><th>Modify</th>";
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
}

function reorderListUserId() {
    createSortedList(sortTypeUserId)
}

function reorderListPriority() {
    createSortedList(sortTypePriority)
}

function reorderListObligationId() {
    createSortedList(sortTypeObligationId)
}

function reorderListStatus() {
    createSortedList(sortTypeStatus)
}

