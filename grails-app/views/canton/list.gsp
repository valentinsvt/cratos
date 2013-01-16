
<%@ page import="cratos.Canton" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'canton.label', default: 'Canton')}"/>
        <title>Lista de Canton</title>
    </head>

    <body>
        <a href="#list-canton" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-canton" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear Canton</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Canton</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            
                            <g:sortableColumn property="nombre" title="Nombre"/>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${cantonInstanceList}" status="i" var="cantonInstance">
                            <tr>
                                
                                <td><g:link action="show" id="${cantonInstance.id}">${fieldValue(bean: cantonInstance, field: "nombre")}</g:link></td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${cantonInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
