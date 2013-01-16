<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 10/4/12
  Time: 3:19 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title></title>

        <style type="text/css">
        @page {
            size   : 21cm 29.7cm;  /*width height */
            margin : 2cm;
        }

        html {
            font-family : Verdana, Arial, sans-serif;
            font-size   : 10px !important;
        }

        .hoja {
            width      : 17cm;
            min-height : 25cm;
            background : #d8f0fa;
        }

        h1, h2, h3 {
            text-align : center;
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

        .even {
            background : #ddd;
        }

        .odd {
            background : #efefef;
        }

        .even2 {
            background : #dddfff;
        }

        .odd2 {
            background : #ff1fef;
        }

        .valor {
            text-align : right;
        }
        </style>

    </head>

    <body>
        <div class="hoja">
            <h1>${empresa.nombre}</h1>

            <h2>ESTADO DE SITUACIÓN FINANCIERA</h2>

            <h3>Periodo: ${periodo.toString()}</h3>

            <table border="1">
                <g:each in="${cuentas}" var="cuenta" status="i">
                    <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                        <td class="numero">
                            ${cuenta.numero}
                        </td>
                        <td class="nombre">
                            ${cuenta.descripcion}
                        </td>
                        <td class="valor">
                            ${cratos.SaldoMensual.findAllByCuentaAndPeriodo(cuenta, periodo)[0]?.saldoInicial}
                        </td>
                    </tr>
                    <g:each in="${cratos.Auxiliar}" var="asiento" status="j">
                        <g:set var="k" value="${i + j + 1}"/>

                        <tr class="${k % 2 == 0 ? 'even2' : 'odd2'}">
                            <td class="numero">
                            </td>
                            <td class="nombre">
                                ${asiento.comprobante}
                            </td>
                            <td>
                                ${asiento.debe} ${asiento.haber}
                            </td>
                        </tr>

                    </g:each>
                </g:each>
            </table>
        </div>
    </body>
</html>