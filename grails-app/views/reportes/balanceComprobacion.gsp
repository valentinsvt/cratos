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
                <th>Saldo inicial</th>
                <th>Debe</th>
                <th>Haber</th>
                <th>Deudor</th>
                <th>Acreedor</th>
            </tr>
            </thead>
            <tbody>
            <g:set var="totDebe" value="${0}"></g:set>
            <g:set var="totHaber" value="${0}"></g:set>
            <g:set var="totDeudor" value="${0}"></g:set>
            <g:set var="totAcreedor" value="${0}"></g:set>
            <g:each in="${res}" var="m" status="i">
                <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                    <td>${m.cuenta.numero}</td>
                    <td>${m.cuenta.descripcion}</td>
                    <td style="text-align:right;"><g:formatNumber number="${m.saldoInicial}" maxFractionDigits="2" minFractionDigits="2" type="number"/></td>
                    <td style="text-align:right;">
                        <g:formatNumber number="${m.debe}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                        <g:if test="${m.cuenta.nivel.id==1}">
                            <g:set var="totDebe" value="${totDebe+m.debe}"></g:set>
                        </g:if>
                    </td>
                    <td style="text-align:right;">
                        <g:formatNumber number="${m.haber}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                        <g:if test="${m.cuenta.nivel.id==1}">
                            <g:set var="totHaber" value="${totHaber+m.haber}"></g:set>
                        </g:if>
                    </td>
                    <g:set var="total" value="${m.saldoInicial+m.debe-m.haber}"></g:set>
                    <td style="text-align:right;">
                        <g:if test="${total >= 0}">
                            <g:formatNumber number="${total}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                            <g:if test="${m.cuenta.nivel.id==1}">
                                <g:set var="totDeudor" value="${totDeudor+total}"></g:set>
                            </g:if>
                        </g:if>
                        <g:else>
                            <g:formatNumber number="0" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                            <g:if test="${m.cuenta.nivel.id==1}">
                                <g:set var="totAcreedor" value="${totAcreedor+total}"></g:set>
                            </g:if>
                        </g:else>
                    </td>
                    <td style="text-align:right;">
                        <g:if test="${total < 0}">
                            <g:formatNumber number="${total * -1}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                        </g:if>
                        <g:else>
                            <g:formatNumber number="0" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                        </g:else>
                    </td>
                </tr>
            </g:each>
            <tr>
                <td colspan="3" style="text-align: left;font-weight: bold">TOTAL</td>
                <td style="text-align: right;font-weight: bold"><g:formatNumber number="${totDebe}" maxFractionDigits="2" minFractionDigits="2" type="number"/></td>
                <td style="text-align: right;font-weight: bold"><g:formatNumber number="${totHaber}" maxFractionDigits="2" minFractionDigits="2" type="number"/></td>
                <td style="text-align: right;font-weight: bold"><g:formatNumber number="${totDeudor}" maxFractionDigits="2" minFractionDigits="2" type="number"/></td>
                <td style="text-align: right;font-weight: bold"><g:formatNumber number="${totAcreedor}" maxFractionDigits="2" minFractionDigits="2" type="number"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>