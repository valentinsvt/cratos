<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main"/>
        <title>Rol de pagos</title>
        <style type="text/css">
        .etiqueta {
            width       : 40px;
            height      : 20px;
            line-height : 20px;
            font-weight : bold;
            display     : inline-block;
            margin-left : 5px;
        }

        .margen {
            margin-left : 20px;
        }

        th {
            text-align : center;
        }

        table {
            border-collapse : collapse;
        }

        td, th {
            border : 1px solid #000000;
        }

        .btnpq {
            cursor : pointer;
        }
        </style>
    </head>

    <body>
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>

        <div class="container entero ui-widget-content ui-corner-all">
            <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 15px; margin-left: 8px;padding-left: 10px;height: 30px;line-height: 30px">
                <input type="hidden" id="control" value="0">
                <g:if test="${rol}">
                    Rol del pagos del mes ${rol?.mess.descripcion}
                </g:if>
                <g:else>
                    Seleccione un mes y año
                </g:else>

            </h1>

            <div class="etiqueta margen">Mes:</div>
            <g:select name="mes" from="${meses}" id="meses" optionKey="id" optionValue="descripcion" value="${mes.id}"></g:select>
            <div class="etiqueta margen">Año:</div>
            <g:select name="mes" from="${anios}" optionKey="key" optionValue="value" id="anios" value="${anio}"></g:select>
            <a href="#" id="ver" style="margin-left: 10px">Ver</a>
            <a href="#" id="imprimir" style="margin-left: 10px">Imprimir</a>
            <a href="#" id="imprimirDet" style="margin-left: 10px">Imprimir Detalles</a>

            <div id="tabla" style="width: 95%;margin: auto;margin-top: 15px;">

                <table style="width: 910px;">
                    <thead>
                        <tr>
                            <th>Empleado</th>
                            <th>Cargo</th>
                            <th>Contrato</th>
                            <th>A recibir</th>
                            <th style="width: 130px">Detalle</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${datos}" var="d" status="i">
                            <tr class="datos" id="${d[0]}">
                                <td>${d[1]}</td>
                                <td>${d[2]}</td>
                                <td>${d[3]}</td>
                                <td style="text-align: right">${d[4]}</td>
                                <td>
                                    <a href="#" class="detalle" title="Ver detalle" id="${d[0]}">Ver</a>
                                    <a href="#" class="imprimir" title="Imprimir detalle" id="${d[0]}">Imprimir</a>
                                </td>
                            </tr>
                        </g:each>
                        <tr>
                            <td colspan="3"><b>TOTAL</b></td>
                            <td style="text-align: right">${rol?.pagado}</td>
                            <td></td>
                        </tr>
                    </tbody>

                </table>
            </div>
            <g:if test="${rol?.estado != 'R'}">
                <div style="margin: 23px;">
                    <a href="#" id="registrar">Registrar Rol</a>
                </div>
            </g:if>
            <div id="dlg-rol">

            </div>

        </div>
        <script type="text/javascript">
            $("#ver").button().click(function () {
                location.href = "${g.createLink(action: 'verRol')}/?mes=" + $("#meses").val() + "&anio=" + $("#anios").val();
            });
            $("#imprimir").button().click(function () {
                location.href = "${g.createLink(controller: 'reporteRol', action: 'imprimirLista')}/?mes=" + $("#meses").val() + "&anio=" + $("#anios").val();
            });
            $("#imprimirDet").button().click(function () {
                location.href = "${g.createLink(controller: 'reporteRol', action: 'imprimirDetalles')}/?mes=" + $("#meses").val() + "&anio=" + $("#anios").val();
            });
            $("#registrar").button().click(function () {
                if (confirm("Esta seguro? una vez registrado el rol no podrá hacer cambios")) {
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller: 'rubro',action: 'registrarRol')}",
                        data    : "rol=${rol?.id}",
                        success : function (msg) {
                            $(this).remove()
                            window.location.reload(true)
                        }
                    });
                }
            });

            $(".detalle").button().click(function () {
                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(controller: 'rubro',action: 'getDetalle')}",
                    data    : "rol=${rol?.id}&emp=" + $(this).attr("id"),
                    success : function (msg) {

                        $("#dlg-rol").html(msg)
                        $("#dlg-rol").dialog("open")

                    }
                });
            });

            $(".imprimir").button().click(function () {
                location.href = "${g.createLink(controller: 'reporteRol', action: 'imprimirDetalle')}/?rol=${rol?.id}&emp=" + $(this).attr("id");
            });
            $("#dlg-rol").dialog({
                modal    : true,
                autoOpen : false,
                width    : 500,
                zIndex   : 1000,
                position : "center",
                title    : "Detalles del pago",
                buttons  : {
                    "Cancelar" : function () {
                        $(this).dialog("close")
                    },
                    "Aceptar"  : function () {
                        if ($("#control").val() == "1")
                            window.location.reload(true)
                        else
                            $(this).dialog("close")
                    }
                }
            });
        </script>
    </body>
</html>