<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 4/11/12
  Time: 4:44 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Balance de comprobación</title>

        <style type="text/css">
        @page {
            size   : 29.7cm 21cm;  /*width height */
            margin : 2cm;
        }

        html {
            font-family : Verdana, Arial, sans-serif;
            font-size   : 15px;
        }

        .hoja {
            width      : 25cm;
            /*background : #d8f0fa;*/
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
        </style>
    </head>

    <body>
        <div class="hoja">
            <h1>Balance de comprobación</h1>

            <h2>${contabilidad.descripcion}</h2>

            <h3>${periodo.fechaInicio.format("dd-MM-yyyy")} a ${periodo.fechaFin.format("dd-MM-yyyy")}</h3>

            <div>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Número</th>
                            <th>Cuenta</th>
                            <th>Debe</th>
                            <th>Haber</th>
                            <th>Deudor</th>
                            <th>Acreedor</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${res}" var="m" status="i">
                            <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                                <td>${m.cuenta.numero}</td>
                                <td>${m.cuenta.descripcion}</td>
                                <td style="text-align:right;">
                                    <g:formatNumber number="${m.debe}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                                </td>
                                <td style="text-align:right;">
                                    <g:formatNumber number="${m.haber}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                                </td>
                                <td style="text-align:right;">
                                    <g:if test="${m.total >= 0}">
                                        <g:formatNumber number="${m.total}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                                    </g:if>
                                    <g:else>
                                        <g:formatNumber number="0" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                                    </g:else>
                                </td>
                                <td style="text-align:right;">
                                    <g:if test="${m.total < 0}">
                                        <g:formatNumber number="${m.total * -1}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                                    </g:if>
                                    <g:else>
                                        <g:formatNumber number="0" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                                    </g:else>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>