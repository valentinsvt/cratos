
<%@ page import="cratos.seguridad.Sesn" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'sesn.label', default: 'Sesn')}"/>
        <title>Ver Sesn</title>
    </head>

    <body>
        <a href="#show-sesn" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-sesn" class="content scaffold-show" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear Sesn</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Ver Sesn</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div class="container">
                    
                    <g:if test="${sesnInstance?.perfil}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Perfil
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="prfl" action="show" id="${sesnInstance?.perfil?.id}">${sesnInstance?.perfil?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${sesnInstance?.usuario}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Usuario
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="usro" action="show" id="${sesnInstance?.usuario?.id}">${sesnInstance?.usuario?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                </div>
            </div>

            <div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
                <g:link class="delete linkButton">Eliminar</g:link>
                <g:link class="edit linkButton" action="edit" id="${sesnInstance?.id}">Editar</g:link>
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
                                    location.href = "${createLink(action: 'delete', id: sesnInstance?.id)}";
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
