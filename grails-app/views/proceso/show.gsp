<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main"/>
        <title>Cratos - Transacciones</title>
        <style type="text/css">
        .etiqueta {
            width       : 100px;
            height      : 20px;
            line-height : 20px;
            font-weight : bold;
            display     : inline-block;
        }

        </style>
    </head>

    <body>
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${gestorContableInstance}">
            <div class="errors">
                <g:renderErrors bean="${gestorContableInstance}" as="list"/>
            </div>
        </g:hasErrors>
        <g:form name="procesoForm" action="save" method="post" class="frmProceso">
            <div class="container entero ui-widget-content ui-corner-all">
                <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 5px; margin-left: 8px;height: 30px;line-height: 30px;padding-left: 30px;margin-bottom: 20px;">Transacción Contable</h1>


                <div style="height: 30px;margin-bottom: 10px;width: 600px;padding-left: 40px;">
                    %{----}%
                    %{--<g:link--}%
                    %{--class="btn  ui-corner-all"--}%
                    %{--action="pdfLink" controller="pdf" params="[url: g.createLink(action: 'comprobante', controller: 'reportes', id: proceso.id), filename: 'comprobante']">--}%
                    %{--Imprimir--}%
                    %{--</g:link>--}%

                    <g:link
                            class="btn ui-corner-all"
                            action="index">
                        Salir
                    </g:link>

                    <g:if test="${comprobante.registrado != 'S'}">

                        <g:link class="btn ui-corner-all" id="${proceso?.id}" action="borrarProceso">Borrar Proceso</g:link>

                    </g:if>

                </div>

                <div id="contenido" class="span-11 " style="padding-left: 40px;">
                    <div class="etiqueta">Gestor:</div>${proceso?.gestor?.nombre}   <br>
                    <input type="hidden" name="id" value="${proceso?.id}" id="idProceso"/>
                    <input type="hidden" name="empleado.id" value="${session.usuario.id}"/>
                    <input type="hidden" name="periodoContable.id" value="${session?.contabilidad?.id}"/>

                    <div class="etiqueta">Fecha:</div>${proceso.fecha.format("dd/MM/yyyy")}<br>
                </div>

                <div id="contenido3" class="span-20 " style="padding-left: 40px;">
                    <div class="etiqueta">Sust. tributario:</div> ${proceso?.sustentoTributario?.descripcion} <br>
                </div>

                <div id="contenido4" class="span-20 " style="padding-left: 40px;">
                    <div class="etiqueta">Tipo comprobante:</div> ${proceso?.tipoComprobanteSri?.descripcion} <br>
                </div>

                <div id="contenido2" class="span-20 " style="padding-left: 40px;">
                    <div class="etiqueta">Proceso:</div> ${proceso?.descripcion} <br>
                </div>

                <div id="contenido5" class="span-20 " style="padding-left: 40px;">
                    <div class="etiqueta">Documento:</div> ${proceso?.facturaEstablecimiento}-${proceso?.facturaPuntoEmision}-${proceso?.facturaSecuencial}
                </div>
                <br>
                <br>

                <div class="span-28" style="margin-left: 40px;margin-top: 10px;margin-bottom: 15px;">
                    %{--<div style="float:left;padding-top: 3px;">--}%
                    %{--<label>Valor:</label>--}%
                    %{--<input type="text" name="valor" size="7" value="${proceso?.valor}" class="required ui-widget-content ui-corner-all saved" validate="required number" disabled="true"/>--}%
                    %{--<label>Impuestos:</label>--}%
                    %{--<input type="text" name="impuesto" size="7" value="${proceso?.impuesto}" class="required ui-widget-content ui-corner-all" validate="required number" disabled="true"/>--}%
                    %{--<label>Documento:</label>--}%
                    %{--<input type="text" name="factura" style="width: 120px;" value="${proceso?.documento}" class=" ui-widget-content ui-corner-all" disabled="true"/>--}%
                    %{--</div>--}%

                    <div style="/*float:left;*/padding-top: 3px;">
                        <label>Base imponible IVA 0%:</label>
                        ${proceso?.baseImponibleIva0}
                        <label style="margin-left: 15px;">Base imponible IVA <g:formatNumber number="${cratos.ParametrosAuxiliares.list().first().iva}" maxFractionDigits="0" minFractionDigits="0"/>%:</label>
                        ${proceso?.baseImponibleIva}
                        <label style="margin-left: 15px;">Base imponible no aplica IVA:</label>
                        ${proceso?.baseImponibleNoIva}
                    </div>

                    <div style="/*float:left;*/padding-top: 3px;">
                        <label>IVA generado:</label>
                        ${proceso?.ivaGenerado}
                        <label style="margin-left: 15px;">ICE generado:</label>
                        ${proceso?.iceGenerado}
                        %{--<label style="margin-left: 15px;">Tipo de pago:</label>--}%
                        %{--${proceso?.tipoPago?.descripcion}--}%
                    </div>
                </div>

                <div id="registro" style="float:left; margin-left: 40px;border: black solid 1px; margin-bottom: 25px;padding: 10px;display: none;margin-top: 15px;" class="ui-corner-all">
                </div>
            </div>
        </g:form>
        <script type="text/javascript">

            $(function () {
                $(".btn").button();

                <g:if test="${registro}">

                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(controller: 'proceso',action: 'cargaComprobantes')}",
                    data    : "proceso=" + $("#idProceso").val(),
                    success : function (msg) {
                        $("#registro").html(msg).show("slide");
                    }
                });

                </g:if>

            });

            $("#borrarProceso").click(function () {

                console.log("entro")

            });

        </script>
    </body>

</html>
