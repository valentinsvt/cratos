<%@ page import="cratos.Unidad" %>
<%@ page import="cratos.seguridad.Usro" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>

<head>

    <meta name="layout" content="nomenu">

    <title>Login Cratos Contabilidad</title>

</head>

<body>

<g:form action="validar">

    <div class="marco">



   <div class="span-1 append-9 prepend-9" style="margin-top: 150px">

    <fieldset style="color: #000001;">
%{--<table class="usuario" align="center" >--}%

    <tr class="prop">

        <td valign='top' style='text-align:left;' width='20%'>
            <label for='login'>Usuario:</label>
        </td>

        <td valign='top' style='text-align:left;' width='80%'>
            <input id="login" name='login' class="ui-corner-all"/>
        </td>

    </tr>
    <tr class="prop">
        <td valign='top' style='text-align:left;' width='20%'>
            <label for='password'>Password:</label>
        </td>
        <td valign='top' style='text-align:left;' width='80%'>
            <input id="password" type='password' name='password' class="ui-corner-all"/>
        </td>
    </tr>

    </fieldset>
    </div>
%{--</table>--}%


    <div class="span-4 prepend-9 append-9 " style='margin-left: 50px'>

    <div class="buttons" align="center" style="width: 100px" >
        <span class="formButton">
            <input type="submit" value="Ingresar"/>
        </span>

    </div>


        <g:if test="${flash.message}">
            <div class="message ${flash.clase}" role="status" style="margin-top: 20px; margin-left: -59px; width: 200px" align="left"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
            </div>
        </g:if>

    </div>
    <div style="height: 25px;width: 200px;position:absolute; top: 640px;right: 30px;text-align: left">
        &copy; TEDEIN S.A. Versión ${message(code: 'version', default: '1.1.0x')}
    </div>
</g:form>
<div style="height: 600px;">



</div>

</body>
</html>