<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <title>Reporte de ventas</title>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/css/bnw', file: 'jquery-ui-1.8.17.custom.css')}" type="text/css"/>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.7.1.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.17.custom.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}" type="text/css">
</head>
<body>
<div  style="float: left;font-size: 10px;width: 800px;height: 700px;margin-top: 10px;margin-left: 10px;background-color: #ffffff; ">
    <table width="800" style="float: left;font-size: 10px;width: 800px;height: 600px">
        <thead>
        <tr>
            <th>
                Factura
            </th>
            <th>
                Fecha
            </th>
            <th>
                Producto
            </th>
            <th>
                Monto
            </th>
            <th>
                Cantidad
            </th>
        </tr>
        </thead>
        <tbody>
        <g:set var="totMonto" value="${0}"></g:set>
        <g:set var="totCant" value="${0}"></g:set>
        <g:each in="${ventas}" var="v">

            <g:each in="${cratos.DetalleFactura.findAllByFactura(v)}" var="dt">
                <tr>
                    <td>${v.facturaSerie01+" "+v.facturaSerie02+" "+v.secuencial}</td>
                    <td>${v.fecha.format("dd/MM/yyyy hh:mm")}</td>
                    <td>${dt.item.nombre}</td>
                    <td style="text-align: right">${dt.cantidad*dt.precioUnitario}</td>
                    <td style="text-align: right">${dt.cantidad}</td>
                    <g:set var="totMonto" value="${totMonto.toDouble()+(dt.cantidad+dt.precioUnitario)}"></g:set>
                    <g:set var="totCant" value="${totCant.toDouble()+dt.cantidad}"></g:set>
                </tr>
            </g:each>


        </g:each>
        <tr>
            <td colspan="3">Total:</td>
            <td style="text-align: right">${totMonto}</td>
            <td style="text-align: right">${totCant}</td>

        </tr>

        </tbody>
    </table>

</div>
</body>
</html>