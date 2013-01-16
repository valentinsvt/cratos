
<%@ page import="cratos.seguridad.Prfl" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'prfl.label', default: 'Prfl')}"/>
        <title>Ver Prfl</title>
    </head>

    <body>
        <a href="#show-prfl" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-prfl" class="content scaffold-show" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear Prfl</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Ver Prfl</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div class="container">
                    
                    <g:if test="${prflInstance?.descripcion}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Descripcion
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${prflInstance}" field="descripcion"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${prflInstance?.nombre}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Nombre
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${prflInstance}" field="nombre"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${prflInstance?.observaciones}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Observaciones
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${prflInstance}" field="observaciones"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${prflInstance?.padre}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Padre
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="prfl" action="show" id="${prflInstance?.padre?.id}">${prflInstance?.padre?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${prflInstance?.perfiles}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Perfiles
                            </div>

                            <div class="span-19">
                                
                                <g:each in="${prflInstance.perfiles}" var="p">
                                    <g:link controller="prfl" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link>
                                </g:each>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${prflInstance?.permisos}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Permisos
                            </div>

                            <div class="span-19">
                                
                                <g:each in="${prflInstance.permisos}" var="p">
                                    <g:link controller="prms" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link>
                                </g:each>
                                
                            </div>
                        </div>
                    </g:if>
                    
                </div>
            </div>

            <div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
                <g:link class="delete linkButton">Eliminar</g:link>
                <g:link class="edit linkButton" action="edit" id="${prflInstance?.id}">Editar</g:link>
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
                                    location.href = "${createLink(action: 'delete', id: prflInstance?.id)}";
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
