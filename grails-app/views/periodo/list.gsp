
<%@ page import="cratos.Periodo" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'periodo.label', default: 'Periodo')}"/>
        <title>Lista de Periodo</title>
    </head>

    <body>
        <a href="#list-periodo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-periodo" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear Periodo</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Periodo</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            
                            <g:sortableColumn property="fechaFin" title="Fecha Fin"/>
                            
                            <g:sortableColumn property="fechaInicio" title="Fecha Inicio"/>
                            
                            <g:sortableColumn property="numero" title="Numero"/>
                            
                            <th>Contabilidad</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${periodoInstanceList}" status="i" var="periodoInstance">
                            <tr>
                                
                                <td><g:link action="show" id="${periodoInstance.id}">${fieldValue(bean: periodoInstance, field: "fechaFin")}</g:link></td>
                                
                                <td><g:formatDate date="${periodoInstance.fechaInicio}"/></td>
                                
                                <td>${fieldValue(bean: periodoInstance, field: "numero")}</td>
                                
                                <td>${fieldValue(bean: periodoInstance, field: "contabilidad")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${periodoInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
