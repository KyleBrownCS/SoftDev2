$( document ).ready(function() {

    $("#datepickerstart").datepicker({
        onSelect: function (selectedDate) {
            $("#datepickerend").datepicker( "setDate", selectedDate );
        }
    });
    $("#datepickerend").datepicker();
});


/*$("#datepickerstart").focusout(function() {
    var currentDate = $("#datepickerstart").val();
     $("#datepickerend").val(currentDate);

});*/

$("#name").focusout(function() {
    var nm = $("#name").val();

    if(nm.length > 20 || nm.length == 0 )
    {
        $.bootstrapGrowl("Name must be between 1 and 20 characters in length!", {
            type: 'info',
            align: 'center',
            width: 'auto',
            allow_dismiss: false,
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
            allow_dismiss: false,
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
            allow_dismiss: false,
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
            allow_dismiss: false,
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

$('#submit1').click(function() { 
    
    //basic client side validation
    var nm = $("#name").val();
    var desc = $("#description").val();
    var startim = $("#stime").val();
    var endtim = $("#etime").val();
    var pri = $("#pri").val();
    var stat = $("#stat").val();
    var cat = $("#cat").val();
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

    if(cont)
    {
        $.post('/obligations',{
                userid:"1",
                name: nm,
                description: desc,
                starttime: startim,
                endtime: endtim,
                priority: pri,
                status: stat,
                category: cat
            })
            .done(function (data) {
                  setTimeout(function() {
                    $.bootstrapGrowl("Data successfully received!", { 
                            type: 'success',
                            allow_dismiss: true,
                            align: 'center',
                            width: 'auto',
                            offset: {from: 'top', amount: 200}
                             });
                });
            })
            .fail(function (data) {
                $.bootstrapGrowl("Failed to send in Obligation information! Please retry.", {
                type: 'info',
                align: 'center',
                width: 'auto',
                offset: {from: 'top', amount: 200},
                allow_dismiss: true,
                delay: 5000,
              });
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
})
