<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Orden de compra</title>

        <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
        <link type="text/css" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"
              rel="stylesheet"/>

        <style type="text/css">
        tr:nth-child(2n+1), tr:nth-child(2n) {
            background : none;
        }

        .barra {

            color : black !important;

        }

        table {
            border : none;
            width  : auto;
        }

        .bg td {
            background : #eee;
        }

        .hover {
            background : #ffd125 !important;
            cursor     : pointer;
        }

        .label {
            font-weight : bold;
        }

        .selected {
            border     : #FF8010 solid 2px !important;
            background : #F7E7D9 !important;
        }

        .tarjeta {
            display : none;
        }

        ul {
            list-style   : disc;
            padding-left : 40px;
        }

        .error {
            border     : solid 2px #cc0000;
            background : #ccaaaa;
        }
        </style>

    </head>

    <body>
        <g:set var="detalles" value="${cratos.DetalleOrdenCompra.findAllByOrdenCompra(ordenCompraInstance)}"/>

        <div id="show-ordenCompra" class="content scaffold-create noshowgrid" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="barra list linkButton" action="list">Lista Ordenes de compra</g:link></li>
                    <li><g:link class="barra btnNew" action="create">Nueva</g:link></li>
                <li>

                    <g:if test="${ordenCompraInstance.estado == 'R'}">

                        <g:link class=" barra btningCompra" controller="adquisiciones" action="create"
                                params="${[ordenCompra: ordenCompraInstance.id]}">Ingresar Compra</g:link></li>

                    </g:if>

                    <li><g:link class="btnverReporte miniButton" controller="reportes" action="reporteOrdenCompra"
                                file="Orden_Compra_Reporte.pdf">Ver Reporte</g:link></li>

                </ul>
            </div>

            <div class="contenedor">
                <h1>Ver Orden de compra</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span
                            class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>
                <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all"
                     id="divErrores">
                    <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                    <strong>Se encontraron los siguientes errores:</strong>

                    <div id="listaErrores"></div>
                </div>

                <fieldset style="margin: 10px;">

                    <legend>Orden de compra</legend>


                    <div class="span-20">
                        <div class="span-3" style="font-weight: bold;">Número:</div>

                        <div class="span-6">
                            ${ordenCompraInstance.numero}
                        </div>

                    </div>

                    <div class="span-20">
                        <div class="span-3" style="font-weight: bold;">Centro de costo:</div>

                        <div class="span-6">
                            ${ordenCompraInstance.centroCosto.nombre}
                        </div>

                        <div class="span-3 prepend-1" style="font-weight: bold;">Fecha:</div>

                        <div class="span-6">
                            <g:formatDate date="${ordenCompraInstance.fecha}" format="dd-MM-yyyy"/>
                        </div>
                    </div>

                    <div class="span-20">

                        <div class="span-3" style="font-weight: bold;">Estado:</div>

                        <div class="span-6" id="estado">

                            <g:if test="${ordenCompraInstance.estado == 'R'}">
                                <td>Registrado</td>
                            </g:if>
                            <g:else>
                                <g:if test="${ordenCompraInstance.estado == 'C'}">
                                    <td>Comprado</td>

                                </g:if>
                                <g:else>
                                    <td>No Registrado</td>
                                </g:else>
                            </g:else>
                        </div>

                        <div class="span-3 prepend-1" style="font-weight: bold;">Observaciones:</div>

                        <div class="span-6">
                            ${ordenCompraInstance.observaciones}
                        </div>
                    </div>

                    <div class="span-20">
                        <div class="span-3" style="font-weight: bold;">Descripci&oacute;n:</div>

                        <div class="span-6">
                            ${ordenCompraInstance.descripcion}
                        </div>
                    </div>

                    <g:if test="${ordenCompraInstance.estado == 'R' && cratos.Adquisiciones.countByOrden(ordenCompraInstance) == 0}">
                        <div class="span-4">
                            <div class="" style="padding-top: 20px">

                                <g:link class="btnCambiarEstado" action="actualizarEstado" id="${ordenCompraInstance.id}">
                                    No Registrar
                                </g:link>

                            </div>
                        </div>
                    </g:if>
                %{--${ordenCompraInstance.estado}--}%
                %{--${ordenCompraInstance.estado == 'N'}--}%
                    <g:if test="${ordenCompraInstance.estado == 'N'}">
                        <div class="span-4">
                            <div class="" style="padding-top: 20px">

                                <g:link class="btnCambiarEstado" action="actualizarEstado" id="${ordenCompraInstance.id}">
                                    Registrar
                                </g:link>

                            </div>

                        </div>

                    </g:if>

                </fieldset>

                <fieldset style="margin: 10px;">
                    <legend>Productos</legend>

                    <table id="tblItems" border="1" style="border-collapse: collapse;">
                        <thead>
                            <tr>
                                <th width="50" class="cantidad">
                                    Cantidad
                                </th>
                                <th width="100">
                                    Código
                                </th>
                                <th width="300">
                                    Item
                                </th>
                                <th width="100" class="precioUnitario">
                                    Precio Unitario
                                </th>

                                <th width="80" class="subtotal">
                                    Subtotal
                                </th>

                                <th>
                                    Cantidad adquirida
                                </th>

                                <th>
                                    Cantidad por adquirir
                                </th>

                            </tr>
                        </thead>
                        <tbody id="tbItems">
                            <g:each in="${detalles}" var="item">
                                <tr>
                                    <td style="text-align:right;">${item.cantidad}</td>
                                    <td>${item.item.codigo}</td>
                                    <td>${item.item.nombre}</td>
                                    <td style="text-align:right;"><g:formatNumber number="${item.precioUnitario}" minFractionDigits="2"
                                                                                  maxFractionDigits="2"/></td>

                                    <td style="text-align:right;">
                                        <g:set var="total" value="${(item.cantidad * item.precioUnitario)}"/>
                                        <g:formatNumber number="${total}" minFractionDigits="2" maxFractionDigits="2"/>
                                    </td>

                                    <td style="text-align:right;">
                                        <g:set var="ca" value="${0}"/>
                                        <g:each in="${cratos.Adquisiciones.findAllByOrden(ordenCompraInstance)}" var="adq">
                                            <g:each in="${cratos.DetalleAdquisicion.findAllByItemAndAdquisiciones(item.item, adq)}" var="dt">
                                                <g:set var="ca" value="${ca + dt.cantidad}"/>
                                            </g:each>
                                        </g:each>
                                        <g:formatNumber number="${ca}" minFractionDigits="2" maxFractionDigits="2"/>
                                    </td>
                                    <td style="text-align:right;">
                                        <g:formatNumber number="${item.cantidad - ca}" minFractionDigits="2" maxFractionDigits="2"/>
                                    </td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>

                    <br/>

                    <table border="1" style="border-collapse: collapse;">
                        <tr>
                            <th>Subtotal</th>
                            <td id="tdSubtotalFin" style="text-align: right;"><g:formatNumber
                                    number="${ordenCompraInstance.valor}" minFractionDigits="2" maxFractionDigits="2"/></td>
                        </tr>
                        %{--<tr>--}%
                        %{--<th>Descuentos</th>--}%
                        %{--<td id="tdDescuentosFin" style="text-align: right;"><g:formatNumber number="${facturaInstance.descuentos}" minFractionDigits="2" maxFractionDigits="2"/></td>--}%
                        %{--</tr>--}%
                        %{--<tr>--}%
                        %{--<th>Tarifa IVA ${iva}%</th>--}%
                        %{--<td id="tdIva12Fin" style="text-align: right;"><g:formatNumber number="${facturaInstance.iva1}" minFractionDigits="2" maxFractionDigits="2"/></td>--}%
                        %{--</tr>--}%
                        %{--<tr>--}%
                        %{--<th>Tarifa IVA 0%</th>--}%
                        %{--<td id="tdIva0Fin" style="text-align: right;"><g:formatNumber number="${facturaInstance.iva0}" minFractionDigits="2" maxFractionDigits="2"/></td>--}%
                        %{--</tr>--}%
                        %{--<tr>--}%
                        %{--<th>IVA (${iva}%)</th>--}%
                        %{--<td id="tdIvaFin" style="text-align: right;"><g:formatNumber number="${facturaInstance.iva}" minFractionDigits="2" maxFractionDigits="2"/></td>--}%
                        %{--</tr>--}%
                        %{--<tr>--}%
                        %{--<th>TOTAL</th>--}%
                        %{--<td id="tdTotalFin" style="text-align: right;"><g:formatNumber number="${facturaInstance.pagado}" minFractionDigits="2" maxFractionDigits="2"/></td>--}%
                        %{--</tr>--}%
                    </table>
                    %{--</g:if>--}%

                </fieldset>

            </div>


            <g:if test="${ordenCompraInstance.estado != 'R'}">
                <div class="ui-widget-header buttons botones">
                    <g:link action="create" class="btnEdit" id="${ordenCompraInstance.id}">Editar</g:link>
                </div>
            </g:if>
        </div>

        <script type="text/javascript">

            var actionUrl = "";

            $(function () {
                $(".btnEdit").button({
                    icons : {
                        primary : "ui-icon-pencil"
                    }

                });
            });

            $(function () {

                $(".btnverReporte").button({

                    icons : {

                        primary : "ui-icon-note"
                    }

                }).click(function () {

                            var url = $(this).attr("href");
                            var file = $(this).attr("file");
                            actionUrl = "${createLink(controller:'pdf',action:'pdfLink')}?filename=" + file + "&url=" + url;

                            var id = "${ordenCompraInstance.id}";

                            var urlPdf = actionUrl + "?id=" + id;

                            location.href = urlPdf;

                            return false;
                        });

            });

            $(function () {

                var data = ${ordenCompraInstance.id};

                $(".btnCambiarEstado").button({
                    icons : {
                        primary : "ui-icon-pencil"
                    }
                }).click(function () {
                            if (confirm("Está seguro de cambiar el estado de esta orden?")) {
                                return true;
                            %{--$.ajax({--}%
                            %{--type    : "POST",--}%
                            %{--url     : "${createLink(action: 'actualizarEstado')}",--}%
                            %{--data    : {--}%
                            %{--id : data--}%
                            %{--},--}%
                            %{--success : function (msg) {--}%
                            %{--if (msg == 'OK') {--}%

                            %{--window.location.href = "${createLink(action:'list')}";--}%

                            %{--}--}%
                            %{--}--}%
                            %{--})--}%
                            }
                            return false;
                        });

                %{--$(".btnRegistrar").button({--}%
                %{--icons : {--}%
                %{--primary : "ui-icon-pencil"--}%
                %{--}--}%
                %{--}).click(function () {--}%
                %{--if (confirm("Esta seguro de cambiar el estado de esta orden?")) {--}%
                %{--$.ajax({--}%
                %{--type    : "POST",--}%
                %{--url     : "${createLink(action: 'actualizarEstado')}",--}%
                %{--data    : {--}%
                %{--id : data--}%
                %{--},--}%
                %{--success : function (msg) {--}%
                %{--if (msg == 'OK') {--}%
                %{--window.location.href = "${createLink(action:'list')}";--}%
                %{--}--}%
                %{--}--}%
                %{--})--}%
                %{--}--}%
                %{--});--}%
            });



        </script>

    </body>
</html>


