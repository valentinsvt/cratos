<%@ page import="cratos.Empresa" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}"/>
        <title>Crear Empresa</title>
    </head>

    <body>
        <a href="#create-empresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="create-empresa" class="content scaffold-create" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                </ul>
            </div>
            <g:form name="form-empresa" action="save" >
            <div class="contenedor" style="height: 450px">


                <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all" id="divErrores">
                    <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                    <strong>Se encontraron los siguientes errores:</strong>

                    <div id="listaErrores"></div>
                </div>

                %{--<h1>Crear Empresa</h1>--}%

                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>
                <g:hasErrors bean="${empresaInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${empresaInstance}" var="error">
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

         //validación

         $(function () {

             $(".btnGuardar").button({
                 icons:{
                     primary:"ui-icon-check"
                 }
             }).click(function () {

                         $(".error").removeClass("error");

                         var nombre = trim($("#nombre").val());
                         var ruc = trim($("#ruc").val());
                         var tipoEmpresa = $("#tipoEmpresa").val();

                         var canton = $("#canton").val();


                         var email = ($("#email").val());
                         var direccion = ($("#direccion").val());
                         var sigla = ($("#sigla").val());
                         var telefono = ($("#telefono").val());

                          var fechaFin = $("#fechaFin").val();

                         var fechaInicio = $("#fechaInicio").val();


                         var msgError = ""



                         if (nombre == "" ) {
                             $("#nombre").addClass("error");
                             msgError += "<li>Por favor ingrese el Nombre de la empresa</li>"
                         }
                         if (ruc == "") {
                             $("#ruc").addClass("error");
                             msgError += "<li>Por favor ingrese el Ruc</li>"
                         }
                         if (tipoEmpresa == "null") {
                             $("#tipoEmpresa").addClass("error");
                             msgError += "<li>Por favor ingrese el tipo de Empresa</li>"
                         }
                         if (canton == "null") {
                             $("#canton").addClass("error");
                             msgError += "<li>Por favor ingrese un Cantón</li>"
                         }


                         console.log(msgError)


                         if (msgError != "") {

                             $("#divErrores").show();
                             $("#listaErrores").html("<ul>" + msgError + "</ul>");
                         } else {
                             $("#divErrores").hide();

                             var data = "&nombre=" + nombre + "&ruc=" + ruc + "&direccion=" + direccion +
                                     "&email=" + email + "&telefono=" + telefono + "&sigla=" + sigla + "&fechaFin=" + fechaFin + "&fechaInicio=" + fechaInicio;

                              data += "&canton.id=" + canton;
                              data += "&tipoEmpresa.id=" + tipoEmpresa;

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




            });


        </script>

    </body>
</html>
