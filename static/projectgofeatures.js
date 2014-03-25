$(document).ready(function() {

    bootdatepickers(); //external file datepickerLoad.js

    $("#stime").timepicker({ 'scrollDefaultNow': true });
    $("#etime").timepicker({ 'scrollDefaultNow': true });
});

$("#stime").change(function(){
    var thetime = $("#stime").timepicker('getTime');
    var hours = thetime.getHours();
    var etime = $("#etime").timepicker('getTime');
    const HR_MILI = 3600000;

    if(etime == null || etime.getTime() < thetime.getTime() + HR_MILI)
    {
        $("#etime").timepicker('setTime', new Date(thetime.setHours(thetime.getHours() + 1)));
    }
});

$("#name").focusout(function(){
    var nm = $("#name").val();

    if(nm.length > 20 || nm.length == 0 )
    {
        $.bootstrapGrowl("Name must be between 1 and 20 characters in length!", {
            type: 'info',
            align: 'center',
            width: 'auto',
            allow_dismiss: true,
            offset: {from: 'top', amount: 200}
        });
        $('#name2').css('background-color', '');
        $('#name2').css('background-color', 'red');
    }
    else
    {
        $('#name2').css('background-color', '');
    }
});

$("#description").focusout(function() {

    var desc = $("#description").val().length;
    if(desc > 200)
    {
        $.bootstrapGrowl("Description must be less than 20 characters in length! (You're currently at" + desc.toString(), {
            type: 'info',
            align: 'center',
            width: 'auto',
            allow_dismiss: true,
            offset: {from: 'top', amount: 200}
        });

        $('#description2').css('background-color', '');
        $('#description2').css('background-color', 'red');
    }
    else
    {
        $('#description2').css('background-color', '');
    }
});

$("#pri").focusout(function() {

    if(!$.isNumeric($("#pri").val()))
    {
        $.bootstrapGrowl("Priority must be a number!", {
            type: 'info',
            align: 'center',
            width: 'auto',
            allow_dismiss: true,
            offset: {from: 'top', amount: 200}
        });

        $('#pri2').css('background-color', '');
        $('#pri2').css('background-color', 'red');
    }
    else
    {
        $('#pri2').css('background-color', '');
    }
});

$("#cat").focusout(function() {

    if(!$.isNumeric($("#cat").val()))
    {
        $.bootstrapGrowl("Category must be a number!", {
            type: 'info',
            align: 'center',
            width: 'auto',
            allow_dismiss: true,
            offset: {from: 'top', amount: 200}
        });

        $('#cat2').css('background-color', '');
        $('#cat2').css('background-color', 'red');
    }
    else
    {
        $('#cat2').css('background-color', '');
    }
});

$('#clear').click(function() { 
    $("#name").val("");
    $("#description").val("");
    $("#datepickerstart").val("");
    $("#datepickerend").val("");
    $('#stime').val("");
    $('#etime').val("");
    $("#pri").val("");
    $("#stat").val("");
    $("#cat").val("");
})

function getObligInfo()
{
	var tOblig = new Obligation("0","1","Name","Description","2013-03-30 18:18:18.022","2015-01-30 18:18:18.022","1","2","1");
    tOblig.name = $("#name").val();
    tOblig.description = $("#description").val();
    tOblig.startDate = $("#datepickerstart").datepicker('getDate');
    tOblig.endDate = $("#datepickerend").datepicker('getDate');
    tOblig.startTime = $('#stime').timepicker('getTime');
    tOblig.endTime = $('#etime').timepicker('getTime');
    tOblig.pri = $("#pri").val();
    tOblig.stat = $("#stat").val();
    tOblig.cat = $("#cat").val();
	return tOblig;
}



function addObligation(obligation, mode)
{
    var nm = obligation.name;
    var desc = obligation.description;
    var stardate = obligation.startDate;
    var enddate = obligation.endDate;
    var startime = obligation.startTime;
    var endtime = obligation.endTime;
    var pri = obligation.pri;
    var stat = obligation.stat;
    var cat = obligation.cat;
    var errMsg = "";
    var cont = true;

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

    //Check if dates are same day and the time is legal (no due date before date start)
    if (stardate == null && enddate == null && mode != 'test')
    {
        $('#datepickerstart2').css('background-color', 'red');
        $('#datepickerend2').css('background-color', 'red');
        cont = false;

        $.bootstrapGrowl("You must set an end date or a range of days for your obligation to take place!", {
            type: 'info',
            align: 'center',
            width: 'auto',
            allow_dismiss: true,
            offset: {from: 'top', amount: 200}
        });
    }
    if(startime != null && endtime == null && mode != 'test')
    {
        $('#stime2').css('background-color', 'red');
        $('#etime2').css('background-color', 'red');
        cont= false;

        $.bootstrapGrowl("You need an end time or if you only want an end time, please remove the start time.", {
            type: 'info',
            align: 'center',
            width: 'auto',
            allow_dismiss: true,
            offset: {from: 'top', amount: 200}
        });
    }
    else if(startime != null && endtime != null && mode != 'test')
    {
        if(stardate.getTime() == enddate.getTime() && startime.getTime() > endtime.getTime())
        {
            $('#stime2').css('background-color', 'red');
            $('#etime2').css('background-color', 'red');
            cont= false;

            $.bootstrapGrowl("Your end time is after your start time! Fix this by adjusting your times.", {
                type: 'info',
                align: 'center',
                width: 'auto',
                allow_dismiss: true,
                offset: {from: 'top', amount: 200}
            });
        }
    }

    if(cont)
    {
        //Convert dates into properly formatted types
		if(mode != 'test')
		{
			starttim2 = convertDateTimes(stardate, startime);  //external file datePickerLoad.js
			endtime2 = convertDateTimes(enddate, endtime);     //external file datePickerLoad.js
		}
		//If we're testing, the format is already correct.
		else
		{
			starttim2 = stardate + " " +startime;
			endtime2 = enddate + " " + endtime;
		}
        $.post('/obligations', {
                userid:"1",
                name: nm,
                description: desc,
                starttime: starttim2,
                endtime: endtime2,
                priority: pri,
                status: stat,
                category: cat
            })
            .done(function (data) {
			if(mode != 'test')
                obligationSendSuccess();
            })
            .fail(function (data) {
			if(mode != 'test')
                obligationSendFailure();
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

$('#submit1').click(function() { 
    var obligation = new Obligation();
	obligation = getObligInfo();
    //basic client side validation
	addObligation(obligation, 'app');
})

function obligationSendSuccess()
{
    $.bootstrapGrowl("Data successfully received!", { 
        type: 'success',
        allow_dismiss: true,
        align: 'center',
        width: 'auto',
        offset: {from: 'top', amount: 200}
    });
}

function obligationSendFailure()
{
    $.bootstrapGrowl("Failed to send in Obligation information! Please retry.", {
        type: 'info',
        align: 'center',
        width: 'auto',
        offset: {from: 'top', amount: 200},
        allow_dismiss: true,
        delay: 5000,
    });
}
