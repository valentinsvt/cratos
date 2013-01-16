<%@ page import="cratos.Adquisiciones" %>
<!doctype html>
<html>
<head>

    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'adquisiciones.label', default: 'Adquisiciones')}"/>
    <title>Ver Adquisiciones</title>

    <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
    <link type="text/css" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"
          rel="stylesheet"/>

    <style type="text/css">

    .label {
        font-weight : bold;
    }

    .hover {
        background : #ffd125 !important;
        cursor     : pointer;
    }

    .selected {
        border     : #FF8010 solid 2px !important;
        background : #F7E7D9 !important;
    }




    </style>

</head>

<body>
<a href="#show-adquisiciones" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                    default="Skip to content&hellip;"/></a>

<div id="show-adquisiciones" class="content scaffold-show" role="main">
<div class="ui-widget-header ui-corner-all nav navegacion">
    <ul style="margin-bottom:0;">
        <li><g:link class="list linkButton" action="list">Lista</g:link></li>
        <li><g:link class="create linkButton" action="create">Crear Adquisición</g:link></li>
        <g:if test="${adquisicionesInstance.estado=='R'}">
            <li><g:link class="list linkButton" controller="reportes" action="retencion"
                        id="${adquisicionesInstance.id}" params="${[id: adquisicionesInstance.id, empr: adquisicionesInstance.empresa.id]}" target="_blank">Retención</g:link>
            </li>
        </g:if>
        <g:else>
            <li>
                <g:link action="create" class="linkButton" id="${adquisicionesInstance.id}">Editar</g:link>
            </li>
            <li>
                <a href="#" class="linkButton" id="registrar" adq="${adquisicionesInstance.id}">Registrar</a>
            </li>
        </g:else>
    </ul>
</div>

<div class="contenedor" style="height: 650px; width: 900px">
<h1>Detalle Adquisiciones</h1>
<g:if test="${flash.message}">
    <div class="message ${flash.clase}" role="status"><span
            class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
    </div>
</g:if>
<fieldset style="margin: 20px">
    <legend>Adquisiciones</legend>

    <div class="container span-15">

        <div class="fila span-20">

        %{--<g:if test="${adquisicionesInstance?.factura}">--}%

        %{--<div class="span-3 label">--}%
        %{--Factura--}%
        %{--</div>--}%

        %{--<div class="span-6">--}%

        %{--<g:fieldValue bean="${adquisicionesInstance}" field="factura"/>--}%

        %{--</div>--}%

        %{--</g:if>--}%


            <g:if test="${adquisicionesInstance?.fecha}">

                <div class="span-3  label">
                    Fecha
                </div>

                <div class="span-6">

                    <g:formatDate date="${adquisicionesInstance?.fecha}" format="dd-MM-yyyy"/>

                </div>

            </g:if>

        </div>

        <div class="fila span-20">

            <g:if test="${adquisicionesInstance?.empresa}">

                <div class="span-3 label">
                    Empresa
                </div>

                <div class="span-6">
                    <g:fieldValue bean="${adquisicionesInstance?.empresa}" field="nombre"></g:fieldValue>

                </div>

            </g:if>


            <g:if test="${adquisicionesInstance?.fechaPago}">
                <div class="span-3 prepend-1 label">
                    Fecha Pago
                </div>

                <div class="span-6">

                    <g:formatDate date="${adquisicionesInstance?.fechaPago}" format="dd-MM-yyyy"/>

                </div>
            </g:if>

        </div>

        <div class="fila span-20">

            <g:if test="${adquisicionesInstance?.proveedor}">

                <div class="span-3 label">
                    Proveedor
                </div>

                <div class="span-6">

                    <g:fieldValue bean="${adquisicionesInstance?.proveedor}" field="nombreContacto"></g:fieldValue>

                </div>

            </g:if>

            <g:if test="${adquisicionesInstance?.tipoPago}">

                <div class="span-3 prepend-1 label">
                    Tipo Pago
                </div>

                <div class="span-6">

                    <g:fieldValue bean="${adquisicionesInstance?.tipoPago}" field="descripcion"></g:fieldValue>

                </div>

            </g:if>

        </div>

        <div class="fila span-20">

            <g:if test="${adquisicionesInstance?.cheque}">

                <div class="span-3 label">
                    Cheque
                </div>

                <div class="span-6">

                    <g:fieldValue bean="${adquisicionesInstance}" field="cheque"/>

                </div>

            </g:if>

        </div>

        <div class="fila span-20">
            <g:if test="${adquisicionesInstance?.estadoCheque}">

                <div class="span-3 label">
                    Estado Cheque
                </div>

                <div class="span-6">

                    <g:fieldValue bean="${adquisicionesInstance}" field="estadoCheque"/>

                </div>

            </g:if>

        </div>

        <div class="fila span-20">

            <g:if test="${adquisicionesInstance?.observaciones}">

                <div class="span-3">
                    Observaciones
                </div>

                <div class="span-6">

                    <g:fieldValue bean="${adquisicionesInstance}" field="observaciones"/>

                </div>

            </g:if>

        </div>

    </div>
