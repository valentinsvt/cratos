
<%@ page import="cratos.seguridad.Usro" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'usro.label', default: 'Usro')}"/>
        <title>Ver Usro</title>
    </head>

    <body>
        <a href="#show-usro" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-usro" class="content scaffold-show" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear Usro</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Ver Usro</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div class="container">
                    
                    <g:if test="${usroInstance?.persona}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Persona
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="persona" action="show" id="${usroInstance?.persona?.id}">${usroInstance?.persona?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${usroInstance?.login}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Login
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${usroInstance}" field="login"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${usroInstance?.password}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Password
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${usroInstance}" field="password"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${usroInstance?.autorizacion}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Autorizacion
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${usroInstance}" field="autorizacion"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${usroInstance?.sigla}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Sigla
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${usroInstance}" field="sigla"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${usroInstance?.activo}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Activo
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${usroInstance}" field="activo"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${usroInstance?.fechaPass}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Fecha Pass
                            </div>

                            <div class="span-19">
                                
                                <g:formatDate date="${usroInstance?.fechaPass}" format="dd-MM-yyyy"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${usroInstance?.observaciones}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Observaciones
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${usroInstance}" field="observaciones"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${usroInstance?.accesos}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Accesos
                            </div>

                            <div class="span-19">
                                
                                <g:each in="${usroInstance.accesos}" var="a">
                                    <g:link controller="accs" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link>
                                </g:each>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${usroInstance?.alertas}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Alertas
                            </div>

                            <div class="span-19">
                                
                                <g:each in="${usroInstance.alertas}" var="a">
                                    <g:link controller="alerta" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link>
                                </g:each>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${usroInstance?.sesiones}">
                        <div class="span-24">
                            <div class="span-3 prepend-1">
                                Sesiones
                            </div>

                            <div class="span-19">
                                
                                <g:each in="${usroInstance.sesiones}" var="s">
                                    <g:link controller="sesn" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link>
                                </g:each>
                                
                            </div>
                        </div>
                    </g:if>
                    
                </div>
            </div>

            <div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
                <g:link class="delete linkButton">Eliminar</g:link>
                <g:link class="edit linkButton" action="edit" id="${usroInstance?.id}">Editar</g:link>
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
                                    location.href = "${createLink(action: 'delete', id: usroInstance?.id)}";
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
