$(function() {

    $(".frmBuscarAsg").submit(function() {
	return false;
    });

       $("#txtBuscar").bind('keyup',function(event){
	var keyCode = event.which;
	if ( keyCode == 13) {
	    enviar();
           
    }

	if($(this).val().length >= 0 && $("#error").parent().is(":visible")) {
	    $("#error").html("").parent().hide("slide");
	}
    });

    $("#buscarAseguradora").click(function() {
	var busca = $("#txtBuscar").val();
	
	    enviar();
	
    });

    function enviar() {
	$.ajax({
	    type: "POST",
	    url: "buscarAseguradora",
	    data: $(".frmBuscarAsg").serialize(),
	    success: function(msg){
		$("#divListaAseguradora").html(msg).show("slide");
		tablas();
	    }
	});
    }



    function tablas(tabla) {
	if(tabla == null)
	    tabla = ".table";
	try {
	    $(tabla).dataTable( {
		"bPaginate": true,
		"sPaginationType": "full_numbers",
		"bLengthChange": false,
		"bSort": true,
		"bFilter": false,
		"bInfo": true
	    } );


	    $('.hover tr').livequery(function() {
		$(this).hover(
		    function(){
			$(this).addClass("ui-state-hover");
		    },
		    function(){
			$(this).removeClass("ui-state-hover");
		    }
		    );
	    });
	} catch(ex) {}
    }
});
