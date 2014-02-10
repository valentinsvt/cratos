<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Balance General</title>

    <style type="text/css">
    @page {
        size   : 21cm 29.7cm;  /*width height */
        margin : 2cm;
    }

    html {
        font-family : Verdana, Arial, sans-serif;
        font-size   : 11px;
    }

    .hoja {
        width : 16.5cm;
        /*background : #d8f0fa;*/
    }

    h1, h2, h3 {
        text-align : center;
    }

    h1 {
        font-size  : 14px;
        margin-top : 30px;
    }

    table {
        border-collapse : collapse;
        width           : 100%;
    }

    /*th, td {*/
    /*vertical-align : middle;*/
    /*}*/

    th {
        background : #bbb;
    }

    .even {
        background : #ddd;
    }

    .odd {
        background : #efefef;
    }

    .cliente th {
        background : #D1D1D1 !important;
    }

    .right {
        text-align : right;
    }

    .errorReporte {
        font-size   : 20px;
        font-weight : bold;
        padding     : 20px;
        text-align  : center;
        border      : solid 1px #a31b27;
        color       : #a31b27;
        background  : #ffcecf;
    }
    .titulo{
        font-size: 14px;
        font-weight: bold;
    }

    .Dos{
        padding-left: 0px;
        font-size:11px ;
    }
    .Tres{
        padding-left: 10px;
        font-size:11px ;
    }
    .Cuatro{
        padding-left: 20px;
        font-size:11px ;
    }
    .Cinco{
        padding-left: 30px;
        font-size:11px ;
    }

    .numDos{
        padding-right: 0px;
        font-size:11px ;
    }
    .numTres{
        padding-right: 10px;
        font-size:11px ;
    }
    .numCuatro{
        padding-right: 20px;
        font-size:11px ;
    }
    .numCinco{
        padding-right: 30px;
        font-size:11px ;
    }
    </style>

</head>

<body>
<div class="hoja">
    <h1 style="margin-bottom: 5px">${contabilidad.institucion.nombre}<br/>
        Balance general
    </h1>
    %{--<h1>${contabilidad.descripcion}</h1>--}%
    <h3>Al ${periodo?.fechaFin?.format("dd-MM-yyyy")}</h3>

    <g:each in="${paginas}" var="p">
        <div style="width: 100%;margin-top: 10px;${(p.key!="EGRESOS")?"page-break-after:always":""}">
            <h1>${p.key}</h1>
            <table style="margin-top: 10px">
                <tbody>
                <g:set var="cont" value="${0}"></g:set>
                <g:each in="${p.value}" var="cnta" status="i">
                    <g:if test="${i==0}">
                    %{--<g:set var="tot" value="${saldos[cnta.id.toString()]?.toDouble()?.round(2)}"></g:set>--}%
                        <g:set var="tot" value="${saldos[cnta.id.toString()]}"></g:set>
                    </g:if>
                    <g:else>
                        <g:if test="${ceros=='1'}">
                            <tr class="${(i%2==0)?'even':''}">
                                <td class="${cnta.nivel.descripcion}">
                                    ${cnta.numero} - ${cnta.descripcion}
                                </td>
                                <td style="text-align: right"  >
                                    %{--${saldos[cnta.id.toString()].round(2)}--}%
                                    ${saldos[cnta.id.toString()].toDouble().round(2)}
                                </td>
                            </tr>
                        </g:if>
                        <g:else>
                            <g:if test="${Math.abs(saldos[cnta.id.toString()]).toDouble()>0.0}">
                                <tr class="${(cont%2==0)?'even':''}">
                                    <td class="${cnta.nivel.descripcion}" >
                                        ${cnta.numero} - ${cnta.descripcion}
                                    </td>
                                    <td style="text-align: right"  >
                                        %{--${saldos[cnta.id.toString()].round(2)}--}%
                                        ${saldos[cnta.id.toString()].toDouble().round(2)}
                                    </td>
                                </tr>
                                <g:set var="cont" value="${cont+1}"></g:set>
                            </g:if>
                        </g:else>
                    </g:else>

                </g:each>
                </tbody>
                <tfoot>
                <tr>
                    <td>
                        TOTAL
                    </td>
                    <td style="text-align: right">
                        ${tot.toDouble().round(2)}
                    </td>
                </tr>
                </tfoot>
            </table>
            <h1 style="text-align: left;float: left;width: 100%;">TOTAL ${p.key}: ${tot.toDouble().round(2)}</h1>
            <g:if test="${(p.key=="PATRIMONIO")}">
            %{--<h1 style="text-align: left;float: left;width: 100%;">TOTAL PASIVO Y PATRIMONIO: ${(saldos[cntaPas.id.toString()].toDouble()+saldos[cntaPat.id.toString()].toDouble())?.round(2)}</h1>--}%
                <h1 style="text-align: left;float: left;width: 100%;">TOTAL PASIVO Y PATRIMONIO: ${(saldos[cntaPas.id.toString()]+saldos[cntaPat.id.toString()]).toDouble().round(2)}</h1>
            </g:if>
            <g:if test="${firma1}">
                <div style="width: 170px;height: 10px;float: left;margin-top: 150px;border-top: 1px solid black;text-align: center">
                    <b>${firma1?.replaceAll("_"," ")}</b>
                </div>
            </g:if>
            <g:if test="${firma2}">
                <div style="width: 170px;height: 10px;float: right;margin-top: 150px;border-top: 1px solid black;text-align: center">
                    <b>${firma2?.replaceAll("_"," ")}</b>
                </div>
            </g:if>
        </div>
    </g:each>


</div>
</body>
</html>