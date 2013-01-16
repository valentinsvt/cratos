<%@ page import="cratos.Proveedor" %>
<!doctype html>
<html>
    <head>







        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'proveedor.label', default: 'Proveedor')}"/>
        <title>Crear Proveedor</title>
    </head>

    <body>
        <a href="#create-proveedor" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="create-proveedor" class="content scaffold-create" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                </ul>
            </div>
            <g:form name="form-proveedor" action="save" >

                <div class="contenedor" style="width: 950px; height: 800px">
               <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all" id="divErrores">
                     <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                     <strong>Se encontraron los siguientes errores:</strong>

                     <div id="listaErrores"></div>
                 </div>



             <div class="contenedor" style="height: 400px">
                %{--<h1>Crear Proveedor</h1>--}%

                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>
                <g:hasErrors bean="${proveedorInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${proveedorInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:render template="form"/>
            </div>

            <div class="ui-widget-header buttons botones">
                %{--<g:actionSubmit class="save" action="save" value="Guardar"/>--}%
                <a href="#" class="btnGuardar">Guardar</a>
            </div>
            </g:form>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".field").qtip();

                $("#unidad-form").validate({
                    errorClass: "invalid"
                });
            });

            $(".btnGuardar").button({
                icons:{
                    primary:"ui-icon-check"
                }
            }).click(function () {

                        $(".error").removeClass("error");

                        var nombre = trim($("#nombre").val());
                        var ruc = trim($("#ruc").val());
                        var tipoProveedor = $("#tipoProveedor").val();
                        var tipoPersona = $("#tipoPersona").val();
                        %{--var empresa = ${session.empresa.id};--}%
                        var canton = $("#canton").val();
                        var direccion = $("#direccion").val();
                        var nombreContacto = trim($("#nombreContacto").val());
                        var apellidoContacto = trim($("#apellidoContacto").val());
                        var autorizacionSRI = trim($("#autorizacionSRI").val());
                        var descuento = $("#descuento").val();
                        var observaciones = $("#observaciones").val();

                        var fecha = $("#fecha").val();
                        var tipoIdentificacion = $("#tipoIdentificacion").val();

                        var msgError = "";

                           if ( nombre == '') {
                            $("#nombre").addClass("error");
                            msgError += "<li>Por favor ingrese un nombre</li>"
                        }

                        if (ruc == "") {
                            $("#ruc").addClass("error");
                            msgError += "<li>Por favor ingrese el RUC</li>"
                        }
//                        if (empresa == "null") {
//                            $("#empresa").addClass("error");
//                            msgError += "<li>Por favor ingrese una Empresa</li>"
//                        }
                        if (tipoPersona == "null") {
                            $("#tipoPersona").addClass("error");
                            msgError += "<li>Por favor ingrese el Tipo de Persona</li>"
                        }
                        if (tipoIdentificacion == "null") {
                            $("#tipoIdenticacion").addClass("error");
                            msgError += "<li>Por favor ingrese un Tipo de Identificación</li>"
                        }
                        if(nombreContacto == ""){
                            
                            $("#nombreContacto").addClass("error");
                            msgError += "<li>Ingrese un nombre de contacto</li>"
                        }

                        if(apellidoContacto == ""){
                            $("#apellidoContacto").addClass("error");
                            msgError += "<li>Ingrese un apellido de contacto</li>"

                        }


                        console.log(msgError)

                        if (msgError != "") {

                            $("#divErrores").show();
                            $("#listaErrores").html("<ul>" + msgError + "</ul>");
                        } else {
                            $("#divErrores").hide();

                            var data = "&nombre=" + nombre + "&direccion=" + direccion +  "&autorizacionSRI=" + autorizacionSRI + "&descuento=" + descuento ;
                            data += "&ruc=" + ruc;
                            data += "&tipoPersona.id=" + tipoPersona;
                            data += "&tipoProveedor.id=" + tipoProveedor;
                            data += "&empresa.id=" + ${session.empresa.id};
                            data += "&tipoIdentificacion.id=" + tipoIdentificacion;
                            data += "&canton.id=" + canton;
                            data += "&fecha=" + fecha;
                            data += "&observaciones=" + observaciones;
                            data += "&nombreContacto=" + nombreContacto;
                            data += "&apellidoContacto=" + apellidoContacto;

                         $.ajax({
                                type:"POST",
                                url:"${createLink(action: 'save')}",
                                data:data,
                                success:function (msg) {
                                    console.log(msg);
                                }
                            });
                        }

                    });






        </script>

    </body>
</html>
