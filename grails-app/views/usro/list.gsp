
<%@ page import="cratos.seguridad.Usro" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'usro.label', default: 'Usro')}"/>
        <title>Lista de Usro</title>
    </head>

    <body>
        <a href="#list-usro" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-usro" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear Usro</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Usro</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            
                            <th>Persona</th>
                            
                            <g:sortableColumn property="login" title="Login"/>
                            
                            <g:sortableColumn property="password" title="Password"/>
                            
                            <g:sortableColumn property="autorizacion" title="Autorizacion"/>
                            
                            <g:sortableColumn property="sigla" title="Sigla"/>
                            
                            <g:sortableColumn property="activo" title="Activo"/>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${usroInstanceList}" status="i" var="usroInstance">
                            <tr>
                                
                                <td><g:link action="show" id="${usroInstance.id}">${fieldValue(bean: usroInstance, field: "persona")}</g:link></td>
                                
                                <td>${fieldValue(bean: usroInstance, field: "login")}</td>
                                
                                <td>${fieldValue(bean: usroInstance, field: "password")}</td>
                                
                                <td>${fieldValue(bean: usroInstance, field: "autorizacion")}</td>
                                
                                <td>${fieldValue(bean: usroInstance, field: "sigla")}</td>
                                
                                <td>${fieldValue(bean: usroInstance, field: "activo")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${usroInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
