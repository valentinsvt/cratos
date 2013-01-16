<%@ page import="cratos.Factura" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'factura.label', default: 'Factura')}"/>
        <title>Lista de Facturas</title>
    </head>

    <body>
        <a href="#list-factura" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-factura" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear Factura</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Facturas</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            <th width="15">#</th>
                            <g:sortableColumn property="persona" title="Persona"/>
                            <g:sortableColumn property="fecha" title="Fecha"/>
                            <th>Cantidad de productos</th>
                            <th>Consumo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${facturaInstanceList}" status="i" var="facturaInstance">
                            <tr>
                                <td>
                                    <g:link action="show" id="${facturaInstance.id}">
                                        ${i + 1}
                                    </g:link>
                                </td>
                                <td>
                                    ${facturaInstance?.proveedor?.nombreContacto} ${facturaInstance?.proveedor?.apellidoContacto}
                                </td>
                                <td>
                                    <g:formatDate date="${facturaInstance?.fecha}" format="dd-MM-yyyy hh:mm"/>
                                </td>
                                <td>${cratos.DetalleFactura.findAllByFactura(facturaInstance).size()}</td>
                                <td>${cratos.Consumo.findAllByFactura(facturaInstance).size()}</td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${facturaInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
