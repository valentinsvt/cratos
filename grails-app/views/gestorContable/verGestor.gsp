<html>
    <head>
        <title>cratos - Gestor Contable</title>
        <meta name="layout" content="main"/>
        <style type="text/css">

        .totales {
            font-weight : bold;
            text-align  : center;
        }
        </style>

    </head>

    <body>

        <div id="summary"/>
        <g:form name="gestorForm" action="nuevoGestor" method="post" class="frmGestor">
            <input type="hidden" name="id" id="id" value="${gestor?.id}"/>
        </g:form>
        <div class="container entero ui-widget-content ui-corner-all">
            <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 5px; margin-left: 8px;height: 30px;line-height: 30px;padding-left: 30px;">Gestor contable: ${gestor?.nombre}</h1>

            <g:link action="index" class="tbbtn btn" name="editarGestor" style="margin: 0 0 20px 80px;">
                Lista de gestores
            </g:link>
            <g:link action="nuevoGestor" id="${gestor.id}" class="tbbtn btn" name="editarGestor" style="margin: 0 0 20px 10px;">
                Editar
            </g:link>
            <g:link action="deleteGestor" id="${gestor.id}" class="tbbtn btn" name="eliminarGestor" style="margin: 0 0 20px 10px;">
                Eliminar
            </g:link>

            <div style="width: 700px;height: 30px;margin-left: 80px;"><b>Nombre:</b> ${gestor?.nombre}</div>

            <div style="width: 700px;height: 30px;margin-left: 80px;"><b>Descripción:</b> ${gestor?.descripcion}</div>

            <div style="width: 700px;height: 30px;margin-left: 80px;"><b>Estado:</b> ${(gestor.estado == 'A') ? 'Activo' : 'Inactivo'}
            </div>

            <div style="width: 700px;height: 30px;margin-left: 80px;"><b>Observaciones:</b> ${gestor?.observaciones}
            </div>
            <br>
            <g:if test="${cuentas?.size() > 0}">
                <div style="width: 800px;margin: auto;margin-bottom: 30px">
                    <table width="400px">
                        <thead>
                            <tr>
                                <th>&nbsp;</th>
                                <th colspan="3"><center>Debe</center></th>
                                <th colspan="3"><center>Haber</center></th>
                            </tr>
                            <tr>
                                <th>C&oacute;digo(nombre)</th>

                                <th>Porcentaje</th>
                                <th>Impuestos</th>
                                <th>Valor</th>

                                <th>Porcentaje</th>
                                <th>Impuestos</th>
                                <th>Valor</th>

                            </tr>
                        </thead>
                        <tbody>
                            <g:set var="por" value="${0}"/>
                            <g:set var="imp" value="${0}"/>
                            <g:set var="val" value="${0}"/>
                            <g:set var="porH" value="${0}"/>
                            <g:set var="impH" value="${0}"/>
                            <g:set var="valH" value="${0}"/>
                            <g:each var="genera" in="${cuentas}" status="i">
                                <tr>
                              <td style="text-align: left">${genera.cuenta.numero + '(' + genera.cuenta.descripcion + ')'}</td>
                                <g:if test="${genera.debeHaber == 'D'}">
                                    <td style="text-align: center">${genera.porcentaje ?: 0}</td>
                                    <td style="text-align: center">${genera.porcentajeImpuestos ?: 0}</td>
                                    <td style="text-align: center">${genera.valor ?: 0}</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>

                                    </tr>
                                    <g:set var="por" value="${por + genera.porcentaje ?: 0}"/>
                                    <g:set var="imp" value="${imp + genera.porcentajeImpuestos ?: 0}"/>
                                    <g:set var="val" value="${val + genera.valor ?: 0}"/>
                                </g:if>
                                <g:else>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td style="text-align: center">${genera.porcentaje ?: 0}</td>
                                    <td style="text-align: center">${genera.porcentajeImpuestos ?: 0}</td>
                                    <td style="text-align: center">${genera.valor ?: 0}</td>

                                    <g:set var="porH" value="${porH + genera.porcentaje ?: 0}"/>
                                    <g:set var="impH" value="${impH + genera.porcentajeImpuestos ?: 0}"/>
                                    <g:set var="valH" value="${valH + genera.valor ?: 0}"/>
                                </g:else>
                                </tr>
                            </g:each>
                            <tr>
                                <td style="text-align: right; font-weight:bold; background-color: #d0ffd0">TOTALES:</td>
                                <td class="totales" style="background-color: ${(por == porH) ? '#d0ffd0' : '#ffd0d0'};">${por}</td>
                                <td class="totales" style="background-color: ${(imp == impH) ? '#d0ffd0' : '#ffd0d0'};">${imp}</td>
                                <td class="totales" style="background-color: ${(val == valH) ? '#d0ffd0' : '#ffd0d0'};">${val}</td>
                                <td class="totales" style="background-color: ${(por == porH) ? '#d0ffd0' : '#ffd0d0'};">${porH}</td>
                                <td class="totales" style="background-color: ${(imp == impH) ? '#d0ffd0' : '#ffd0d0'};">${impH}</td>
                                <td class="totales" style="background-color: ${(val == valH) ? '#d0ffd0' : '#ffd0d0'};">${valH}</td>

                            </tr>
                        </tbody>
                    </table>
                </div>
            </g:if>

            <script type="text/javascript">

                $(".btn").button();
                var band = 1
                $("#buscar").click(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "buscarCuentas",
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

                $("[name=eliminarGestor]").click(function () {
                    var url = $(this).attr("href");
                    $.box({
                        imageClass : "box_info",
                        text       : "Está seguro de querer eliminar este gestor? Esta acción no se puede deshacer...",
                        title      : "Confirmación",
                        iconClose  : false,
                        dialog     : {
                            resizable     : false,
                            draggable     : false,
                            closeOnEscape : false,
                            buttons       : {
                                "Aceptar"  : function () {
                                    location.href = url;
                                },
                                "Cancelar" : function () {
                                }
                            }
                        }
                    });
                    return false;
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

                function tablas(tabla) {
                    if (tabla == null)
                        tabla = ".table";
                    try {
                        $(tabla).dataTable({
                            "bPaginate"       : true,
                            "sPaginationType" : "full_numbers",
                            "bLengthChange"   : false,
                            "bSort"           : true,
                            "bFilter"         : false,
                            "bInfo"           : true,
                            "oLanguage"       : {
                                "sProcessing"   : "Procesando...",
                                "sLengthMenu"   : "Mostrar _MENU_ registros",
                                "sZeroRecords"  : "No se encontraron resultados",
                                "sInfo"         : "Mostrando de _START_ a _END_ de _TOTAL_ registros",
                                "sInfoEmpty"    : "Mostrando de 0 a 0 de 0 registros",
                                "sInfoFiltered" : "(filtrado de _MAX_ registros en total)",
                                "sInfoPostFix"  : "",
                                "sSearch"       : "Buscar:",
                                "sUrl"          : "",
                                "oPaginate"     : {
                                    "sFirst"    : "Primero",
                                    "sPrevious" : "Anterior",
                                    "sNext"     : "Siguiente",
                                    "sLast"     : "Último"
                                }
                            }
                        });

                        $('.hover tr').livequery(function () {
                            $(this).hover(
                                    function () {
                                        $(this).addClass("ui-state-hover");
                                    },
                                    function () {
                                        $(this).removeClass("ui-state-hover");
                                    }
                            );
                        });
                    } catch (ex) {
                    }
                }

            </script>

        </div>
    </body>
</html>