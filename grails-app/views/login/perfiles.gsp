<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 2/13/12
  Time: 4:31 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="cratos.seguridad.Sesn" contentType="text/html;charset=UTF-8" %>
<html>
    <head>

        <meta name="layout" content="nomenu">

        <title>Perfiles del Usuario</title>
    </head>

    <body>

        %{--<div class=" container info showgrid">--}%
        <div class="span-12 prepend-6 append-6 " style="margin-top: 150px">
            <g:form action="savePer">
                <fieldset>

                    <div class="perfiles span-4 prepend-3 append-3" style='margin-left: 25px'><span class="ss_sprite ss_group_add">&nbsp;</span>

                        <g:select name="perfiles" from="${perfilesUsr}" optionKey="id"></g:select>

                    </div>


                    <div class="span-4 prepend-3 append-3 " style='margin-left: 50px; margin-top: 20px'>

                        <div class="buttons" align="center" style="width: 100px">
                            <span class="formButton">
                                <input type="submit" value="Ingresar"/>

                            </span>

                        </div>
                    </div>
                </fieldset>

            </g:form>
        %{--</div>--}%
        </div>
    </body>

</html>