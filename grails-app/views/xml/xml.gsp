<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/19/13
  Time: 12:56 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>SRI (XML)</title>

        <style type="text/css">
        .container {
            padding : 5px;
        }
        </style>
    </head>

    <body>
    <div class="container entero ui-widget-content ui-corner-all">
        <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 5px; margin-left: 8px;height: 30px;line-height: 30px;padding-left: 30px;margin-bottom: 20px;">
            XML del Anexo Transaccional SRI
        </h1>

        <div style="margin-bottom: 10px;">
            <g:link action="downloads" class="btn">
                Archivos
            </g:link>
        </div>

        <g:form name="sriForm">
            <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
                <label>Año</label>
                <g:select name="anio" from="${anios}"/>
                <label style="margin-left: 15px;">Mes</label>
                <span id="spMes">
                    <g:select name="mes" from="${periodos}" optionKey="id" optionValue="val"/>
                </span>

                <a href="#" class="btn ui-corner-all" style="margin-left: 15px;" id="btnPrint">Generar</a>
            </div>
            </div>
        </g:form>

        <div id="dialog-exists" title="Alerta">
            <p id="pCont">
            </p>
        </div>


        <script type="text/javascript">
            function getPeriodos() {
                var anio = $("#anio").val();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'getPeriodos')}",
                    data    : {
                        anio : anio
                    },
                    success : function (msg) {
                        $("#spMes").html(msg);
                    }
                });
            }
            $(function () {
                $("#anio").val("${new Date().format('yyyy')}");
                getPeriodos();
                var $dlg = $("#dialog-exists");

                $(".btn").button();

                $("#dialog-exists").dialog({
                    autoOpen      : false,
                    modal         : true,
                    draggable     : false,
                    resizable     : false,
                    closeOnEscape : false,
                    width         : 640,
                    buttons       : {
                        Ok : function () {
                            $(this).dialog("close");
                        }
                    }
                });

                function crearXML(mes, anio, override) {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'createXml')}",
                        data    : {
                            mes      : mes,
                            anio     : anio,
                            override : override
                        },
                        success : function (msg) {
                            var parts = msg.split("_");
                            if (parts[0] == "NO") {
                                if (parts[1] == "1") {
                                    $("#pCont").html("Ya existe un archivo XML para el periodo " + mes + "-" + anio + "." +
                                                     "<ul><li>Si desea <strong>sobreescribir el archivo existente</strong>, haga click en el botón <strong>'Sobreescribir'</strong></li>" +
                                                     "<li>Si desea <strong>descargar el archivo previamente generado</strong>, haga click en el botón <strong>'Descargar'</strong></li>" +
                                                     "<li>Si desea <strong>ver la lista de archivos generados</strong>, haga cilck en el botón <strong>'Archivos'</strong></li></ul>");
                                    $dlg.dialog("option", "width", 640);
                                    $dlg.dialog("option", "title", "Alerta");
                                    $dlg.dialog("option", "buttons", [
                                        {
                                            text : "Sobreescribir", click : function () {
                                            crearXML(mes, anio, 1);
                                        }
                                        },
                                        {
                                            text : "Descargar", click : function () {
                                            location.href = "${createLink(action:'downloadFile')}?mes=" + mes + "&anio=" + anio;
                                        }
                                        },
                                        {
                                            text : "Archivos", click : function () {
                                            location.href = "${createLink(action:'downloads')}";
                                        }
                                        },
                                        {
                                            text : "Cancelar", click : function () {
                                            $(this).dialog("close");
                                        }
                                        }
                                    ]).dialog("open");
                                }
                            } else if (parts[0] == "OK") {
                                $("#pCont").html("Archivo generado exitosamente");
                                $dlg.dialog("option", "width", 250);
                                $dlg.dialog("option", "title", "Descargar archivo");
                                $dlg.dialog("option", "buttons", [
                                    {
                                        text : "Descargar", click : function () {
                                        location.href = "${createLink(action:'downloadFile')}?mes=" + mes + "&anio=" + anio;
                                        $(this).dialog("close");
                                    }
                                    }
                                ]).dialog("open");
                            }
                        }
                    });
                }

                $("#btnPrint").click(function () {
                    var mes = $("#mes").val();
                    var anio = $("#anio").val();
                    crearXML(mes, anio, 0);
                });

                $("#anio").change(function () {
                    getPeriodos();
                });
            })
            ;
        </script>

    </body>
</html>