
<%@ page import="cratos.Persona" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}"/>
        <title>Lista de Personas</title>
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
                <h1>Lista de Personas</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            

                            <g:sortableColumn property="cedula" title="Cédula"/>

                            <g:sortableColumn property="nombre" title="Nombre"/>
                            
                            <g:sortableColumn property="telefono" title="Teléfono"/>

                            <g:sortableColumn property="direccion" title="Dirección"/>

                            <g:sortableColumn property="profesion" title="Profesión"/>

                            <g:sortableColumn property="email" title="Email"/>
                            

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${personaInstanceList}" status="i" var="personaInstance">
                            <tr>
                                

                                <td>${fieldValue(bean: personaInstance, field: 'cedula')}</td>

                                <td><g:link action="show" id="${personaInstance?.id}"> ${personaInstance?.nombre + " " + personaInstance?.apellido}</g:link> </td>
                                
                                <td>${fieldValue(bean: personaInstance, field: "telefono")}</td>

                                
                                <td>${fieldValue(bean: personaInstance, field: "direccion")}</td>

                                <td>${fieldValue(bean: personaInstance, field: 'profesion')}</td>

                                <td>${fieldValue(bean: personaInstance, field: 'email')}</td>
                                

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
