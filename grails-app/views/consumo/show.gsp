<%@ page import="cratos.Consumo" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'consumo.label', default: 'Consumo')}"/>
        <title>Ver Consumo</title>
    </head>

    <body>
        <a href="#create-consumo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="create-consumo" class="content scaffold-create" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="edit linkButton" action="create" id="${factura.id}">Editar</g:link></li>
                </ul>
            </div>

            <div id="divErrores" class="ui-helper-hidden ui-state-error ui-corner-all">
                <div id="listaErrores"></div>
            </div>

            <g:form name="form-consumo" action="save">
                <div class="contenedor">

                    <h1>Ver Consumo</h1>
                    <fieldset style="margin: 10px;">
                        <legend>Cliente</legend>

                        <div class="span-20">
                            <div class="span-3">Cédula/RUC:</div>

                            <div class="span-6">
                                ${factura.proveedor?.ruc}
                            </div>
                        </div>

                        <div class="span-20">
                            <div class="span-3">
                                Nombre:
                            </div>

                            <div class="span-16">
                                ${factura.persona}
                            </div>

                            %{--<div class="span-3 prepend-1">--}%
                            %{--Apellido:--}%
                            %{--</div>--}%

                            %{--<div class="span-6">--}%
                            %{--<input type="text" id="apellido" class="span-6 ui-widget-content ui-corner-all" />--}%
                            %{--</div>--}%
                        </div>

                        <div class="span-20">
                            <div class="span-3">
                                Dirección:
                            </div>

                            <div class="span-6">
                                ${factura.direccion}
                            </div>

                            <div class="span-3 prepend-1">
                                Teléfono:
                            </div>

                            <div class="span-6">
                                ${factura.telefono}
                            </div>
                        </div>
                    </fieldset>

                    <fieldset style="margin: 10px;">
                        <legend>Productos</legend>


                        <table id="tblItems" border="1" style="border-collapse: collapse;">
                            <thead>
                                <tr>
                                    <th width="50">
                                        Cantidad
                                    </th>
                                    <th width="100">
                                        Código
                                    </th>
                                    <th width="300">
                                        Item
                                    </th>
                                    <th width="100">
                                        Precio Unitario
                                    </th>
                                    <th width="80">
                                        Descuento
                                    </th>
                                    <th width="80">
                                        Subtotal
                                    </th>
                                    <th width="200">
                                        Observaciones
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tbItems">

                            </tbody>
                        </table>
                    </fieldset>
                </div>

                <div class="ui-widget-header buttons botones">
                    %{--<g:actionSubmit class="save" action="save" value="Guardar">Guardar</g:actionSubmit>--}%
                    %{--<a href="#" class="btnSave">Guardar</a>--}%
                </div>
            </g:form>
        </div>

        <script type="text/javascript">

            function updateItems() {
//                tbItems
                var ci = trim($("#ci").val());
                var nombre = trim($("#nombre").val());
                var apellido = trim($("#apellido").val());
                var direccion = trim($("#direccion").val());
                var telefono = trim($("#telefono").val());
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action: 'saveItem')}",
                    data    : {
                        add       : "false",
                        factura   : "${factura.id}",
                        update    : false
                    },
                    success : function (msg) {
                        $("#tbItems").html(msg);
                    }
                });
            }

            $(function () {
                updateItems();
            });
        </script>

    </body>
</html>
