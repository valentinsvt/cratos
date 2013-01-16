
<%@ page import="cratos.Canton" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'canton.label', default: 'Canton')}"/>
        <title>Ver Canton</title>
    </head>

    <body>
        <a href="#show-canton" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-canton" class="content scaffold-show" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear Canton</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Ver Canton</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div class="container">
                    
                    <g:if test="${cantonInstance?.nombre}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Nombre
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${cantonInstance}" field="nombre"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                </div>
            </div>

            <div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
                <g:link class="delete linkButton">Eliminar</g:link>
                <g:link class="edit linkButton" action="edit" id="${cantonInstance?.id}">Editar</g:link>
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
                                    location.href = "${createLink(action: 'delete', id: cantonInstance?.id)}";
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
