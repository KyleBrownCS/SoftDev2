$('#submit1').click(function() { 
    $.post('/obligations',{
            userid:"1",
            name: $("#name").val(),
            description: $("#description").val(),
            starttime: $("#stime").val(),
            endtime: $("#etime").val(),
            priority: $("#pri").val(),
            status: $("#stat").val(),
            category: $("#cat").val()
        })
        .done(function (data) {
            alert(data.result);
        })
        .fail(function (data) {
            alert(data.result);
        });
})