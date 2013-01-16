
<%@ page import="cratos.Cuenta" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'cuenta.label', default: 'Cuenta')}"/>
        <title>Ver Cuenta</title>
    </head>

    <body>
        <a href="#show-cuenta" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-cuenta" class="content scaffold-show" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear Cuenta</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Ver Cuenta</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div class="container">
                    
                    <g:if test="${cuentaInstance?.auxiliar}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Auxiliar
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${cuentaInstance}" field="auxiliar"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${cuentaInstance?.movimiento}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Movimiento
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${cuentaInstance}" field="movimiento"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${cuentaInstance?.descripcion}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Descripción
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${cuentaInstance}" field="descripcion"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${cuentaInstance?.padre}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Padre
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${cuentaInstance}" field="padre"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${cuentaInstance?.numero}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Número
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${cuentaInstance}" field="numero"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${cuentaInstance?.empresa}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Empresa
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="empresa" action="show" id="${cuentaInstance?.empresa?.id}">${cuentaInstance?.empresa?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${cuentaInstance?.cuentaBanco}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Cuenta Banco
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="cuentaBanco" action="show" id="${cuentaInstance?.cuentaBanco?.id}">${cuentaInstance?.cuentaBanco?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${cuentaInstance?.nivel}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Nivel
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="nivel" action="show" id="${cuentaInstance?.nivel?.id}">${cuentaInstance?.nivel?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${cuentaInstance?.presupuesto}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Presupuesto
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="presupuesto" action="show" id="${cuentaInstance?.presupuesto?.id}">${cuentaInstance?.presupuesto?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${cuentaInstance?.estado}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Estado
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${cuentaInstance}" field="estado"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                </div>
            </div>

            <div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
                <g:link class="delete linkButton">Eliminar</g:link>
                <g:link class="edit linkButton" action="edit" id="${cuentaInstance?.id}">Editar</g:link>
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
                                    location.href = "${createLink(action: 'delete', id: cuentaInstance?.id)}";
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
