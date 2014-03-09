function bootdatepickers(num, field){

    $("#datepickerstart").datepicker({
        onSelect: function (selectedDate){
            var temp = $("#datepickerend").datepicker('getDate');
            
            if(temp == null)
            {
                $("#datepickerend").datepicker('setDate', selectedDate);
                $("#datepickerend").datepicker('option', 'minDate', new Date($("#datepickerstart").val()));
            }

            /*else{
                //TODO: Validate that the new start date is before the end date. If not, make red, alert user.
                ;
            }*/

            //Presently, assume that they fixed their issue.
            $('#datepickerstart2').css('background-color', '');
            $('#datepickerend2').css('background-color', '');
        }
    });

    $("#datepickerend").datepicker({
        onSelect: function (selectedDate) {
            var startDate = $("#datepickerstart").datepicker("getDate");
            var endDate = $("#datepickerend").datepicker("getDate");
            
            if(startDate > endDate)
            {
                $('#datepickerstart2').css('background-color', 'red');
                $('#datepickerend2').css('background-color', 'red');
                $.bootstrapGrowl("Your start date is after your end date! Please fix this issue.", {
                    type: 'info',
                    align: 'center',
                    width: 'auto',
                    allow_dismiss: true,
                    offset: {from: 'top', amount: 200}
                });
            }

            else
            {
                $('#datepickerstart2').css('background-color', '');
                $('#datepickerend2').css('background-color', '');
            }
        }
    });
}

function convertDateTimes(date, time){
    var result = ISO8601Converter(date);
    if(time)
    {
        result = result + " " + timeConverter(time);
    }
    return result;
}

function ISO8601Converter(rawDate){ //"YYYY-MM-DD"
    return rawDate.getUTCFullYear() + "-" + zeroPad((rawDate.getMonth() + 1), '00') + "-" + zeroPad(rawDate.getDate(), '00');
}

function timeConverter(rawTime){ //"HH:MM:SS.SSS"
    return zeroPad(rawTime.getHours(), '00') + ":" + zeroPad(rawTime.getMinutes(), '00') + ":" + zeroPad(rawTime.getSeconds(), '00') + "." + zeroPad(rawTime.getMilliseconds(), '000');
}

function zeroPad(num, field){
    return field.substring(0, field.length - num.toString().length) + num;
}
