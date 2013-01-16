$(function() {
    var band=1
    $("#buscar").click(function() {
        $.ajax({
            type: "POST",
            url: "buscarCuentas",
            data: "nombre="+$('#nombreBus').val()+"&codigo="+$("#codigoBus").val(),
            success: function(msg){
                $('#divPlanCuentas').html(" ")
                $('#divPlanCuentas').html(msg);
                var b=true
		
            }
        })
    });

    $("#tipo").change(function(){
        $.ajax({
            type: "POST",
            url: "cambiarComprobante",
            data: "tc="+$(this).val(),
            success: function(msg){
                $("#agregarCuentas").html(msg)

            }
        })
    });
  
    $("form:eq(0)").submit(function() {
        return false;
    });

    $("#txtBusca").bind('keyup',function(event){
        var keyCode = event.which;
        if ( keyCode == 13) {
            enviar();
        }
        if($(this).val().length >= 0 && $("#error").parent().is(":visible")) {
            $("#error").html("").parent().hide("slide");
        }
    });

    $("#buscarGestor").click(function() {
        enviar();
    });

    function enviar() {
        $.ajax({
            type: "POST",
            url: "buscarGestor",
            data: $(".buscarGestor").serialize(),
            success: function(msg){
                $("#divLista").html(msg).show("slide");
                tablas();
            }
        });
    }
//
//    $("#guardarGestor").livequery(function() {
//        $(this).click(function(){
//            $(".frmGestor").submit()
//        })
//
//    });
//    $("#editarGestor").livequery(function() {
//        $(this).click(function(){
//            $(".frmGestor").submit()
//
//        })
//
//    });
//
//    function tablas(tabla) {
//        if(tabla == null)
//            tabla = ".table";
//        try {
//            $(tabla).dataTable( {
//                "bPaginate": true,
//                "sPaginationType": "full_numbers",
//                "bLengthChange": false,
//                "bSort": true,
//                "bFilter": false,
//                "bInfo": true,
//                "oLanguage": {
//                    "sProcessing":   "Procesando...",
//                    "sLengthMenu":   "Mostrar _MENU_ registros",
//                    "sZeroRecords":  "No se encontraron resultados",
//                    "sInfo":         "Mostrando de _START_ a _END_ de _TOTAL_ registros",
//                    "sInfoEmpty":    "Mostrando de 0 a 0 de 0 registros",
//                    "sInfoFiltered": "(filtrado de _MAX_ registros en total)",
//                    "sInfoPostFix":  "",
//                    "sSearch":       "Buscar:",
//                    "sUrl":          "",
//                    "oPaginate": {
//                        "sFirst":    "Primero",
//                        "sPrevious": "Anterior",
//                        "sNext":     "Siguiente",
//                        "sLast":     "Último"
//                    }
//                }
//            } );
//
//
//            $('.hover tr').livequery(function() {
//                $(this).hover(
//                    function(){
//                        $(this).addClass("ui-state-hover");
//                    },
//                    function(){
//                        $(this).removeClass("ui-state-hover");
//                    }
//                    );
//            });
//        } catch(ex) {}
//    }
});