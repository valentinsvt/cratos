<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 3/22/13
  Time: 12:32 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Eliminar gestor</title>
    </head>

    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Eliminar gestor
            </div>

            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <h4 style="margin: 10px;">${msn}</h4>

            <g:link action="verGestor" class="btn" id="${gestor.id}">Regresar</g:link>
        </div>

        <script type="text/javascript">
            $(".btn").button();
        </script>
    </body>
</html>