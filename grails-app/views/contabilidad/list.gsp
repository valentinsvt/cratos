
<%@ page import="cratos.Contabilidad" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'contabilidad.label', default: 'Contabilidad')}"/>
        <title>Lista Periodos contables</title>
    </head>

    <body>
        <a href="#list-contabilidad" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-contabilidad" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear Contabilidad</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista Periodos contables</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="descripcion" title="Descripción"/>
                            <g:sortableColumn property="fechaInicio" title="Fecha Inicio"/>
                            <g:sortableColumn property="fechaCierre" title="Fecha Cierre"/>
                            <g:sortableColumn property="prefijo" title="Prefijo"/>
                            <g:sortableColumn property="institucion" title="Institución"/>
                            <g:sortableColumn property="presupuesto" title="Presupuesto"/>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${contabilidadInstanceList}" status="i" var="contabilidadInstance">
                            <tr>
                                <td><g:link action="show" id="${contabilidadInstance.id}">${fieldValue(bean: contabilidadInstance, field: "descripcion")}</g:link></td>
                                <td><g:formatDate date="${contabilidadInstance.fechaInicio}"/></td>
                                <td>${fieldValue(bean: contabilidadInstance, field: "fechaCierre")}</td>
                                <td>${fieldValue(bean: contabilidadInstance, field: "prefijo")}</td>
                                <td>${fieldValue(bean: contabilidadInstance, field: "institucion")}</td>
                                <td><g:formatDate date="${contabilidadInstance.presupuesto}"/></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${contabilidadInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
