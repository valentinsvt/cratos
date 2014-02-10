<%@ page import="cratos.Unidad" %>
<%@ page import="cratos.seguridad.Usro" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>

<head>

    <meta name="layout" content="nomenu">

    <title>Login Cratos Contabilidad</title>

</head>

<body>
<div class="marco" style="position: relative;height: 100%;width: 100%">
    <g:form action="validar">
        <div class="span-1 append-9 prepend-9" style="margin-top: 150px">

            <fieldset style="color: #000001;" class="ui-corner-all">
                <div style="margin-bottom: 10px">
                    <label for='login'>Usuario:</label>
                    <input id="login" name='login' class="ui-corner-all"/>
                </div>
                <label for='password'>Password:</label>
                <input id="password" type='password' name='password' class="ui-corner-all"/>

            </fieldset>
        </div>
    %{--</table>--}%


        <div class="span-4 prepend-9 append-9 " style='margin-left: 50px'>
            <div class="buttons"  style="width: 100px;text-align: center" >
                <span class="formButton">
                    <input type="submit" value="Ingresar"/>
                </span>
            </div>
            <g:if test="${flash.message}">
                <div class="message ${flash.clase}" role="status" style="margin-top: 20px; margin-left: -59px; width: 200px" align="left"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                </div>
            </g:if>
        </div>
        <div style="height: 25px;width: 200px;position:absolute; bottom: 10px;right: 10px;text-align: left;font-weight: bold">
            TEDEIN S.A. Versión ${message(code: 'version', default: '1.1.0x')}
        </div>

    </g:form>
</div>
</body>
</html>