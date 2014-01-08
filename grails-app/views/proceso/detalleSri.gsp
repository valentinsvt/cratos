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
    <title>SRI</title>


    <style type="text/css">
        .ui-state-success{
            background-color: #006600 ;
            color: white;
            border: solid 1px #00aa00;
        }


    </style>


</head>

<body>
<g:form name="sriForm">
    <div class="container entero ui-widget-content ui-corner-all">
        <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 5px; margin-left: 8px;height: 30px;line-height: 30px;padding-left: 30px;margin-bottom: 20px;">Detalle SRI</h1>

        <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-success ui-corner-all"
             id="divSuccess">
            <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
            <span style="font-weight: solid;" id="spanSuc"> Grabado Correctamente</span>

            <ul id="listaSuc"></ul>
        </div>

        <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all"
             id="divErrores">
            <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
            <span style="font-weight: solid;" id="spanError"> </span>

            <ul id="listaErrores"></ul>
        </div>


        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: -5px">
            <label>N° Establecimiento</label>
            <label style="margin-left: 15px">N° Emisión</label>
            <label style="margin-left: 35px">N° Autorización del Comprobante</label>
        </div>

        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
            <label style="width: 100px; margin-left: 50px">${proceso?.facturaEstablecimiento}</label>
            <label style="width: 100px">${proceso?.facturaPuntoEmision}</label>
            <label style="width: 250px">${proceso?.proveedor?.autorizacionSri}</label>
        </div>

        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
            <label>Aplica Crédito Tributario</label><g:select name="credito" from="${['SI', 'NO']}"/>

        </div>
        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
            <label>Pago Local o Exterior</label><g:select name="pago" from="${['LOCAL', 'EXTERIOR']}"/>

        </div>

        <div class="span-28 exterior" style="margin-left: 40px; margin-right: 30px; margin-top: 10px; margin-bottom: 15px" hidden="hidden">

            <fieldset>
                <legend>Exterior</legend>
            <div>
                <label>País</label><g:select name="pais" from="${['ECUADOR']}"/>
            </div>
            <div style="margin-top: 20px">
                <label>Aplica convenio de doble tributación?</label><g:radioGroup labels="['SI', 'NO']" values="[1,2]" name="convenio">  ${it?.label} ${it?.radio}</g:radioGroup>
            </div>
            <div style="margin-top: 20px">
                  <label>Pago sujeto a retención en aplicación de la norma legal</label><g:radioGroup labels="['SI', 'NO']" values="[1,2]" name="norma"> ${it?.label} ${it?.radio}</g:radioGroup>
            </div>
            </fieldset>


        </div>





        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">

            <label style="margin-left: 560px">Base Retención</label>
            <label style="margin-left: 15px">% Ret</label>
            <label style="margin-left: 25px">Valor Retenido</label>
        </div>

        <g:each in="${detalleRetencion}" var="detalle">
            <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 3px">
                <label>Base Imponible no Objeto de IVA</label>
                <g:textField name="noObjetoIva" style="margin-left: 5px; margin-right: 150px" value="${proceso?.baseImponibleNoIva}" readonly="true"  />


                <label>ICE</label>
                <g:if test="${detalle?.impuesto?.sri == 'ICE'}">
                    <g:textField name="iceBase"  value="${detalle?.base}" />
                    <g:textField name="icePorcentaje"  value="${detalle?.porcentaje}" style="width: 60px" />
                    <g:textField name="valorRetenidoIce" value="${detalle?.total}"/>
                </g:if>
                <g:else>
                    <g:textField name="iceBase"  value="${0}" />
                    <g:textField name="icePorcentaje"  value="${0}" style="width: 60px" />
                    <g:textField name="valorRetenidoIce" value="${0}"/>
                </g:else>

            </div>

            <div class="span-28" style="margin-left: 40px; margin-top: 3px; margin-bottom: 3px">
                <label>Base Imponible IVA 0%</label>
                <g:textField name="biIva0" style="margin-left: 70px; margin-right: 85px" value="${proceso?.baseImponibleIva0}" readonly="true"/>
                <label>IVA(1) Bienes</label>

                <g:if test="${detalle?.impuesto?.sri == 'BNS'}">
                    <g:textField name="bienesBase" value="${detalle?.base}"/>
                    <g:textField name="bienesPorcentaje" value="${detalle?.porcentaje}" style="width: 60px"/>
                    <g:textField name="valorRetenidoBienes" value="${detalle?.total}"/>
                </g:if>
                <g:else>
                    <g:textField name="bienesBase" value="${0}"/>
                    <g:textField name="bienesPorcentaje" value="${0}" style="width: 60px"/>
                    <g:textField name="valorRetenidoBienes" value="${0}"/>

                </g:else>
            </div>

            <div class="span-28" style="margin-left: 40px; margin-top: 3px; margin-bottom: 3px">
                <label>Base Imponible IVA 12%</label>
                <g:textField name="biIva12" style="margin-left: 60px; margin-right: 25px" value="${proceso?.baseImponibleIva}" readonly="true"/>
                <label>IVA(2) Servicios y 100%</label>

                <g:if test="${detalle?.impuesto?.sri == 'SRV'}">
                    <g:textField name="serviciosBase" value="${detalle?.base}"/>
                    <g:textField name="serviciosPorcentaje" value="${detalle?.porcentaje}" style="width: 60px"/>
                    <g:textField name="valorRetenidoServicios" value="${detalle?.total}"/>
                </g:if>
                <g:else>

                    <g:textField name="serviciosBase" value="${0}"/>
                    <g:textField name="serviciosPorcentaje" value="${0}" style="width: 60px"/>
                    <g:textField name="valorRetenidoServicios" value="${0}" />
                </g:else>
            </div>

        </g:each>

        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
            <label>IVA</label>
            <g:textField name="iva12" style="margin-left: 195px" value="${proceso?.ivaGenerado}" readonly="true"/>
        </div>


        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
            <label style="margin-left: 200px">________________________________________________________________________</label>
        </div>

        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
            <label style="font-size: larger">Impuesto a la Renta</label>
        </div>

        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
            <label style="margin-left: 480px">Base Imponible</label>
            <label style="margin-left: 25px">%RBI</label>
            <label style="margin-left: 15px">Valor Retenido IR</label>
        </div>

        <div class="span-28" style="margin-left: 40px; margin-top: 5px; margin-bottom: 35px">
            <label>Concepto de la Retención del IR</label>
            <g:select name="conceptoRetencionImpuestoRenta" from="${cratos.ConceptoRetencionImpuestoRenta?.list()}" optionKey="id" optionValue="descripcion" style="width: 250px"/>

            <g:textField name="baseImponible" value="${detalleRetencion?.base}"/>
            %{--<g:textField name="porcentajeIR" value="" style="width: 50px"/>--}%
            <g:textField name="porcentajeIR" value="${detalleRetencion?.porcentaje}" style="width: 50px"/>

            <g:textField name="valorRetenido"/>

        </div>

        <div class="span-28" style="margin-left: 40px; margin-top: 20px; margin-bottom: 25px; margin-right: 25px">

            <label>Datos del Comprobante de Retención</label>

        </div>

        <div class="span-28" style="margin-left: 40px; margin-top: 15px; margin-bottom: 15px; margin-right: 25px">
            <label style="margin-left: 10px">Fecha Emisión</label>
            <label style="margin-left: 10px">N° Esta.</label>
            <label style="margin-left: 10px">N° Emisión</label>
            <label style="margin-left: 10px">N° Secuencial</label>
            <label style="margin-left: 10px">N° Autorización del Comprobante</label>
        </div>

        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px; margin-right: 25px">

            <elm:datePicker class="field ui-corner-all" name="fechaEmision" title="fecha"
                            minDate="'-1m'" maxDate="new Date()"
                            style="width: 80px; margin-left: 5px" format="yyyy-MM-dd" value="${retencion?.fechaEmision}"/>
            <g:textField name="numeroEstablecimiento" style="width: 60px" value="${retencion?.numeroEstablecimiento}"/>
            <g:textField name="numeroPuntoEmision" style="width: 60px" value="${retencion?.numeroPuntoEmision}"/>
            <g:textField name="retSecu"  style="width: 100px" value="${retencion?.numeroSecuencial}"/>
            <g:textField name="retAutorizacion" value="${retencion?.numeroAutorizacionComprobante}"/>
        </div>


        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px; margin-right: 25px">
            <g:link class="btn regresar ui-corner-all" id="${proceso?.id}" action="show">Regresar</g:link>
            <a href="#" class="btn grabar ui-corner-all" id="grabar">Aceptar</a>

        </div>

    </div>
