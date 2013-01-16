
<%@ page import="cratos.seguridad.Prfl" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'prfl.label', default: 'Prfl')}"/>
        <title>Lista de Prfl</title>
    </head>

    <body>
        <a href="#list-prfl" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-prfl" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear Prfl</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Prfl</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            
                            <g:sortableColumn property="descripcion" title="Descripcion"/>
                            
                            <g:sortableColumn property="nombre" title="Nombre"/>
                            
                            <g:sortableColumn property="observaciones" title="Observaciones"/>
                            
                            <th>Padre</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${prflInstanceList}" status="i" var="prflInstance">
                            <tr>
                                
                                <td><g:link action="show" id="${prflInstance.id}">${fieldValue(bean: prflInstance, field: "descripcion")}</g:link></td>
                                
                                <td>${fieldValue(bean: prflInstance, field: "nombre")}</td>
                                
                                <td>${fieldValue(bean: prflInstance, field: "observaciones")}</td>
                                
                                <td>${fieldValue(bean: prflInstance, field: "padre")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${prflInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
