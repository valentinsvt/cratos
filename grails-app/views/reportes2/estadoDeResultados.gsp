<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Situacion financiera</title>
    <style type="text/css">
    @page {
        size   : 21cm 29.7cm;  /*width height */
        margin : 2cm;
    }

    html {
        font-family : Verdana, Arial, sans-serif;
        font-size   : 10px;
    }

    .hoja {
        width : 16cm;
        /*background : #d8f0fa;*/
    }

    h1, h2, h3 {
        text-align : center;
    }

    h2{
        font-size: 12px;
    }
    h3{
        font-size: 10px;
    }
    table {
        border-collapse : collapse;
        width           : 100%;
    }

    th, td {
        vertical-align : middle;

    }

    .valor {

        text-align: right;


    }

    th {
        background : #bbb;
    }

    .even {
        background : #ddd;
    }

    .odd {
        background : #efefef;
    }

    .Uno {
        background : #DDDDC0;
        /*color      : #FFF;*/
    }

    .Dos {
        background : #DDDDD0;
    }

    .Tres {
        background : #EDEDE0;
    }

    .Cuatro {
        background : #DDDDF0;
    }

    .Cinco {
        background : #DDEDFF;
    }

    .Seis {
        background : #EDDDFF;
    }

    .saldo {
        text-align : right;
    }

    .Uno .saldo {
        margin-right : 0;
    }

    .Dos .saldo {
        padding-right : 20px;
    }

    .Tres .saldo {
        padding-right : 40px;
    }

    .Cuatro .saldo {
        padding-right : 60px;
    }

    .Cinco .saldo {
        padding-right : 80px;
    }

    .Seis .saldo {
        padding-right : 100px;
    }

    .Uno .numero {
        margin-left : 0;
    }

    .Dos .numero {
        padding-left : 20px;
    }

    .Tres .numero {
        padding-left : 40px;
    }

    .Cuatro .numero {
        padding-left : 60px;
    }

    .Cinco .numero {
        padding-left : 80px;
    }

    .Seis .numero {
        padding-left : 100px;
    }
    </style>

</head>

<body>
<div class="hoja">
    %{--<h1>Periodo ${periodo.numero}</h1>--}%

    <h2>Estado de resultados</h2>

    <h3>Periodo del ${periodo.fechaInicio.format('dd-MM-yyyy')} a ${periodo.fechaFin.format('dd-MM-yyyy')}</h3>

    <table border="1">

        <tr>

        <td style="font-size: 12px; font-weight: bold; text-align: center">Cuenta</td>
        <td style="font-size: 12px; font-weight: bold; text-align: center">Nombre de la Cuenta</td>
            <td> </td>
        <td style="font-size: 12px; font-weight: bold; text-align: center">Saldos</td>

            <td> </td>
            <td> </td>

        </tr>


        <tr>

            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>

        </tr>




        <g:each in="${cuenta4}" var="i">
            <tr>
                <td class="numero">

                    ${i?.numero}
                </td>
                <td class="nombre">
                     ${i?.descripcion}
                </td>

                <g:if test="${i.nivel.id == 1}">

                <td class="valor1 valor">
                    <g:formatNumber number="${cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.refresh()?.saldoInicial + cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.debe - cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.haber  }"
                                    type="number" minFractionDigits="2" maxFractionDigits="2"/>

                </td>
                    <td></td>
                    <td></td>
                    <td></td>

                </g:if>
                <g:if test="${i.nivel.id == 2}">
                    <td></td>
                    <td class="valor2 valor">
                    <g:formatNumber number="${cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.refresh()?.saldoInicial + cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.debe - cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.haber  }"
                                    type="number" minFractionDigits="2" maxFractionDigits="2"/>

                    </td>
                    <td></td>
                    <td></td>
                </g:if>
                <g:if test="${i.nivel.id == 3}">
                    <td></td>
                    <td></td>
                    <td class="valor1 valor">
                        <g:formatNumber number="${cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.refresh()?.saldoInicial + cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.debe - cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.haber  }"
                                        type="number" minFractionDigits="2" maxFractionDigits="2"/>

                    </td>
                    <td></td>

                </g:if>
                <g:if test="${i.nivel.id == 4}">
                    <td></td>
                    <td></td>
                    <td class="valor2 valor">
                        <g:formatNumber number="${cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.refresh()?.saldoInicial + cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.debe - cratos.SaldoMensual.findAllByCuentaAndPeriodo(i,periodo)[0]?.haber  }"
                                        type="number" minFractionDigits="2" maxFractionDigits="2"/>

                    </td>
                </g:if>


            </tr>
        </g:each>

            <g:each in="${cuenta5}" var="j">
                 <tr>
                    <td class="numero">

                        ${j?.numero}

                    </td>
                    <td class="nombre">
                        ${j?.descripcion}

                    </td>
                     <g:if test="${j.nivel.id == 1}">

                         <td class="valor1 valor">
                             <g:formatNumber number="${cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.refresh()?.saldoInicial + cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.debe - cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.haber  }"
                                             type="number" minFractionDigits="2" maxFractionDigits="2"/>

                         </td>
                         <td></td>
                         <td></td>
                         <td></td>

                     </g:if>
                     <g:if test="${j.nivel.id == 2}">
                         <td></td>
                         <td class="valor2 valor">
                             <g:formatNumber number="${cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.refresh()?.saldoInicial + cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.debe - cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.haber  }"
                                             type="number" minFractionDigits="2" maxFractionDigits="2"/>

                         </td>
                         <td></td>
                         <td></td>
                     </g:if>
                     <g:if test="${j.nivel.id == 3}">
                         <td></td>
                         <td></td>
                         <td class="valor1 valor">
                             <g:formatNumber number="${cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.refresh()?.saldoInicial + cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.debe - cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.haber  }"
                                             type="number" minFractionDigits="2" maxFractionDigits="2"/>

                         </td>
                         <td></td>

                     </g:if>
                     <g:if test="${j.nivel.id == 4}">
                         <td></td>
                         <td></td>
                         <td class="valor2 valor">
                             <g:formatNumber number="${cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.refresh()?.saldoInicial + cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.debe - cratos.SaldoMensual.findAllByCuentaAndPeriodo(j,periodo)[0]?.haber  }"
                                             type="number" minFractionDigits="2" maxFractionDigits="2"/>

                         </td>
                     </g:if>
                </tr>


        </g:each>


        <tr>

            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>

        </tr>

        <tr>

            <td>TOTAL</td>
            <td> </td>
            <td> </td>
            <td> </td>

            <td class="valor">

                <g:formatNumber number="${totalResultados}" type="number" minFractionDigits="2" maxFractionDigits="2"/>

            </td>
            <td> </td>
        </tr>


    </table>



</div>

</body>
</html>