<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 4/13/12
  Time: 12:40 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Gestor Contable</title>
    <style type="text/css">
    @page {
        size: 21cm 29.7cm ; /* width height */
        margin: 2cm;
    }

    .hoja {
        width: 25.7cm;
        /*background: #d8f0fa;*/
    }

    .even {
        background: #B7C4F7;
    }

    .odd {
        background: #FCFDFF
    }

    table {
        border-collapse: collapse;
    }

    .item {
        /*background: #e6e6fa;*/
        border-bottom: solid 2px #555;

    }
    </style>

</head>

<body>
<div class="hoja">
    <div style="width: 650px" align="center">GESTOR CONTABLE</div>

%{--<g:each in="${1..5}">--}%

    <g:each in="${res}" var="item">

        <g:set var="val" value="${item.value}"/>


    %{--<div class="item">--}%
        <table>
            <tr>
                <td width="450px" height="50px">
                    Nombre: ${item.key}
                </td>

                <td >

                    Fecha:
                    <g:formatDate format="dd/MM/yyyy"  type="datetime" date="${val.fecha}"> </g:formatDate>

                </td>

            </tr>

            <tr>
                <td height="50px">
                    Descripción: ${val.descripcion}
                </td>

            </tr>

        </table>

        <table border="1">

            <tr>
                <th style="width: 110px" align="center">
                    Número
                </th>
                <th style="width: 280px" align="center">
                    Descripción
                </th>
                <th style="width: 40px" align="center">
                    Porcentaje
                </th>
                <th style="width: 40px" align="center">
                    Impuestos
                </th>
                <th style="width: 40px" align="center">
                    Valor
                </th>
                <th style="width: 40px" align="center">
                    D/H
                </th>

            </tr>

            <g:each in="${val.items}" var="i">

                <tr>
                    <td>
                        ${i.numero}

                    </td>
                    <td>
                        ${i.descripcion}

                    </td>
                    <td>
                        ${i.porcentaje}

                    </td>
                    <td>
                        ${i.porcentajeImpuestos}

                    </td>
                    <td>
                        ${i.valor}
                    </td>
                    <td align="center">
                        ${i.debeHaber}
                    </td>

                </tr>

            </g:each>

        </table>


    </g:each>
</div>


%{--</g:each>--}%
%{--</div>--}%
</body>
</html>