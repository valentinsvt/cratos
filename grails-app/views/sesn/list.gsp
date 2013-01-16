
<%@ page import="cratos.seguridad.Sesn" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'sesn.label', default: 'Sesn')}"/>
        <title>Lista de Sesn</title>
    </head>

    <body>
        <a href="#list-sesn" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-sesn" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear Sesn</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Sesn</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            
                            <th>Perfil</th>
                            
                            <th>Usuario</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${sesnInstanceList}" status="i" var="sesnInstance">
                            <tr>
                                
                                <td><g:link action="show" id="${sesnInstance.id}">${fieldValue(bean: sesnInstance, field: "perfil")}</g:link></td>
                                
                                <td>${fieldValue(bean: sesnInstance, field: "usuario")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${sesnInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
