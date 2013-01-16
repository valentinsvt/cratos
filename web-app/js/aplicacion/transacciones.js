$(function() {
    $("#guardarProceso").click(function() {

        if ($(".frmProceso").validate())
            $(".frmProceso").submit();

    });
});


