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

        h2 {
            font-size : 12px;
        }

        h3 {
            font-size : 10px;
        }

        table {
            border-collapse : collapse;
            width           : 100%;
        }

        th, td {
            vertical-align : middle;
        }

        th {
            background : #bbb;
        }

        .numero {
            text-align : right;
        }

        .bold {
            font-weight : bold;
        }
        </style>

    </head>

    <body>
        <div class="hoja">
            %{--<h1>Periodo ${periodo.numero}</h1>--}%

            <h2>Situación financiera</h2>

            <h3>Periodo del ${periodo.fechaInicio.format('dd-MM-yyyy')} a ${periodo.fechaFin.format('dd-MM-yyyy')}</h3>

            <g:set var="pos" value="${[1, 4]}"/>
            <g:set var="neg" value="${[2, 3, 5]}"/>
            <g:set var="tot" value="${0}"/>

            <table border='1' style="font-size: 10px !important;">
                <thead>
                    <tr>
                        <th>Número</th>
                        <th>Cuenta</th>
                        <th>Debe</th>
                        <th>Haber</th>
                        <th>Saldo</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${datos}" var="d">
                        <g:set var="val" value="${d ? d.saldoInicial + (d.debe - d.haber) : 0}"/>
                        <g:if test="${d.cuenta.numero.contains('1') || d.cuenta.numero.contains('4')}">
                            <g:set var="tot" value="${tot + val}"/>
                        </g:if>
                        <g:else>
                            <g:set var="tot" value="${tot - val}"/>
                        </g:else>
                        <tr>
                            <td>
                                ${d ? d.cuenta.numero : ""}
                            </td>
                            <td>
                                ${d ? d.cuenta.descripcion : ""}
                            </td>
                            <td class="numero">
                                <g:formatNumber number="${d ? (d.debe) : 0}" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                            </td>
                            <td class="numero">
                                <g:formatNumber number="${d ? (d.haber) : 0}" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                            </td>
                            <td class="numero">
                                <g:formatNumber number="${val}" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
                <tfoot>
                    <tr class="bold">
                        <td colspan="4">
                            RESULTADO (1-2-3+4-5)
                        </td>
                        <td class="numero">
                            <g:formatNumber number="${tot}" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>

    </body>
</html>