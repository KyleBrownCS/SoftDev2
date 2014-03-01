function Obligation (obligationid,userid,name,description,startTime,endTime,priority,status,category)
{
    this.obligationid = obligationid;
    this.userid = userid;
	this.name = name
	this.description = description
	this.startTime = startTime
	this.endTime = endTime;
	this.priority = priority;
	this.status = status;
	this.category = category;
}
 
Obligation.prototype.get = function() {
    return this.obligationid;
};

