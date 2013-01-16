<%@ page import="cratos.Consumo" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'consumo.label', default: 'Consumo')}"/>
        <title>Lista de Consumos</title>
    </head>

    <body>
        <a href="#list-consumo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-consumo" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear Consumo</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Consumos</h1>
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
                            <th>Cantidad de items en el consumo</th>
                            <th>Factura generada</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${facturas}" status="i" var="factura">
                            <tr>
                                <td>
                                    <g:link controller="factura" action="show" id="${factura.id}">
                                        ${i + 1}
                                    </g:link>
                                </td>
                                <td>
                                    ${factura?.proveedor?.nombreContacto} ${factura?.proveedor?.apellidoContacto}
                                </td>
                                <td>
                                    <g:formatDate date="${factura?.fecha}" format="dd-MM-yyyy"/>
                                </td>
                                <td>${cratos.Consumo.findAllByFactura(factura).size()}</td>
                                <td>
                                    <g:set var="detallesFactura" value="${cratos.DetalleFactura.findAllByFactura(factura).size()}"/>
                                    ${detallesFactura > 0 ? "SI" : "NO"}
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${facturasTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
