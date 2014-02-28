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
        errMsg = errMsg + "Name incorrect (1-20 character range)\r\n";
    }
    if(desc.length > 200)
    {
        cont = false;
        errMsg = errMsg + "Description too long (200 character max)\r\n";
    }
    if(!$.isNumeric(pri))
    {
        cont = false;
        errMsg = errMsg + "Priority must be a number.\r\n";
    }
    if(!$.isNumeric(stat))
    {
        cont = false;
        errMsg = errMsg + "Status must be a number.\r\n";
    }
    if(!$.isNumeric(cat))
    {
        cont = false;
        errMsg = errMsg + "Category must be a number.\r\n";
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
                alert(data.result);
            })
            .fail(function (data) {
                alert(data.result);
        });
    }
    else
    {
        alert(errMsg.slice(0, -2));
    }
})