</g:form>
<script type="text/javascript">

    $(".regresar").button();
    $(".grabar").button();



    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
                (ev.keyCode >= 96 && ev.keyCode <= 105) ||
                ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
                ev.keyCode == 37 || ev.keyCode == 39);
    }


    function validarNumDec(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
                (ev.keyCode >= 96 && ev.keyCode <= 105) ||
                ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
                ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 190 || ev.keyCode == 110);
    }





    $("#anioSri").val("${new Date().format('yyyy')}").change(function () {
        var anio = $(this).val();
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'getPeriodos')}",
            data    : {
                anio : anio
            },
            success : function (msg) {
                $("#mesSri").html(msg);
            }
        });
    });


    calculoRetencion();

    $("#baseImponible").keydown(function (ev) {


        var val = $(this).val();
        var dec = 2;

        if (ev.keyCode == 110 || ev.keyCode == 190) {

            if (!dec) {
                return false;
            } else {
                if (val.length == 0) {
                    $(this).val("0");

                }
                if (val.indexOf(".") > -1) {
                    return false;
                }
            }

        } else {


            if (val.indexOf(".") > -1) {
                if (dec) {
                    var parts = val.split(".");
                    var l = parts[1].length;
                    if (l >= dec) {
//                                return false;
                    }

                }
            } else {
                return validarNumDec(ev);

            }


        }

        return validarNumDec(ev);


    }).keyup(function () {

                calculoRetencion();


            });


    $("#porcentajeIR").keydown(function (ev) {
        var val = $(this).val();
        var dec = 2;

        if (ev.keyCode == 110 || ev.keyCode == 190) {

            if (!dec) {
                return false;
            } else {
                if (val.length == 0) {
                    $(this).val("0");
                }
                if (val.indexOf(".") > -1) {
                    return false;
                }
            }

        } else {


            if (val.indexOf(".") > -1) {
                if (dec) {
                    var parts = val.split(".");
                    var l = parts[1].length;
                    if (l >= dec) {
//                                return false;
                    }
                }
            } else {
                return validarNumDec(ev);
            }


        }

        return validarNumDec(ev);


    }).keyup(function () {

                calculoRetencion()

            });


    function calculoRetencion () {

        var total = 0

        total = (parseFloat($("#baseImponible").val())*parseFloat($("#porcentajeIR").val()))/100

        $("#valorRetenido").val(number_format(total, 2, ".", ""))

    }



    $("#grabar").click(function () {

        var id = ${proceso?.id}

                console.log("entro grabar")


        $.ajax({

            type: "POST",
            url: "${createLink(controller:'proceso' ,action: 'guardarSri')}",
            data : {
                id: id,
                credito: $("#credito").val(),
                pago: $("#pago").val(),
                fechaEmision: $("#fechaEmision").val(),
                numeroEstablecimiento: $("#numeroEstablecimiento").val(),
                numeroEmision: $("#numeroPuntoEmision").val(),
                numeroSecuencial: $("#retSecu").val(),
                numeroAutorizacion: $("#retAutorizacion").val(),
                concepto: $("#conceptoRetencionImpuestoRenta").val(),
                base: $("#baseImponible").val(),
                porcentaje: $("#porcentajeIR").val(),
                valorRetenido: $("#valorRetenido").val(),
                iceBase: $("#iceBase").val(),
                icePorcentaje: $("#icePorcentaje").val(),
                valorRetenidoIce: $("#valorRetenidoIce").val(),
                bienesBase: $("#bienesBase").val(),
                bienesPorcentaje: $("#bienesPorcentaje").val(),
                valorRetenidoBienes: $("#valorRetenidoBienes").val(),
                serviciosBase: $("#serviciosBase").val(),
                serviciosPorcentaje: $("#serviciosPorcentaje").val(),
                valorRetenidoServicios: $("#valorRetenidoServicios").val()


            },
            success: function (msg){
                if(msg == "ok") {

                    $("#divErrores").hide()
                    $("#divSuccess").show()
//                    $("#spanSuc").html(msg)

                } else {
                    $("#divSuccess").hide()
                    $("#divErrores").show()
                    $("#spanError").html(msg)


                }
            }
        });


    });


    $("#pago").change (function () {

        if($(this).val() == 'EXTERIOR'){
            $(".exterior").attr("hidden", false)
        }else {

            $(".exterior").attr("hidden", true)
        }



    })


</script>

</body>
</html>