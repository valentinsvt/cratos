
<%@ page import="cratos.Periodo" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'periodo.label', default: 'Periodo')}"/>
        <title>Ver Periodo</title>
    </head>

    <body>
        <a href="#show-periodo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-periodo" class="content scaffold-show" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear Periodo</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Ver Periodo</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div class="container">
                    
                    <g:if test="${periodoInstance?.fechaFin}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Fecha Fin
                            </div>

                            <div class="span-19">
                                
                                <g:formatDate date="${periodoInstance?.fechaFin}" format="dd-MM-yyyy"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${periodoInstance?.fechaInicio}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Fecha Inicio
                            </div>

                            <div class="span-19">
                                
                                <g:formatDate date="${periodoInstance?.fechaInicio}" format="dd-MM-yyyy"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${periodoInstance?.numero}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Numero
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${periodoInstance}" field="numero"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${periodoInstance?.contabilidad}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Contabilidad
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="contabilidad" action="show" id="${periodoInstance?.contabilidad?.id}">${periodoInstance?.contabilidad?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                </div>
            </div>

            <div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
                <g:link class="delete linkButton">Eliminar</g:link>
                <g:link class="edit linkButton" action="edit" id="${periodoInstance?.id}">Editar</g:link>
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
                                    location.href = "${createLink(action: 'delete', id: periodoInstance?.id)}";
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
