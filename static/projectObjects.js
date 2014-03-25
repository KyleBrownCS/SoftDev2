function Obligation (obligationid, userid, name, description, startTime, endTime, priority, status, category)
{
    this.obligationid = obligationid;
    this.userid = userid;
	this.name = name;
	this.description = description;
	this.startTime = startTime;
	this.endTime = endTime;
	this.priority = priority;
	this.status = status;
	this.category = category;
	this.startDate = null;
	this.endDate = null;
}

function Obligation (obligationid, userid, name, description, startTime, endTime, priority, status, category, startDate, endDate)
{
    this.obligationid = obligationid;
    this.userid = userid;
	this.name = name;
	this.description = description;
	this.startTime = startTime;
	this.endTime = endTime;
	this.priority = priority;
	this.status = status;
	this.category = category;
	this.startDate = startDate;
	this.endDate = endDate;
}

Obligation.prototype.toString = function() {
    return "Name: "+ this.name + "\nDescription: "+this.description+ "\nStart time:"+this.startTime+"\nEnd Time:"+this.endTime+"\n";
}

function deleteObligation(obligation_id) {
    var path = "/obligations/" + obligation_id;
    $.ajax({
        url: path,
        type: 'DELETE',
        success: function() {
            obligationDeleteSuccess();
            loadObligationList();
        },
        error: function(){
            obligationDeleteFailure();
        }
    });
}

function obligationDeleteSuccess()
{
    $.bootstrapGrowl("Obligation was successfully deleted!", { 
        type: 'success',
        allow_dismiss: true,
        align: 'center',
        width: 'auto',
        offset: {from: 'top', amount: 200}
    });
}

function obligationDeleteFailure()
{
    $.bootstrapGrowl("We were unable to delete the obligaion ! Try again shortly.", { 
        type: 'info',
        allow_dismiss: true,
        align: 'center',
        width: 'auto',
        offset: {from: 'top', amount: 200}
    });
}
