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


    .numero {
        text-align : right;
    }

    .Uno {
        padding-right : ${((maxLvl-1)*60)+5}px;
    }
    .Dos {
        padding-right : ${((maxLvl-2)*60)+5}px;
    }
    .Tres  {
        padding-right :${((maxLvl-3)*60)+5}px;
    }
    .Cuatro  {
        padding-right : ${((maxLvl-4)*60)+5}px;
    }
    .Cinco  {
        padding-right : ${((maxLvl-5)*60)+5}px;
    }
    </style>

</head>

<body>
<div class="hoja">
    %{--<h1>Periodo ${periodo.numero}</h1>--}%
    <h1 style="margin-bottom: 5px">${empresa.nombre}</h1>
    <h2>Estado de resultados</h2>

    <h3>Periodo del ${periodo.fechaInicio.format('dd-MM-yyyy')} a ${periodo.fechaFin.format('dd-MM-yyyy')}</h3>

    <table border="1" style="width: 630px !important;">
        <thead>
        <tr>
            <td colspan="3">INGRESOS</td>
        </tr>
        <tr>
            <td style="font-size: 12px; font-weight: bold; text-align: center">Cuenta</td>
            <td style="font-size: 12px; font-weight: bold; text-align: center">Nombre de la Cuenta</td>
            <td style="font-size: 12px; font-weight: bold; text-align: center">Saldo </td>
        </tr>
        </thead>
        <tbody>
        <g:each in="${cuenta4}" var="i">
            <tr>
                <td class="numero">
                    ${i?.numero}
                </td>
                <td class="nombre">
                    ${i?.descripcion}
                </td>
                <td class="${i.nivel.descripcion} numero">
                    <g:formatNumber number="${saldo4[i.id.toString()]}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                </td>
            </tr>
        </g:each>
        <tr>
            <td style="font-weight: bolder">TOTAL INGRESOS</td>
            <td colspan="2" class="numero"><g:formatNumber number="${total4}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
        </tr>
        </tbody>
    </table>
    <table border="1" style="width: 630px !important;margin-top: 20px;">
        <thead>
        <tr>
            <td colspan="3">EGRESOS</td>
        </tr>
        <tr>
            <td style="font-size: 12px; font-weight: bold; text-align: center">Cuenta</td>
            <td style="font-size: 12px; font-weight: bold; text-align: center">Nombre de la Cuenta</td>
            <td style="font-size: 12px; font-weight: bold; text-align: center">Saldo </td>
        </tr>
        </thead>
        <tbody>
        <g:each in="${cuenta5}" var="i">
            <tr>
                <td class="numero">
                    ${i?.numero}
                </td>
                <td class="nombre">
                    ${i?.descripcion}
                </td>
                <td class="${i.nivel.descripcion} numero">
                    <g:formatNumber number="${saldo5[i.id.toString()]}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                </td>
            </tr>
        </g:each>
        <tr>
            <td style="font-weight: bolder">TOTAL EGRESOS</td>
            <td colspan="2" class="numero"><g:formatNumber number="${total5}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
        </tr>
        </tbody>
    </table>

    <div style="margin-top: 30px">
        <g:if test="${(total4+total5)>0}">
            Resultado del ejercicio:  <b>DEFICIT <g:formatNumber number="${Math.abs(total4+total5)}" type="number" minFractionDigits="2" maxFractionDigits="2"/></b>
        </g:if>
        <g:else>
            Resultado del ejercicio:  <b>SUPERAVIT <g:formatNumber number="${Math.abs(total4+total5)}" type="number" minFractionDigits="2" maxFractionDigits="2"/></b>
        </g:else>

    </div>


</div>

</body>
</html>