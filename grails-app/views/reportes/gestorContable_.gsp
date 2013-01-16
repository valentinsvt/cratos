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
    .even {
        background: #B7C4F7;
    }

    .odd {
        background: #FCFDFF
    }
    </style>

</head>

<body>
<th>
    <div style="width: 650px" align="center">GESTOR CONTABLE</div>
</th>
<table>
    <thead>

    <tr>
        <th style="width: 200px" align="center">
            Nombre
        </th>

        <th style="width: 300px" align="center">
            Fecha
        </th>
    </tr>
    <tr>
        <th style="width:100px" align="center">
            Descripción
        </th>
    </tr>
    <tr>
        <th style="width: 50px" align="center">
            Número
        </th>
        <th style="width: 100px" align="center">
            Descripcion
        </th>
        <th style="width: 50px" align="center">
            Porcentaje
        </th>
        <th style="width: 50px" align="center">
            Impuestos
        </th>
        <th style="width: 50px" align="center">
            Valor
        </th>
        <th style="width: 50px" align="center">
            D/H
        </th>

    </tr>
    </thead>
    <tbody>

    <g:each in="${genera}" var="generas">

        <tr>
            <td>
                ${generas.gestor.nombre}
            </td>
            <td>
                ${generas.gestor.fecha}
            </td>
        </tr>

        <td align="center">
            ${generas.gestor.descripcion}
        </td>

        <tr>

            <td>
                ${generas.cuenta.numero}

            </td>
            <td>
                ${generas.cuenta.descripcion}

            </td>
            <td style="width: 200px" align="center">
                ${generas.porcentaje}
            </td>

            <td style="width: 200px" align="center">
                ${generas.porcentajeImpuestos}

            </td>

            <td>
                ${generas.valor}
            </td>
            <td>
                ${generas.debeHaber}
            </td>
        </tr>

    </g:each>

    %{--<g:each in="${genera}" var="generas">--}%

    %{--<tr>--}%

    %{--<td align="center">--}%
    %{--${generas.porcentaje}--}%
    %{--</td>--}%
    %{--</tr>--}%


    %{--</g:each>--}%
    %{----}%

    </tbody>
</table>

</body>
</html>