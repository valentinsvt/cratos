//var $j = jQuery.noConflict();

// Use jQuery via $j(...)
$(function(){

    $(".toggler").click(function() {
	var id = $(this).attr("cont");

	if($("#"+id).is(":hidden")) {
	    remove = "s";
	    add = "n";

	    rem = "all abre";
	    ad = "top cierra";

	} else {
	    remove = "n";
	    add = "s";

	    rem = "top cierra";
	    ad = "all abre";
	}

	$(this).removeClass("ui-corner-"+rem);
	$(this).addClass("ui-corner-"+ad);

	var src = $(this).attr("src");
	var loaded = $(this).attr("loaded");

	if(src && !loaded) {
	    $(this).attr("loaded",true);
	    alert("OK");
	    //esta abierto por primera vez: cargar con ajax el contenido

	    
	}
	$("#span_"+id).removeClass("ui-icon-triangle-1-"+remove);
	$("#span_"+id).addClass("ui-icon-triangle-1-"+add);

	$("#"+id).toggle("blind",{},500);

    });

    $('.table').dataTable( {
	"bPaginate": true,
	"sPaginationType": "full_numbers",
	"bLengthChange": false,
	"bSort": true,
	"bFilter": false,
	"bInfo": true,
	"oLanguage": {
	    "sProcessing":   "Procesando...",
	    "sLengthMenu":   "Mostrar _MENU_ registros",
	    "sZeroRecords":  "No se encontraron resultados",
	    "sInfo":         "Mostrando de _START_ a _END_ de _TOTAL_ registros",
	    "sInfoEmpty":    "Mostrando de 0 a 0 de 0 registros",
	    "sInfoFiltered": "(filtrado de _MAX_ registros en total)",
	    "sInfoPostFix":  "",
	    "sSearch":       "Buscar:",
	    "sUrl":          "",
	    "oPaginate": {
		"sFirst":    "Primero",
		"sPrevious": "Anterior",
		"sNext":     "Siguiente",
		"sLast":     "Último"
	    }
	}
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

});
