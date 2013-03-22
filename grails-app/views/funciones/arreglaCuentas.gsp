<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Funciones -  arreglar cuentas</title>
</head>
<body>
Cuentas arregladas:<br>
<g:each in="${arregladas}" var="a">
    ${a.numero} --> ${a.descripcion} Movimiento ${a.movimiento}<br>
</g:each>
</body>
</html>