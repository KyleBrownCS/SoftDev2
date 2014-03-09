var sortTypeName = 0;
var sortTypePriority = 1;
var sortTypeStatus = 2;

var obligationList = null;

$(document).ready(function(e) {
    $.get('/obligations', function(data) {
        obligationList = eval(data);
        createSortedList(sortTypePriority);
    });
});

function createSortedList(orderby){
    switch(orderby) {
        case sortTypeName:
            obligationList.sort(function(a,b) {
                if (a.name > b.name)
                    return 1;
                if (a.name < b.name)
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
    var heading = "<table border='1'><th>Name<button onclick='reorderListName()'>Reorder</button></th><th>Description</th><th>StartTime</th><th>EndTime</th><th>Priority <button onclick='reorderListPriority()'>Reorder</button></th><th>Status <button onclick='reorderListStatus()'>Reorder</button></th><th>Modify</th>";
    for (var i = 0; i < obligationList.length; i++)
    {
        var currObligation = obligationList[i];
        var currline = "<tr><td>";
        currline += currObligation.name + "<td>";
        currline += currObligation.description + "<td>";
        currline += currObligation.starttime + "<td>";
        currline += currObligation.endtime + "<td>";
        currline += String(currObligation.priority) + "<td>";
        currline += statuses[currObligation.status]  + "<td>";

        heading += currline + "<button onclick='deleteObligation("+ currObligation.obligationid +")'>Delete</button>" + "</tr>";
    }
    heading += "</table>";

    $('#sendTo').html(heading);
}

function reorderListPriority() {
    createSortedList(sortTypePriority)
}

function deleteObligation(obligation_id) {
    var path = "/obligations/" + obligation_id;
    $.ajax({
        url: path,
        type: 'DELETE',
        success: function() {
            alert('Obligation has successfully been Deleted.');
        },
        error: function(){
            alert('error! could not delete ' + obligation_id);
        }
    });
}

function reorderListName() {
    createSortedList(sortTypeName)
}

function reorderListStatus() {
    createSortedList(sortTypeStatus)
}

