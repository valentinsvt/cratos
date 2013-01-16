
<%@ page import="cratos.DetalleAdquisicion" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'detalleAdquisicion.label', default: 'DetalleAdquisicion')}"/>
        <title>Ver DetalleAdquisicion</title>
    </head>

    <body>
        <a href="#show-detalleAdquisicion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-detalleAdquisicion" class="content scaffold-show" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear DetalleAdquisicion</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Ver DetalleAdquisicion</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div class="container">
                    
                    <g:if test="${detalleAdquisicionInstance?.subtotal}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Subtotal
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${detalleAdquisicionInstance}" field="subtotal"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${detalleAdquisicionInstance?.iva}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Iva
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${detalleAdquisicionInstance}" field="iva"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${detalleAdquisicionInstance?.precioUnitario}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Precio Unitario
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${detalleAdquisicionInstance}" field="precioUnitario"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${detalleAdquisicionInstance?.cantidad}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Cantidad
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${detalleAdquisicionInstance}" field="cantidad"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${detalleAdquisicionInstance?.adquisiciones}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Adquisiciones
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="adquisiciones" action="show" id="${detalleAdquisicionInstance?.adquisiciones?.id}">${detalleAdquisicionInstance?.adquisiciones?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${detalleAdquisicionInstance?.item}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Item
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="item" action="show" id="${detalleAdquisicionInstance?.item?.id}">${detalleAdquisicionInstance?.item?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${detalleAdquisicionInstance?.estado}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Estado
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${detalleAdquisicionInstance}" field="estado"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                </div>
            </div>

            <div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
                <g:link class="delete linkButton">Eliminar</g:link>
                <g:link class="edit linkButton" action="edit" id="${detalleAdquisicionInstance?.id}">Editar</g:link>
            </div>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".delete").click(function () {
                    $.box({
                        imageClass : "box_warning",
                        text       : "Está seguro de querer eliminar este registro?",
                        title      : "Confirmación",
                        iconClose  : false,
                        dialog     : {
                            resizable     : false,
                            draggable     : false,
                            closeOnEscape : false,
                            resizable     : false,
                            buttons       : {
                                "Aceptar"  : function () {
                                    location.href = "${createLink(action: 'delete', id: detalleAdquisicionInstance?.id)}";
                                },
                                "Cancelar" : function () {
                                    return false;
                                }
                            }
                        }
                    });
                    return false;
                });
            });
        </script>

    </body>
</html>
