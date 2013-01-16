<html>
<head>

    <title>Reporte Orden de compra</title>

    <style type="text/css">
    tr:nth-child(2n+1), tr:nth-child(2n) {
        background: none;
    }

    .barra {

        color: black !important;

    }


    table {
        border: none;
        width: auto;
    }

    .bg td {
        background: #eee;
    }

    .hover {
        background: #ffd125 !important;
        cursor: pointer;
    }

    .label {
        font-weight: bold;
    }

    .selected {
        border: #FF8010 solid 2px !important;
        background: #F7E7D9 !important;
    }

    .tarjeta {
        display: none;
    }

    ul {
        list-style: disc;
        padding-left: 40px;
    }

    .error {
        border: solid 2px #cc0000;
        background: #ccaaaa;
    }
    </style>

</head>

<body>
<g:set var="detalles" value="${cratos.DetalleOrdenCompra.findAllByOrdenCompra(ordenCompraInstance)}"/>

<div id="show-ordenCompra" class="content scaffold-create noshowgrid" role="main">
    <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">

    </div>

    <div class="contenedor">
        <h1 style="padding-left: 30px">Reporte Orden de compra</h1>
        <g:if test="${flash.message}">
            <div class="message ${flash.clase}" role="status"><span
                    class="ss_sprite ${flash.ico}"></span>${flash.message}
            </div>
        </g:if>
        <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all"
             id="divErrores">
            <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
            <strong>Se encontraron los siguientes errores:</strong>

            <div id="listaErrores"></div>
        </div>

        <fieldset style="width: 500px">

            <legend>Orden de compra</legend>

                <div class="">Centro de costo:</div>

                <div class="">
                    ${ordenCompraInstance.centroCosto.nombre}
                </div>

                <div class="">Fecha:</div>

                <div class="">
                    <g:formatDate date="${ordenCompraInstance.fecha}" format="dd-MM-yyyy"/>
                </div>

            <div class="span-20">

                <div class="span-3">Estado:</div>

                <div class="span-6" id="estado">

                    <g:if test="${ordenCompraInstance.estado == 'R'}">
                        Registrado
                    </g:if>
                    <g:else>
                        <g:if test="${ordenCompraInstance.estado == 'C'}">
                            Comprado

                        </g:if>
                        <g:else>
                            No Registrado
                        </g:else>
                    </g:else>
                </div>

                <div class="span-3 prepend-1">Observaciones:</div>

                <div class="span-6">
                    ${ordenCompraInstance.observaciones}
                </div>
            </div>

            <div class="span-20">
                <div class="span-3">Descripción:</div>

                <div class="span-6">
                    ${ordenCompraInstance.descripcion}
                </div>
            </div>


        </fieldset>

        <fieldset style="width: 500px">
            <legend>Productos</legend>

            <table id="tblItems" border="1" style="border-collapse: collapse;">
                <thead>
                <tr>
                    <th width="50" class="cantidad" style="background:#B7C4F7">
                        Cantidad
                    </th>
                    <th width="100" style="background: #B7C4F7">
                        Código
                    </th>
                    <th width="300" style="background: #B7C4F7">
                        Item
                    </th>
                    <th width="100" class="precioUnitario" style="background: #B7C4F7">
                        Precio Unitario
                    </th>

                    <th width="80" class="subtotal" style="background: #B7C4F7">
                        Subtotal
                    </th>

                </tr>
                </thead>
                <tbody id="tbItems">
                <g:each in="${detalles}" var="item">
                    <tr>
                        <td>${item.cantidad}</td>
                        <td>${item.item.codigo}</td>
                        <td>${item.item.nombre}</td>
                        <td><g:formatNumber number="${item.precioUnitario}" minFractionDigits="2"
                                            maxFractionDigits="2"/></td>

                        <td>
                            <g:set var="total" value="${(item.cantidad * item.precioUnitario)}"/>
                            <g:formatNumber number="${total}" minFractionDigits="2" maxFractionDigits="2"/>
                        </td>

                    </tr>
                </g:each>
                </tbody>
            </table>

            <br/>


            <table border="1" style="border-collapse: collapse;">
                <tr>
                    <td style="background: #B7C4F7">Subtotal</td>
                    <td id="tdSubtotalFin" style="text-align: right;"><g:formatNumber
                            number="${ordenCompraInstance.valor}" minFractionDigits="2" maxFractionDigits="2"/></td>
                </tr>

            </table>

        </fieldset>

    </div>



</div>


</body>
</html>


