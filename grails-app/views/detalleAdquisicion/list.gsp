
<%@ page import="cratos.DetalleAdquisicion" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'detalleAdquisicion.label', default: 'DetalleAdquisicion')}"/>
        <title>Lista de DetalleAdquisicion</title>
    </head>

    <body>
        <a href="#list-detalleAdquisicion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-detalleAdquisicion" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create">Crear DetalleAdquisicion</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de DetalleAdquisicion</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            
                            <g:sortableColumn property="subtotal" title="Subtotal"/>
                            
                            <g:sortableColumn property="iva" title="Iva"/>
                            
                            <g:sortableColumn property="precioUnitario" title="Precio Unitario"/>
                            
                            <g:sortableColumn property="cantidad" title="Cantidad"/>
                            
                            <th>Adquisiciones</th>
                            
                            <th>Item</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${detalleAdquisicionInstanceList}" status="i" var="detalleAdquisicionInstance">
                            <tr>
                                
                                <td><g:link action="show" id="${detalleAdquisicionInstance.id}">${fieldValue(bean: detalleAdquisicionInstance, field: "subtotal")}</g:link></td>
                                
                                <td>${fieldValue(bean: detalleAdquisicionInstance, field: "iva")}</td>
                                
                                <td>${fieldValue(bean: detalleAdquisicionInstance, field: "precioUnitario")}</td>
                                
                                <td>${fieldValue(bean: detalleAdquisicionInstance, field: "cantidad")}</td>
                                
                                <td>${fieldValue(bean: detalleAdquisicionInstance, field: "adquisiciones")}</td>
                                
                                <td>${fieldValue(bean: detalleAdquisicionInstance, field: "item")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${detalleAdquisicionInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
