<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Auxiliares Contables</title>

    <style type="text/css">
    @page {
        size: 29.7cm 21cm;  /*width height */
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

<h1 style="font-weight: 200;" align="center">Auxiliar Contable</h1>

<h2>
    Periodo: Desde:<g:formatDate date="${periodo?.fechaInicio}" format="dd-MM-yyyy"/>

    Hasta:<g:formatDate date="${periodo?.fechaFin}" format="dd-MM-yyyy"/>
</h2>

<h2>
    Cuenta: ${cuenta.numero} ${cuenta.descripcion}
</h2>

<div>

    <table>
        <g:if test="${saldoMensual != null}">
            <td>  Saldo Inicial:<g:formatNumber number="${saldoInicialMostrar}" minFractionDigits="2" maxFractionDigits="2" type="number"/> </td>
            <td> Saldo Final: <g:formatNumber number="${saldoInicial}" maxFractionDigits="2" minFractionDigits="2" type="number"/> </td>
        </g:if>
        <g:else>
            <td>  Saldo Inicial: 0.0 </td>
            <td> Saldo Final: <g:formatNumber number="${saldoInicial}" maxFractionDigits="2" minFractionDigits="2" type="number"/> </td>
        </g:else>
    </table>


</div>


<div>

    <table border="1">

        <thead>
        <tr style="font-size: 11px">
            <th align="center" >Id</th>
            <th align="center">Fecha</th>
            <th align="center" style="width: 40px;">Tipo</th>
            <th align="center" style="">#</th>
            <th align="center" style="width: 130px;">Proveedor</th>
            <th align="center" style="width: 420px;">Descripción</th>
            <th align="center" style="width: 60px;">Documento</th>
            <th align="center">Debe</th>
            <th align="center" style="">Haber</th>
            <th align="center" style="">Saldo</th>
        </tr>
        </thead>

        <tbody>

        <g:each in="${asiento}" var="asientos" status="j">


            <tr class="${j % 2 == 0 ? 'even2' : 'odd2'}" style="font-size: 10px;">

                <td class="procesoId" align="center">
                    ${asientos.comprobante.proceso.id}

                </td>
                <td class="procesoFecha" align="center">

                    <g:formatDate date="${asientos.comprobante.proceso.fecha}" format="dd-MM-yyyy"/>

                </td>

                <td class="tipo" align="center" style="width: 40px;">

                    ${asientos.comprobante.tipo.codigo}

                </td>

                <td class="numero" align="center">

                    ${asientos.comprobante.numero}
                </td>


                <td class="tipo" align="center" style="width: 130px;text-align: left">

                    ${asientos.comprobante.proceso.proveedor}

                </td>

                <td class="procesoDesc" align="center" style="text-align: left">
                    ${asientos.comprobante.proceso.descripcion}

                </td>

                <td class="documentos" style="text-align: right">

                    ${asientos?.comprobante?.proceso?.documento}
                </td>
                <td class="debe" style="text-align: right;padding-right: 5px;">

                    <g:formatNumber number="${asientos.debe}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                    %{--${asientos?.debe}--}%
                </td>
                <td class="haber" style="text-align: right;padding-right: 5px;">
                    <g:formatNumber number="${asientos.haber}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                    %{--${asientos?.haber}--}%

                </td>

                <td class="saldo" style="text-align: right;padding-right: 5px;">

                    <g:formatNumber number="${saldo[j]}" maxFractionDigits="2" minFractionDigits="2" type="number"/>

                    %{--${saldo[j]}--}%

                </td>





            </tr>

        </g:each>



        </tbody>
    </table>

</div>

</body>
</html>