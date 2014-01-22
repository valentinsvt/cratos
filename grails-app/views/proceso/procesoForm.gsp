<%@ page import="cratos.TipoComprobanteSri; cratos.SustentoTributario" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main"/>
        <g:includeJQuery archivo="transacciones"/>
        <title>Transacciones</title>
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
                <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 15px; margin-left: 8px;padding-left: 10px;height: 30px;line-height: 30px">${(proceso) ? 'Editar transaccion' : 'Nueva transacción'}</h1>


                <div style="width: 800px;height: 30px;padding-left: 30px;margin-bottom: 15px">
                    <g:if test="${!registro}">
                        <a href="#" class="btn ui-corner-all" id="guardarProceso">
                            Guardar
                        </a>

                    </g:if>
                    <g:if test="${params.id}">
                        <g:if test="${proceso.adquisicion == null && proceso.fact == null && proceso.transferencia == null}">
                            <a href="#" class="btn" id="registrarProceso">
                                Registrar
                            </a>
                        </g:if>
                    </g:if>
                    <g:link class="btn ui-corner-all" action="index">
                        Cancelar
                    </g:link>

                    <g:link class="btn ui-corner-all" id="${proceso?.id}" action="borrarProceso">Borrar Proceso</g:link>

                </div>
                <input type="hidden" name="id" value="${proceso?.id}" id="idProceso"/>
                <input type="hidden" name="empleado.id" value="${session.usuario.id}"/>
                <input type="hidden" name="periodoContable.id" value="${session?.contabilidad?.id}"/>

                <div id="contenido" style="width: 900px;padding-left: 30px;">

                    <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all"
                         id="divErrores">
                        <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                        <span style="font-weight: solid;" id="spanError">Se encontraron los siguientes errores:</span>

                        <ul id="listaErrores"></ul>
                    </div>

                    <div class="etiqueta">Gestor:</div>
                    <g:select class="ui-corner-all required" name="gestor.id" from="${cratos.Gestor.findAllByEstadoAndEmpresa('A', session.empresa, [sort: 'nombre'])}"
                              label="Proceso tipo: " value="${proceso?.gestor?.id}" optionKey="id" optionValue="nombre" title="El gestor es obligatorio"/>
                    <br>

                    %{--<div class="etiqueta">Fecha:</div> ${new java.util.Date().format("dd/MM/yyyy")}--}%

                    <div class="etiqueta">Fecha:</div>
                    <elm:datePicker class="field ui-corner-all required" name="fecha" style="width: 80px; margin-left: 5px"
                                    maxDate="new Date()" title="La fecha es obligatoria"
                                    format="yyyy-MM-dd" value="${proceso?.fecha}"/>

                    <br>

                    <div class="etiqueta">Sustento Tributario</div>
                    <g:select class=" required" name="sustentoTributario.id" from="${SustentoTributario.list([sort:'codigo'])}" optionKey="id" optionValue="descripcion" style="width: 550px"
                              title="El sustento tributario es obligatorio"/>

                    <br/>

                    <div class="etiqueta">Tipo comprobante</div>
                    <g:select class=" required" name="tipoComprobanteSri.id" from="${TipoComprobanteSri.list([sort:'codigo'])}" optionKey="id" optionValue="descripcion" style="width: 300px"
                              title="El tipo de comprobante es obligatorio"/>

                    <br/>

                    <div class="etiqueta">Proveedor:</div>
                    <input type="text" name="proveedor.ruc" class="ui-corner-all required" id="prov" disabled="true" value="${proceso?.proveedor?.ruc}"
                           title="El proveedor es obligatorio"/>
                    <a href="#" id="btn_buscar" class="btn">Buscar</a>
                    <input type="hidden" name="proveedor.id" id="prov_id" value="${proceso?.proveedor?.id}">
                    <br>

                    <div class="etiqueta">Descripción:</div>
                    <textArea style='height:40px;width: 700px;' name="descripcion" title="La descripción es obligatoria" class="ui-corner-all required">${proceso?.descripcion}</textArea>
                </div>

                <div class="span-28" style="margin-left: 40px;margin-top: 10px;margin-bottom: 15px;">
                    %{-- borrar desde aqui --}%
                    %{--<div style="/*float:left;*/padding-top: 3px;">--}%
                    %{--<label>Valor:</label>--}%
                    %{--<input type="text" name="valor" size="7" value="${proceso?.valor}" class="required ui-widget-content ui-corner-all" validate="required number"/>--}%
                    %{--<label style="margin-left: 40px;">Impuestos:</label>--}%
                    %{--<input type="text" name="impuesto" size="7" value="${proceso?.impuesto}" class="required ui-widget-content ui-corner-all" validate="required number"/>--}%
                    %{--<label style="margin-left: 40px;">Documento:</label>--}%
                    %{--<input type="text" name="documento" style="width: 120px;margin-right: 5px" value="${proceso?.documento}" class=" ui-widget-content ui-corner-all"/>--}%
                    %{--<b>Tipo de pago:</b>--}%
                    %{--<g:select name="tipoPago.id" from="${cratos.TipoPago.list()}" label="Tipo de pago: " value="${proceso?.tipoPago?.id}" optionKey="id" validate="required " optionValue="descripcion"/>--}%
                    %{--</div>--}%
                    %{-- borrar hasta aqui --}%
                    <div style="/*float:left;*/padding-top: 3px;">

                        <g:set var="iva" value="${cratos.ParametrosAuxiliares.list().first().iva}"/>

                        <label>Base imponible IVA 0%:</label>
                        <input type="text" name="baseImponibleIva0" size="7" value="${proceso?.baseImponibleIva0 ?: 0.00}" class="required number ui-widget-content ui-corner-all" validate="required number"/>
                        <label style="margin-left: 15px;">Base imponible IVA <g:formatNumber number="${iva}" maxFractionDigits="0" minFractionDigits="0"/>%:</label>
                        <input type="text" name="baseImponibleIva" id="baseImponibleIva" size="7" value="${proceso?.baseImponibleIva ?: 0.00}" class="required ui-widget-content ui-corner-all" validate="required number"/>
                        <label style="margin-left: 15px;">Base imponible no aplica IVA:</label>
                        <input type="text" name="baseImponibleNoIva" size="7" value="${proceso?.baseImponibleNoIva ?: 0.00}" class="required number ui-widget-content ui-corner-all" validate="required number"/>
                    </div>

                    <div style="/*float:left;*/padding-top: 3px;">
                        <label>IVA generado:</label>
                        <input type="text" name="ivaGenerado" id="ivaGenerado" size="7" value="${proceso?.ivaGenerado}" class="required number ui-widget-content ui-corner-all" validate="required number"/>
                        <label style="margin-left: 15px;">ICE generado:</label>
                        <input type="text" name="iceGenerado" size="7" value="${proceso?.iceGenerado ?: 0.00}" class="required number ui-widget-content ui-corner-all" validate="required number"/>
                        <label style="margin-left: 15px;">Documento:</label>
                        <input type="text" name="facturaEstablecimiento" size="3" maxlength="3" value="${proceso?.facturaEstablecimiento}" class="required digits ui-widget-content ui-corner-all" validate="required number"
                               title="El número de establecimiento de la factura es obligatorio"/>
                        <input type="text" name="facturaPuntoEmision" size="3" maxlength="3" value="${proceso?.facturaPuntoEmision}" class="required digits ui-widget-content ui-corner-all" validate="required number"
                               title="El número de punto de emisión de la factura es obligatorio"/>
                        <input type="text" name="facturaSecuencial" size="10" maxlength="9" value="${proceso?.facturaSecuencial}" class="required digits ui-widget-content ui-corner-all" validate="required number"
                               title="El número de secuencia de la factura es obligatorio"/>

                        <label style="margin-left: 15px;">Tipo de pago:</label>
                        <g:select name="tipoPago.id" class=" required" from="${cratos.TipoPago.list()}" label="Tipo de pago: "
                                  value="${proceso?.tipoPago?.id}" optionKey="id" validate="required " optionValue="descripcion" style="max-width:230px;"/>
                    </div>

                    <div class="span-9 last" style="margin-left: 40px;float: left;"></div>
                </div>
                <br>

                <div id="registro" style="float:left; margin-left: 40px;border: black solid 1px; margin-bottom: 25px;padding: 10px;display: none;margin-top: 15px;">

                </div>

            </div>

            <div id="dlgBuscar" style="width: 500px;height: 450px;">
                <div style="width: 450px;height: 30px;margin-bottom: 15px">
                    <select id="tipoPar" style="margin-right: 5px;" class="ui-corner-all">
                        <option value="1">RUC</option>
                        <option value="2">Nombre</option>
                    </select>
                    <input type="text" id="parametro" class="ui-corner-all" style="margin-right: 10px;">
                    <a href="#" id="buscar" class="btn">Buscar</a>
                </div>

                <div style="width: 450px;height: 300px;overflow-y: auto;" id="resultados"></div>

            </div>

        </g:form>

        <script type="text/javascript">

            function validateNum($elm) {
                var val = parseFloat($elm.val());
                $elm.val(number_format(val, 2, ".", ""));
            }
            function validateInt($elm) {
                var val = parseInt($elm.val());
                $elm.val(val);
            }

            function calculaIva() {
                var iva = ${iva};
                var val = parseFloat($("#baseImponibleIva").val());

                var total = (iva / 100) * val;

                $("#ivaGenerado").val(number_format(total, 2, ".", ""));
            }

            $(function () {
                calculaIva();
                $(".btn").button();

                $("#baseImponibleIva").keyup(function () {
                    calculaIva();
                });

//                $(".digits").keyup(function () {
//                    validateInt($(this));
//                });

                $(".number").keyup(function () {
                    validateNum($(this));
                });

                $("#procesoForm").validate({
                    errorLabelContainer : "#listaErrores",
                    wrapper             : "li",
                    invalidHandler      : function (form, validator) {
                        var errors = validator.numberOfInvalids();
//                        console.log("**" + errors);
                        if (errors) {
                            var message = errors == 1
                                    ? 'Se encontró 1 error.'
                                    : 'Se encontraron ' + errors + ' errores';
                            $("#divErrores").show();
                            $("#spanError").html(message);

                        } else {
                            $("#divErrores").hide();

                        }
                    }
                });

                $("#guardarProceso").click(function () {
                    if ($("#procesoForm").valid()) {
                        $.box({
                            imageClass : "box_info",
                            text       : "Por favor espere",
                            title      : "Procesando",
                            iconClose  : false,
                            dialog     : {
                                resizable     : false,
                                draggable     : false,
                                closeOnEscape : false,
                                buttons       : { }
                            }
                        });
                    }
                });

                $("#btn_buscar").click(function () {
                    $("#dlgBuscar").dialog("open")
                });

                $("#buscar").click(function () {

                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller: 'proceso',action: 'buscarProveedor')}",
                        data    : "par=" + $("#parametro").val() + "&tipo=" + $("#tipoPar").val(),
                        success : function (msg) {
                            //$("#registro").html(msg).show("slide");

                            $("#resultados").html(msg).show("slide")
                        }
                    });

                });

                $("#dlgBuscar").dialog({
                    autoOpen  : false,
                    modal     : true,
                    resizable : false,
                    draggable : false,
                    title     : "Busqueda de proveedores",
                    width     : 500,
                    height    : 450,
                    position  : "center",
                    buttons   : {
                        "Cerrar" : function () {
                            $("#dlgBuscar").dialog("close");
                        }
                    }
                });

                $("#registrarProceso").click(function () {
                    if (confirm("Está seguro?")) {
                        var d = $.box({
                            imageClass : "box_info",
                            text       : "Por favor espere",
                            title      : "Procesando",
                            iconClose  : false,
                            dialog     : {
                                resizable     : false,
                                draggable     : false,
                                closeOnEscape : false,
                                buttons       : { }
                            }
                        });
                        $.ajax({
                            type    : "POST",
                            url     : "${g.createLink(controller: 'proceso',action: 'registrar')}",
                            data    : "id=" + $("#idProceso").val(),
                            success : function (msg) {
                                //$("#registro").html(msg).show("slide");
                                $("#auth").dialog("close");
                                location.reload(true);
                            },
                            error   : function () {
                                $.box({
                                    imageClass : "box_info",
                                    text       : "Ha ocurrido un error. Por favor revise el gestor y los valores del proceso.",
                                    title      : "Alerta",
                                    iconClose  : false,
                                    dialog     : {
                                        resizable     : false,
                                        draggable     : false,
                                        closeOnEscape : false,
                                        buttons       : {
                                            "Aceptar" : function () {
                                                d.dialog("close");
                                            }
                                        }
                                    }
                                });

                            }
                        });

                    }
                });
            });
        </script>


        <g:if test="${proceso}">
            <script type="text/javascript">
                //                console.log("entro")

                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(action: 'cargaComprobantes')}",
                    data    : "proceso=" + $("#idProceso").val(),
                    success : function (msg) {
                        $("#registro").html(msg).show("slide");
                    }
                });

            </script>
        </g:if>
    </body>

</html>
