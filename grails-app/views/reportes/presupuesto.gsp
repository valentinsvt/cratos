<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Plan de cuentas</title>
    <style type="text/css">
    .even {background:#B7C4F7;}
    .odd  {background:#FCFDFF}
    </style>

</head>
<body>
%{--<th>--}%
%{--<div style="width:  600px" align="center" ></div>--}%
%{--</th>--}%
<th>
    <div style="width: 650px" align="center">PRESUPUESTO</div>
</th>
<table>
    <thead>

    <th style="width: 200px" align="center">
        Numero
    </th>
    <th style="width: 300px" align="center">
        Partida
    </th>
    <th style="width:50px" align="center">
        Nivel
    </th>
    <th style="width: 400px" align="center">
        Asignación
    </th>

    </thead>
    <tbody>
    <g:each in="${asignaciones}" var="asignacion" status="i" >
        <tr class="${i%2 == 0 ? 'even': 'odd'}">
            <td>
                %{--${presupuesto.codigo}--}%
                ${asignacion.presupuesto.codigo}
            </td>
            <td>
                %{--${presupuesto.descripcion}--}%
                ${asignacion.presupuesto.descripcion}
            </td>
            <td align="center">
                %{--${presupuesto.nivel.id}--}%
                ${asignacion.presupuesto.nivel.id}
            </td>
            <td align="center">

             ${asignacion.asignacion}
            </td>

        </tr>

    </g:each>




    </tbody>
</table>

</body>
</html>