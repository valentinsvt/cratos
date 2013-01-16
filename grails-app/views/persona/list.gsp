
<%@ page import="cratos.Persona" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}"/>
        <title>Lista de Persona</title>
    </head>

    <body>
        <a href="#list-persona" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-persona" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear Persona</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Persona</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            
                            <g:sortableColumn property="email" title="Email"/>
                            
                            <g:sortableColumn property="telefono" title="Telefono"/>
                            
                            <g:sortableColumn property="direccionReferencia" title="Direccion Referencia"/>
                            
                            <g:sortableColumn property="barrio" title="Barrio"/>
                            
                            <g:sortableColumn property="direccion" title="Direccion"/>
                            
                            <g:sortableColumn property="fechaNacimiento" title="Fecha Nacimiento"/>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${personaInstanceList}" status="i" var="personaInstance">
                            <tr>
                                
                                <td><g:link action="show" id="${personaInstance.id}">${fieldValue(bean: personaInstance, field: "email")}</g:link></td>
                                
                                <td>${fieldValue(bean: personaInstance, field: "telefono")}</td>
                                
                                <td>${fieldValue(bean: personaInstance, field: "direccionReferencia")}</td>
                                
                                <td>${fieldValue(bean: personaInstance, field: "barrio")}</td>
                                
                                <td>${fieldValue(bean: personaInstance, field: "direccion")}</td>
                                
                                <td><g:formatDate date="${personaInstance.fechaNacimiento}"/></td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${personaInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
