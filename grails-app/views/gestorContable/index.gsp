<html>

    <head>
        <title>cratos - Gestor Contable</title>
        <meta name="layout" content="main"/>

        <script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.dataTables.js')}'></script>
        <link rel='stylesheet' href='${createLinkTo(dir: 'js/jquery/css', file: 'jquery.dataTables.css')}'/>
        <script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.validate.js')}'></script>
    </head>

    <body>
        <div class="container entero ui-widget-content ui-corner-all">
            <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 10px; padding: 5px;">Buscar gestores contables</h1>

            <div style="width: 800px;height: 40px; padding:10px;">
                <g:link class="btn" action="nuevoGestor">Nuevo</g:link>
            </div>

            <div id="divContenido">
                <g:form action="buscarGestor" class="buscarGestor">

                    <div class="ui-state-error ui-corner-all ui-helper-hidden" style="padding: 5px; margin-bottom: 10px;">
                        <span class="icon ui-icon ui-icon-alert" style="margin-top: 0; margin-right: 10px;"></span>
                        <span id="error">error!</span>
                    </div>

                    <div class="span-6">
                        <label style="margin-left: 10px">Nombre:</label>
                        <input type="text" name="nombre" id="txtBusca" class="onlyNumbers ui-widget-content ui-corner-all"/>
                    </div>

                    <div class="span-4">
                        <a href="#" id="buscarGestor" class="btn">
                            Buscar
                        </a>
                    </div>
                </g:form>
            </div>

            <div id="divLista" style="clear: both; padding: 5px; margin-top: 5px;">

            </div>

            <script type="text/javascript">


                $(function () {
                    $(".btn").button({
                        icons : {
                            primary : "ui-icon-document"
                        }
                    });

                    $("#buscarGestor").button("option", "icons", {primary : 'ui-icon-search'});

                    var band = 1
                    $("#buscar").click(function () {
                        $.ajax({
                            type    : "POST",
                            url     : "${g.createLink(controller:'gestorContable',action: 'buscarGestor')}",
                            data    : "nombre=" + $('#nombreBus').val() + "&codigo=" + $("#codigoBus").val(),
                            success : function (msg) {
                                $('#divPlanCuentas').html(" ")
                                $('#divPlanCuentas').html(msg);
                                var b = true

                            }
                        })
                    });

                    $("#tipo").change(function () {
                        $.ajax({
                            type    : "POST",
                            url     : "cambiarComprobante",
                            data    : "tc=" + $(this).val(),
                            success : function (msg) {
                                $("#agregarCuentas").html(msg)

                            }
                        })
                    });

                    $("form:eq(0)").submit(function () {
                        return false;
                    });

                    $("#txtBusca").bind('keyup', function (event) {
                        var keyCode = event.which;
                        if (keyCode == 13) {
                            enviar();
                        }
                        if ($(this).val().length >= 0 && $("#error").parent().is(":visible")) {
                            $("#error").html("").parent().hide("slide");
                        }
                    });

                    $("#buscarGestor").click(function () {
                        enviar();
                    });

                    function enviar() {
                        $.ajax({
                            type    : "POST",
                            url     : "buscarGestor",
                            data    : $(".buscarGestor").serialize(),
                            success : function (msg) {
                                $("#divLista").html(msg).show("slide");

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
            </script>
        </div> <!-- container -->
    </body>

</html>