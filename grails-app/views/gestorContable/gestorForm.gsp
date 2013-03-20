<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>

        <title>${(gestorInstance) ? 'Editar gestor contable' : 'Nuevo gestor contable'}</title>


        <style type="text/css">
        .fila {
            width  : 800px;
            height : 40px;
        }

        .label {
            width       : 80px;
            float       : left;
            height      : 30px;
            line-height : 30px;
        }

        .campo {
            width  : 670px;
            float  : right;
            height : 30px;
        }
        </style>

    </head>

    <body>
        <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${gestorInstance}">
            <div class="errors">
                <g:renderErrors bean="${gestorInstance}" as="list"/>
            </div>
        </g:hasErrors>

        <g:form action="save" class="frmGestor" controller="gestorContable">
            <div class="container entero ui-widget-content ui-corner-all" style="min-height: 800px">
                <h1 class="titulo center  ui-corner-all" style="margin-bottom: 5px; margin-left: 10px;margin-bottom: 15px;">${(gestorInstance) ? 'Editar gestor contable' : 'Nuevo gestor contable'}</h1>

                <div style="margin-left: 20px;margin-bottom: 10px;">
                    <input type="submit" class="btn" value="Guardar" id="btnGuardar"/>
                    <g:link class="btn" action="index">Cancelar</g:link>
                </div>

                <div id="contenido" style="margin-left: 20px;">
                    <input type="hidden" name="id" value="${gestorInstance?.id}"/>

                    <div class="fila">
                        <div class="label">
                            Nombre:
                        </div>

                        <div class="campo">
                            <input name="nombre" type="text" value="${gestorInstance?.nombre}" style="width:700px;" class="ui-corner-all"/>
                        </div>
                    </div>

                    <div class="fila">
                        <div class="label">
                            Descripción:
                        </div>

                        <div class="campo">
                            <input name="descripcion" type="textArea" value="${gestorInstance?.descripcion}" style="width:700px;" class="ui-corner-all"/>
                        </div>
                    </div>

                    <div class="fila">
                        <div class="label">
                            Observaciones:
                        </div>

                        <div class="campo">
                            <input name="observaciones" type="textArea" value="${gestorInstance?.observaciones}" style="width:700px;" class="ui-corner-all"/>
                        </div>
                    </div>

                    <div class="fila">
                        <div class="label">
                            Fuente:
                        </div>

                        <div class="campo">
                            <g:select name="fuente.id" type="select" campo="fuente" from="${cratos.Fuente.list([sort: 'descripcion'])}" label="Fuente: "
                                      value="${gestorInstance?.fuente?.id}" optionKey="id" optionValue="descripcion" class="ui-corner-all"></g:select>
                        </div>
                    </div>

                    <div class="fila">
                        <div class="label">
                            Tipo:
                        </div>

                        <div class="campo">
                            <g:select name="tipoCom" type="select" campo="tipo" from="${cratos.TipoComprobante.list([sort: 'descripcion'])}" label="Tipo comprobante: " value="${tipoCom?.id}"
                                      optionKey="id" id="tipo" class="ui-corner-all" optionValue="descripcion"></g:select>
                        </div>
                    </div>


                    <div style="margin-left: 50px">
                    </div>
                </div>

                <fieldset style="width: 850px;border: 1px solid black;min-height: 450px;margin: auto;margin-top: 10px" class="ui-corner-all">
                    <legend>MOVIMIENTOS CONTABLES</legend>
                    <g:render template="busquedaCuentas"/>
                </fieldset>

            </div>
        </g:form>
        <script type="text/javascript">
            $(function () {
                $(".btn").button()
                var band = 1
                $("#buscar").click(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller: 'gestorContable',action: 'buscarCuentas')}",
                        data    : "nombre=" + $('#nombreBus').val() + "&codigo=" + $("#codigoBus").val(),
                        success : function (msg) {
                            $('#divPlanCuentas').html(" ")
                            $('#divPlanCuentas').html(msg);
                            var b = true

                        }
                    })
                });
                $("#tipo").change(function () {
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller: 'gestorContable',action: 'cambiarComprobante')}",
                        data    : "tc=" + $(this).val(),
                        success : function (msg) {
                            $("#agregarCuentas").html(msg)

                        }
                    })
                });

                $("#txtBusca").bind('keyup', function (event) {
                    var keyCode = event.which;
                    if (keyCode == 13) {
                        enviar();
                    }
                    if ($(this).val().length >= 0 && $("#error").parent().is(":visible")) {
                        $("#error").html("").parent().hide("slide");
                    }
                });

                $("#buscarGestor").click(function () {
                    enviar();
                });

                function enviar() {
                    $.ajax({
                        type    : "POST",
                        url     : "buscarGestor",
                        data    : $(".buscarGestor").serialize(),
                        success : function (msg) {
                            $("#divLista").html(msg).show("slide");
                            tablas();
                        }
                    });
                }

                $("#guardar").click(function () {
//            console.log($(".frmGestor2"))
                    $(".frmGestor").submit()
                    return false

                });

            });
        </script>
    </body>
</html>


