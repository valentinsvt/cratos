<%@ page import="cratos.Item" %>
<!doctype html>
<html>
    <head>

        <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
        <link type="text/css" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"
              rel="stylesheet"/>


        <style type="text/css">

        .hover {
            background: #ffd125 !important;
            cursor: pointer;
        }

        .selected {
            border: #FF8010 solid 2px !important;
            background: #F7E7D9 !important;
        }


        </style>


        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'item.label', default: 'Item')}"/>

        <title>Ingresar Item</title>
    </head>

    <body>
        <a href="#create-item" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="create-item" class="content scaffold-create" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                </ul>
            </div>
            <g:form name="form-item" action="save" >




            <div class="contenedor" style="height: 400px">


                <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all" id="divErrores">
                    <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                    <strong>Se encontraron los siguientes errores:</strong>

                    <div id="listaErrores"></div>
                </div>


                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>
                <g:hasErrors bean="${itemInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${itemInstance}" var="error">
                            <li> <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if><g:message error="${error}"/></li>
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

//            $(function(){
//
//                $(".btnEstado").button({
//                    icons : {
//                        primary: "ui-icon-circle-plus"
//                    }
//                }).click(function(){
//
//                            $(".error").removeClass("error");
//            });
//            });

            $(function(){

                $(".btnGuardar").button({
                    icons : {
                        primary: "ui-icon-check"
                    }
                    }).click(function(){

                        $(".error").removeClass("error");

                        var fecha = $("#fecha").val();
                        var nombre = trim($("#nombre").val());
                        var marca = $("#marca").val();
                        var codigo=trim($("#codigo").val());
                        var iva = $("#iva").val();
                        var unidad = $("#unidad").val();
                        var stockMaximo = $("#stockMaximo").val();
                        var precioUnitario = $("#precioUnitario").val();
                        var precioCosto = $("#precioCosto").val();
                        var precioVenta = $("#precioVenta").val();
                        var peso = $("#peso").val();
                        var stock = $("#stock").val();
                        var estado = $("#estado").val();
                        var observaciones = $("#observaciones").val();
//                        var grupo = 1;

                        var msgError = "";

                    if(nombre == ""){

                        $("#nombre").addClass("error");
                            msgError += "<li>Ingrese un nombre </li>"
                    }
                    if(codigo == ""){
                        $("#codigo").addClass("error");
                           msgError += "<li>Ingrese un codigo</li>"
                    }
                    if(stockMaximo == 0){
                       $("#stockMaximo").addClass("error");
                        msgError += "<li>Ingrese un stock máximo</li>"
                    }
                    if(precioUnitario == 0){
                       $("#precioUnitario").addClass("error");
                        msgError += "<li>Ingrese el precio unitario</li>"
                    }
                    if(iva == 0){
                        $("#iva").addClass("error");
                        msgError += "<li>Ingrese el iva</li>"
                    }
                    if(precioCosto == 0){
                       $("#precioCosto").addClass("error");
                        msgError += "<li>Ingrese el precio de costo</li>"
                    }
                    if(precioVenta == 0){
                        $("#precioVenta").addClass("error");
                         msgError +="<li>Ingrese el precio de venta</li>"
                    }
                    if(peso == 0){
                       $("#peso").addClass("error");
                        msgError += "<li>Ingrese el peso</li>"
                    }
                    if(stock == 0){
                        $("#stock").addClass("error");
                        msgError += "<li>Ingrese el stock</li>"
                    }
                    if (msgError != "") {

                        console.log(msgError);


                        $("#divErrores").show();
                        $("#listaErrores").html("<ul>" + msgError + "</ul>");
                    } else {
                        $("#divErrores").hide();

                      var data = "&fecha=" + fecha + "&nombre=" + nombre + "&marca.id=" + marca + "&codigo=" + codigo + "&unidad.id=" + unidad;
                        data += "&stockMaximo=" + stockMaximo;
                        data += "&precioCosto=" + precioCosto;
                        data += "&precioVenta=" + precioVenta;
                        data += "&precioUnitario="  + precioUnitario;
                        data += "&estado=" + estado;


                        data += "&observaciones=" + observaciones;

                    $.ajax({
                         type : "POST",
                         url: "${createLink (action: 'save')}",
                         data: data,
                         success: function (msq){
                         }

                    });

                    }

                });




            });

        </script>

    </body>
</html>
