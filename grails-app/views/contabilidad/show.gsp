
<%@ page import="cratos.Contabilidad" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'contabilidad.label', default: 'Contabilidad')}"/>
        <title>Ver Contabilidad</title>
    </head>

    <body>
        <a href="#show-contabilidad" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-contabilidad" class="content scaffold-show" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear Contabilidad</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Ver Contabilidad</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div class="container">
                    
                    <g:if test="${contabilidadInstance?.fechaCierre}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Fecha Cierre
                            </div>

                            <div class="span-19">
                                
                                <g:formatDate date="${contabilidadInstance?.fechaCierre}" format="dd-MM-yyyy"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${contabilidadInstance?.fechaInicio}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Fecha Inicio
                            </div>

                            <div class="span-19">
                                
                                <g:formatDate date="${contabilidadInstance?.fechaInicio}" format="dd-MM-yyyy"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${contabilidadInstance?.prefijo}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Prefijo
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${contabilidadInstance}" field="prefijo"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${contabilidadInstance?.descripcion}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Descripción
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${contabilidadInstance}" field="descripcion"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${contabilidadInstance?.institucion}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Institución
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="empresa" action="show" id="${contabilidadInstance?.institucion?.id}">${contabilidadInstance?.institucion?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${contabilidadInstance?.presupuesto}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Presupuesto
                            </div>

                            <div class="span-19">
                                
                                <g:formatDate date="${contabilidadInstance?.presupuesto}" format="dd-MM-yyyy"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                </div>
            </div>

            <div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
                <g:link class="delete linkButton">Eliminar</g:link>
                <g:link class="edit linkButton" action="edit" id="${contabilidadInstance?.id}">Editar</g:link>
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
                                    location.href = "${createLink(action: 'delete', id: contabilidadInstance?.id)}";
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
