<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Reporte Facturación</title>

    <style type="text/css">
    @page {
        size: 21cm 29.7cm;  /*width height */
        margin: 2cm;
    }

    html {
        font-family: Verdana, Arial, sans-serif;
        font-size: 15px;
    }

    .hoja {
        width: 25cm;

    }

    h1, h2, h3 {
        text-align: center;
    }

    table {
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        vertical-align: middle;
    }

    th {
        background: #bbb;
    }

    .even {
        background: #ddd;
    }

    .odd {
        background: #efefef;
    }
    </style>

</head>

<body>

<h1 style="font-weight: 200;" align="center">Reporte Ventas Facturación</h1>

<h2>
    Periodo: Desde:<g:formatDate date="${periodo?.fechaInicio}" format="dd-MM-yyyy"/>

    Hasta:<g:formatDate date="${periodo?.fechaFin}" format="dd-MM-yyyy"/>
</h2>

<h2>
    Cuenta: ${cuenta?.numero} ${cuenta?.descripcion}
    </h2>

<div>


    <table>

        <thead>
        <tr style="font-size: 11px">
            <th align="center" >Fecha</th>
            <th align="center"># Factura</th>
            <th align="center" style="">Cliente</th>
            <th align="center" style="width: 100px;">Subtotal</th>
            <th align="center" style="width: 100px;">Iva</th>
            <th align="center">Total</th>
        </tr>
        </thead>

        <tbody>

        <g:each in="${asientos}" var="asiento" status="j">


            <tr class="${j % 2 == 0 ? 'even2' : 'odd2'}" style="font-size: 10px;">

                <td class="fecha" align="center">

                    <g:formatDate date="${asiento?.comprobante?.proceso?.fecha}" format="dd-MM-yyyy hh:mm"/>

                </td>

                <td class="factura" align="center" style="width: 40px;">

                    ${asiento?.comprobante?.proceso?.documento}


                </td>

                <td class="cliente" align="center">

                    ${asiento?.comprobante?.proceso?.proveedor?.nombre}
                </td>


                <td class="subt" style="text-align: center">

                    <g:formatNumber number="${asiento?.comprobante?.proceso?.valor}" maxFractionDigits="2" minFractionDigits="2" type="number"/>

                </td>


                <td class="iva" style="text-align: center">

                    <g:formatNumber number="${asiento?.comprobante?.proceso?.ivaGenerado}" maxFractionDigits="2" minFractionDigits="2" type="number"/>

                </td>


                <td class="iva" style="text-align: center">

                    <g:formatNumber number="${asiento?.comprobante?.proceso?.valor + asiento?.comprobante?.proceso?.ivaGenerado}" maxFractionDigits="2" minFractionDigits="2" type="number"/>

                </td>

            </tr>

        </g:each>



        </tbody>
    </table>

</div>

</body>
</html>