</fieldset>

<fieldset style="margin: 20px;">
    <legend>Productos</legend>

    <table id="tblItems" border="1" style="border-collapse: collapse;">
        <thead>
        <tr>

            <th width="100">
                Código
            </th>
            <th width="300">
                Item
            </th>
            <th width="50" class="cantidad">
                Cantidad
            </th>
            <th width="100" class="precioUnitario">
                Precio Unitario
            </th>
            <th width="60" style="text-align: center">
                IVA
            </th>
            <th width="60" style="text-align: center">
                ICE
            </th>
            <th width="80" style="text-align: center" class="subtotal">
                Subtotal
            </th>


        </tr>
        </thead>
        <g:set var="total" value="${0}"/>
        <g:set var="iva" value="${0}"/>
        <g:set var="ice" value="${0}"/>
        <tbody id="tbItems">
        <g:each in="${cratos.DetalleAdquisicion.findAllByAdquisiciones(adquisicionesInstance)}" var="item">
            <tr>

                <td>${item.item.codigo}</td>
                <td>${item.item.nombre}</td>
                <td style="text-align: right">${item.cantidad}</td>
                <td style="text-align: right">${item.precioUnitario}</td>
                <td style="text-align: right">${item.iva}</td>
                <td style="text-align: right">${item.ice}</td>
                <td style="text-align: right">
                    <g:set var="total" value="${total.toDouble() + item.subtotal}"/>
                    <g:set var="iva" value="${iva.toDouble() + item.iva}"/>
                    <g:set var="ice" value="${ice.toDouble() + item.ice}"/>
                    <g:formatNumber number="${item.subtotal+item.iva+item.ice}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
                </td>


            </tr>
        </g:each>
        </tbody>
    </table>

    <br/>

    <div class="span-5">

        <table border="1" style="border-collapse: collapse;">
            <tr>
                <th>Subtotal</th>
                <td id="tdSubtotalFin" style="text-align: right;"><g:formatNumber number="${total}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            </tr>

            <tr>
                <th>Impuestos </th>
                <td id="tdIvaFin" style="text-align: right;"><g:formatNumber number="${iva+ice}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            </tr>
            <tr>
                <th>TOTAL</th>
                <td id="tdTotalFin" style="text-align: right;"><g:formatNumber number="${total + iva+ice}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            </tr>
        </table>

    </div>
</fieldset>

</div>

<div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
    %{--<g:link class="delete linkButton">Eliminar</g:link>--}%
    %{--<g:link class="edit linkButton" action="edit" id="${adquisicionesInstance?.id}">Editar</g:link>--}%
</div>
</div>

<div id="busqueda">
</div>

<script type="text/javascript">
    $("#registrar").click(function(){

        if(confirm("Esta seguro que desea registrar esta adquisición?. Una vez registrada no podra modificarla")){
            $.ajax({
                type    : "POST",
                url     : "${createLink(action: 'registrar')}",
                data    : {
                    id:$(this).attr("adq")
                },
                success : function (msg) {
                    if(msg=="OK")
                        window.location.reload(true)
                    else
                        alert("Error ")

                }
            });
        }

    });
</script>

</body>

</html>
