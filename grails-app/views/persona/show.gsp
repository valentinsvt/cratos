
<%@ page import="cratos.Persona" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}"/>
        <title>Ver Persona</title>

        <style type="text/css">

         .margen-top {

             margin-top: 10px;

         }

         .texto{

             font-weight: bolder;
         }




        </style>


    </head>


    <body>
        <a href="#show-persona" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-persona" class="content scaffold-show" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear Persona</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Ver Persona</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div class="container">

                <g:if test="${personaInstance?.cedula}">
                    <div class="span-24 margen-top">
                        <div class="span-3 prepend-1 texto">
                            Cédula
                        </div>

                        <div class="span-19">

                            <g:fieldValue bean="${personaInstance}" field="cedula"/>

                        </div>
                    </div>
                </g:if>

                <g:if test="${personaInstance?.nombre}">
                    <div class="span-24 margen-top">
                        <div class="span-3 prepend-1 texto">
                            Nombre
                        </div>

                        <div class="span-19">

                            <g:fieldValue bean="${personaInstance}" field="nombre"/>

                        </div>
                    </div>
                </g:if>
                <g:if test="${personaInstance?.apellido}">
                    <div class="span-24 margen-top">
                        <div class="span-3 prepend-1 texto">
                            Apellido
                        </div>

                        <div class="span-19">

                            <g:fieldValue bean="${personaInstance}" field="apellido"/>

                        </div>
                    </div>
                </g:if>

                <g:if test="${personaInstance?.direccion}">
                    <div class="span-24 margen-top">
                        <div class="span-3 prepend-1 texto">
                            Dirección
                        </div>

                        <div class="span-19">

                            <g:fieldValue bean="${personaInstance}" field="direccion"/>

                        </div>
                    </div>
                </g:if>


                <g:if test="${personaInstance?.telefono}">
                    <div class="span-24 margen-top">
                        <div class="span-3 prepend-1 texto">
                            Teléfono
                        </div>

                        <div class="span-19">

                            <g:fieldValue bean="${personaInstance}" field="telefono"/>

                        </div>
                    </div>
                </g:if>



                <g:if test="${personaInstance?.email}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Email
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${personaInstance}" field="email"/>
                                
                            </div>
                        </div>
                    </g:if>
                    

                    <g:if test="${personaInstance?.direccionReferencia}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Dirección Referencia
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${personaInstance}" field="direccionReferencia"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${personaInstance?.barrio}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Barrio
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${personaInstance}" field="barrio"/>
                                
                            </div>
                        </div>
                    </g:if>
                    

                    <g:if test="${personaInstance?.fechaNacimiento}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Fecha de Nacimiento
                            </div>

                            <div class="span-19">
                                
                                <g:formatDate date="${personaInstance?.fechaNacimiento}" format="dd-MM-yyyy"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${personaInstance?.discapacitado}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Discapacitado
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${personaInstance}" field="discapacitado"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${personaInstance?.sexo}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Sexo
                            </div>

                            <div class="span-19">

                                <g:if test="${personaInstance?.sexo == 'M'}">

                                    ${'Masculino'}

                                </g:if>
                                <g:elseif test="${personaInstance?.sexo == 'F'}">

                                    ${"Femenino"}

                                </g:elseif>


                                
                                %{--<g:fieldValue bean="${personaInstance}" field="sexo"/>--}%
                                
                            </div>
                        </div>
                    </g:if>
                    

                    
                    <g:if test="${personaInstance?.empresa}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Empresa
                            </div>

                            <div class="span-19">
                                
                                %{--<g:link controller="empresa" action="show" id="${personaInstance?.empresa?.id}">${personaInstance?.empresa?.encodeAsHTML()}</g:link>--}%

                                ${personaInstance?.empresa?.nombre.encodeAsHTML()}
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${personaInstance?.nacionalidad}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Nacionalidad
                            </div>

                            <div class="span-19">
                                
                                %{--<g:link controller="nacionalidad" action="show" id="${personaInstance?.nacionalidad?.id}">${personaInstance?.nacionalidad?.encodeAsHTML()}</g:link>--}%

                                ${personaInstance?.nacionalidad?.encodeAsHTML()}
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${personaInstance?.profesion}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Profesión
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="profesion" action="show" id="${personaInstance?.profesion?.id}">${personaInstance?.profesion?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${personaInstance?.estadoCivil}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Estado Civil
                            </div>

                            <div class="span-19">
                                
                                <g:link controller="estadoCivil" action="show" id="${personaInstance?.estadoCivil?.id}">${personaInstance?.estadoCivil?.encodeAsHTML()}</g:link>
                                
                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${personaInstance?.observaciones}">
                        <div class="span-24 margen-top">
                            <div class="span-3 prepend-1 texto">
                                Observaciones
                            </div>

                            <div class="span-19">
                                
                                <g:fieldValue bean="${personaInstance}" field="observaciones"/>
                                
                            </div>
                        </div>
                    </g:if>
                    
                </div>
            </div>

            <div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
                <g:link class="delete linkButton">Eliminar</g:link>
                <g:link class="edit linkButton" action="edit" id="${personaInstance?.id}">Editar</g:link>
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
                                    location.href = "${createLink(action: 'delete', id: personaInstance?.id)}";
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
