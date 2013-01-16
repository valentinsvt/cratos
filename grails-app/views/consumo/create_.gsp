<%@ page import="cratos.Consumo" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'consumo.label', default: 'Consumo')}"/>
        <title>Crear Consumo</title>
    </head>

    <body>
        <a href="#create-consumo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="create-consumo" class="content scaffold-create" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                </ul>
            </div>

            <div id="divErrores" class="ui-helper-hidden ui-state-error ui-corner-all">
                <div id="listaErrores"></div>
            </div>

            <g:form name="form-consumo" action="save">
                <div class="contenedor">
                    <fieldset style="margin: 10px;">
                        <legend>Cliente</legend>

                        <div class="span-20">
                            <div class="span-3">Cédula/RUC:</div>

                            <div class="span-6">
                                <input type="text" id="ci" class="span-6 ui-widget-content ui-corner-all"/>
                            </div>

                            <div class="span-1">
                                <a href="#" id="btnBuscar">Buscar</a>
                            </div>
                        </div>

                        <div class="span-20">
                            <div class="span-3">
                                Nombre:
                            </div>

                            <div class="span-16">
                                <input type="text" id="nombre" class="span-16 ui-widget-content ui-corner-all" value="${factura.persona}"/>
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
                                <input type="text" id="direccion" class="span-6 ui-widget-content ui-corner-all"/>
                            </div>

                            <div class="span-3 prepend-1">
                                Teléfono:
                            </div>

                            <div class="span-6">
                                <input type="text" id="telefono" class="span-6 ui-widget-content ui-corner-all"/>
                            </div>
                        </div>
                    </fieldset>
                    <fieldset style="margin: 10px;">
                        <legend>Productos</legend>

                        <table class="bg">
                            <tr>
                                <td class="label">
                                    Item
                                </td>
                                <td class="label">
                                    Código
                                </td>
                                <td class="label">
                                    Precio unitario
                                </td>
                                <td class="label">
                                    Cantidad
                                </td>
                                <td class="label" width="100">
                                    Descuento
                                </td>
                                <td class="label">
                                    Precio total
                                </td>
                                <td class="label">
                                    Observaciones
                                </td>
                                <td></td>
                            </tr>

                            <tr>
                                <td id="tdItem">
                                    <input type="text" class="ui-widget-content ui-corner-all" id="txtItem" style="width: 170px;"/>
                                </td>
                                <td id="tdCodigo">

                                </td>
                                <td id="tdPrecioU">
                                    <input type="number" class="ui-widget-content ui-corner-all updatable" id="txtPrecio" style="width: 75px; text-align:right;"/>
                                </td>
                                <td id="tdCantidad">
                                    <input type="number" class="ui-widget-content ui-corner-all updatable" id="txtCantidad" style="width: 75px; text-align:right;"/>
                                </td>
                                <td id="tdDescuento">
                                    <input type="number" min="0" max="100" id="txtDescuento" class="ui-widget-content ui-corner-all updatable" value="0" style="width: 36px; text-align:right;"/>%
                                </td>
                                <td id="tdPrecioT">

                                </td>
                                <td id="tdObservaciones">
                                    <textarea id="txaObservaciones" class="ui-widget-content ui-corner-all updatable" rows="10" cols="10" style="width: 150px; height: 19px;"></textarea>
                                </td>
                                <td>
                                    <a href="#" id="btnAdd">Agregar</a>
                                </td>
                            </tr>
                        </table>
                        <br/>
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
                                    <th width="70">
                                        Acciones
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tbItems">

                            </tbody>
                        </table>

                        <br/>

                        <table border="1" style="border-collapse: collapse;">
                            <tr>
                                <th>Subtotal</th>
                                <td id="tdSubtotalFin" style="text-align: right;">0.00</td>
                            </tr>
                        </table>
                    </fieldset>
                </div>

                <div class="ui-widget-header buttons botones">
                    %{--<g:actionSubmit class="save" action="save" value="Guardar">Guardar</g:actionSubmit>--}%
                    <a href="#" class="btnSave">Guardar</a>
                </div>
            </g:form>
        </div>

        <div id="dlgBuscar" title="Buscar item">
            <div style="height: 40px;">
                <input type="text" id="txtBuscar" class="span-6 ui-widget-content ui-corner-all"/>
                <span class="span-1">
                    <a href="#" id="btnItem">Buscar</a>
                </span>
            </div>

            <div id="area" style="width: 500px; max-height: 500px; overflow-y: auto; overflow-x: hidden;">

            </div>
        </div>

        <script type="text/javascript">
            function buscarCedula() {
                var ci = $("#ci").val();
                if (ci.length >= 10) {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller: 'proveedor', action: 'buscarCedula')}",
                        data    : {
                            ci : ci
                        },
                        success : function (msg) {
                            var parts = msg.split("&");
                            if (parts[0] == "OK") {
                                var nombre = parts[1];
                                var apellido = parts[2];
                                var direccion = parts[3];
                                var telefono = parts[4];

                                $("#nombre").val(nombre + " " + apellido);
                                $("#apellido").val(apellido);
                                $("#direccion").val(direccion);
                                $("#telefono").val(telefono);
                            } else {
                                $("#divErrores").show();
                                $("#listaErrores").html("<ul><li>" + parts[1] + "</li></ul>");
                            }
                        }
                    });
                }
            }

            function search() {
                var search = $("#txtBuscar").val();

                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: 'item', action: 'buscarItem')}",
                    data    : {
                        search : search
                    },
                    success : function (msg) {
                        $("#area").html(msg);
                    }
                });
            }

            function reset() {
                $("#txtItem").val("");
                $("#txtDescuento").val(0);
                $("#txtCantidad").val(1);
                $("#txtPrecio").val(0);
                $("#txaObservaciones").val("");
                $("#tdCodigo").text("");
                $("#tdPrecioT").text("");

                $("#tdItem").removeData("item");

            }

            function addItem() {
                if (validar()) {
                    var item = $("#tdItem").data("item");
//                    console.log("2",item);
                    var tr = $("<tr>");
                    tr.data("item", item);

                    var tdCantidad = $("<td>" + number_format(item.cantidad, 2, ".", "") + "</td>").css({textAlign : "right"});
                    var tdCodigo = $("<td>" + item.codigo + "</td>");
                    var tdItem = $("<td>" + item.nombre + "</td>");
                    var tdPrecioU = $("<td>" + number_format(item.precio, 2, ".", "") + "</td>").css({textAlign : "right"});
                    var tdDescuento = $("<td>" + number_format(item.descuento, 2, ".", "") + "%</td>").css({textAlign : "right"});
                    var tdSubtotal = $("<td>" + number_format(item.total, 2, ".", "") + "</td>").css({textAlign : "right"});
                    var tdObservaciones = $("<td>" + item.observaciones + "</td>");

                    var tdAcciones = $("<td>");
                    var btnEdit = $("<a href='#'>Editar</a>");
                    var btnDelete = $("<a href='#'>Eliminar</a>");

                    btnEdit.button({
                        text  : false,
                        icons : {
                            primary : "ui-icon-pencil"
                        }
                    }).css({
                                width  : 15,
                                height : 15
                            }).click(function () {

                                $(".selected").removeClass("selected");
                                tr.addClass("selected");

                                $("#tdItem").data("item", item);
                                $("#txtItem").val(item.nombre);
                                $("#tdCodigo").text(item.codigo);
                                $("#txtPrecio").val(number_format(item.precio, 2, ".", ""));
                                $("#txtCantidad").val(item.cantidad);
                                $("#txtDescuento").val(item.descuento);
                                $("#tdPrecioT").text(number_format(item.total, 2, ".", "")).css({textAlign : "right"});
                                $("#txaObservaciones").val(item.observaciones);
                            });
                    btnDelete.button({
                        text  : false,
                        icons : {
                            primary : "ui-icon-trash"
                        }
                    }).css({
                                width      : 15,
                                height     : 15,
                                marginLeft : 20
                            }).click(function () {
                                if (confirm("Esta seguro que desea eliminar el item?")) {
                                    tr.remove();
                                }
                                calcularTotales();
                            });

                    tdAcciones.append(btnEdit);
                    tdAcciones.append(btnDelete);

                    tr.append(tdCantidad);
                    tr.append(tdCodigo);
                    tr.append(tdItem);
                    tr.append(tdPrecioU);
                    tr.append(tdDescuento);
                    tr.append(tdSubtotal);
                    tr.append(tdObservaciones);
                    tr.append(tdAcciones);

                    var trOrig, band = false;


//                    $("#tbItems").find("tr").each(function () {
//                        var i = $(this).data("item");
//                        var iid = i.id;
//                        if (iid == item.id) {
//                            trOrig = $(this);
//                            band = true;
//                        }
//                    });

//                    if (!band) {
                    $("#tbItems").prepend(tr);
//                    } else {
//                        trOrig.replaceWith(tr);
//                    }

                    reset();
                    calcularTotales();
                }
            }

            function calcularTotales() {
                var pctIva = parseFloat("${iva}") / 100;


                var subtotal = 0;
                var descuentos = 0;
                var iva12 = 0;
                var iva0 = 0;
                var iva = 0;
                var total = 0;

                $("#tbItems").find("tr").each(function () {
                    var item = $(this).data("item");

                    subtotal += (item.precio * item.cantidad);
                    descuentos += ((item.precio * item.cantidad) * (item.descuento / 100));


                    if (item.conIva == 1) {
                        iva12 += item.total;
                    } else {
                        iva0 += item.total;
                    }
                });

                iva = iva12 * pctIva;
                total = subtotal - descuentos + iva;


                $("#tdSubtotalFin").text(number_format(subtotal, 2, ".", "")).data("val", subtotal);
                $("#tdDescuentosFin").text(number_format(descuentos, 2, ".", "")).data("val", descuentos);
                $("#tdIva12Fin").text(number_format(iva12, 2, ".", "")).data("val", iva12);
                $("#tdIva0Fin").text(number_format(iva0, 2, ".", "")).data("val", iva0);
                $("#tdIvaFin").text(number_format(iva, 2, ".", "")).data("val", iva);
                $("#tdTotalFin").text(number_format(total, 2, ".", "")).data("val", total);
            }

            function validarNumeros() {
                var precio = $("#txtPrecio").val();
                var cantidad = $("#txtCantidad").val();
                var descuento = $("#txtDescuento").val();

                if (trim(precio) == "") {
                    precio = 0;
                    $("#txtPrecio").val(0);
                } else {
                    if (isNaN(precio)) {
                        precio = 0;
                        $("#txtPrecio").val(0);
                    } else {
                        precio = parseFloat(precio);
                    }
                }
                if (trim(cantidad) == "") {
                    cantidad = 1;
                    $("#txtCantidad").val(1);
                } else {
                    if (isNaN(cantidad)) {
                        cantidad = 1;
                        $("#txtCantidad").val(1);
                    } else {
                        cantidad = parseFloat(cantidad);
                    }
                }
                if (trim(descuento) == "") {
                    descuento = 0;
                    $("#txtDescuento").val(0);
                } else {
                    if (isNaN(descuento)) {
                        descuento = 0;
                        $("#txtDescuento").val(0);
                    } else {
                        descuento = parseFloat(descuento);
                    }
                }
                if (descuento > 100) {
                    descuento = 100;
                } else if (descuento < 0) {
                    descuento = 0;
                }

                var obj = {
                    precio    : precio,
                    cantidad  : cantidad,
                    descuento : descuento

                };
                return obj;
            }

            function validar() {
                if (trim($("#txtItem").val()) != "") {
                    var obj = validarNumeros();
                    var item = $("#tdItem").data("item");
                    var observaciones = $("#txaObservaciones").val();

                    item.cantidad = obj.cantidad;
                    item.precio = obj.precio;
                    item.descuento = obj.descuento;
                    item.observaciones = observaciones;
//                    console.log(item.conIva);
//                    item.conIva = obj.conIva;
//                    console.log(item.conIva);

                    var stotal = item.cantidad * item.precio;
                    var desc = stotal * (item.descuento / 100);
                    var total = stotal - desc;

                    item.total = total;

                    $("#tdItem").data("item", item);
                    $("#tdPrecioT").text(number_format(total, 2, ".", "")).css({textAlign : "right"});

                    if (item.precio == 0) {
                        $.box({
                            iconClose  : false,
                            imageClass : "box_warning",
                            title      : "Alerta",
                            text       : "El precio unitario del item es 0.",
                            dialog     : {
                                resizable : false,
                                buttons   : {
                                    "Aceptar" : function () {
                                    }
                                }
                            }
                        });
                    } else {
                        if (total == 0) {
                            $.box({
                                iconClose  : false,
                                imageClass : "box_warning",
                                title      : "Alerta",
                                text       : "El precio total del item es 0.",
                                dialog     : {
                                    resizable : false,
                                    buttons   : {
                                        "Aceptar" : function () {
                                        }
                                    }
                                }
                            });
                        }
                    }
                    return true;
                } else {
                    $.box({
                        iconClose  : false,
                        imageClass : "box_error",
                        title      : "Error",
                        text       : "Por favor seleccione un item",
                        dialog     : {
                            resizable : false,
                            buttons   : {
                                "Aceptar" : function () {
                                }
                            }
                        }
                    });
                    return false;
                }
            }

            $(function () {

                $(".field").qtip();

                $("#form-consumo").validate({
                    errorClass : "invalid"
                });

                $("input").val("");
                $("select").attr("selectedIndex", 0);
                reset();

                $("#btnAdd").button({
                    icons : {
                        primary : "ui-icon-plusthick"
                    },
                    text  : false
                }).click(function () {
                            addItem();
                        });

                $(".btnSave").button({
                    icons : {
                        primary : "ui-icon-check"
                    }
                }).click(function () {

                            $(".error").removeClass("error");

                            var ci = trim($("#ci").val());
                            var nombre = trim($("#nombre").val());
                            var apellido = trim($("#apellido").val());
                            var direccion = trim($("#direccion").val());
                            var telefono = trim($("#telefono").val());

                            var items = "";
                            var msgError = "";

                            $("#tbItems").find("tr").each(function () {
                                var item = $(this).data("item");

                                item.cantidad;
                                item.precio;
                                item.descuento;
                                item.observaciones;

                                var stotal = item.cantidad * item.precio;
                                var desc = stotal * (item.descuento / 100);
                                var total = stotal - desc;

                                item.total;

                                items += "&item=" + item.id + "^" + item.cantidad + "^" + item.precio + "^" + item.descuento + "^" + item.conIva + "^" + item.observaciones
                            });

                            if (ci == "") {
                                $("#ci").addClass("error");
                                msgError += "<li>Por favor ingrese un número de cédula o RUC</li>"
                            }
                            if (nombre == "") {
                                $("#nombre").addClass("error");
                                msgError += "<li>Por favor ingrese un nombre</li>"
                            }
                            if (apellido == "") {
                                $("#apellido").addClass("error");
                                msgError += "<li>Por favor ingrese un apellido</li>"
                            }
                            if (direccion == "") {
                                $("#direccion").addClass("error");
                                msgError += "<li>Por favor ingrese una dirección</li>"
                            }
                            if (telefono == "") {
                                $("#telefono").addClass("error");
                                msgError += "<li>Por favor ingrese un número de teléfono</li>"
                            }
                            if (items == "") {
                                msgError += "<li>Por favor seleccione al menos un item</li>"
                            }

                            if (msgError != "") {
                                $("#divErrores").show();
                                $("#listaErrores").html("<ul>" + msgError + "</ul>");
                            } else {
                                $("#divErrores").hide();

                                var data = "ci=" + ci + "&nombre=" + nombre + "&apellido=" + apellido + "&direccion=" + direccion + "&telefono=" + telefono;
                                data += "&tipoFactura=" + $("#tipoFactura").val() + "&tipoPago=" + $("#tipoPago").val() + "&tipoTarjeta=" + $("#tipoTarjeta").val();
                                data += "&subtotal=" + $("#tdSubtotalFin").data("val");
                                data += "&descuentos=" + $("#tdDescuentosFin").data("val");
                                data += "&iva1=" + $("#tdIva12Fin").data("val");
                                data += "&iva0=" + $("#tdIva0Fin").data("val");
                                data += "&total=" + $("#tdTotalFin").data("val");
                                data += "&factua=${factura.id}";
                                data += items;

                            %{--var url = "${createLink(action: 'facturar')}";--}%

                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink (action: 'save') }",
                                    data    : data,
                                    success : function (msg) {
                                        console.log(msg);
                                    }
                                });
                            }

                        });

                $("#btnBuscar").button({
                    text  : false,
                    icons : {
                        primary : "ui-icon-search"
                    }
                }).click(function () {
                            buscarCedula();
                            return false;
                        });

                $("#btnItem").button({
                    text  : false,
                    icons : {
                        primary : "ui-icon-search"
                    }
                }).click(function () {
                            search();
                            return false;
                        });

                $("#ci").keypress(function (e) {
                    if (e.keyCode == 13) {
                        buscarCedula();
                    }
                });
                $("#txtBuscar").keypress(function (e) {
                    if (e.keyCode == 13) {
                        search();
                    }
                });

                $("#tipoPago").change(function () {
                    if ($(this).val() == 1) {
                        $(".tarjeta").show();
                    } else {
                        $(".tarjeta").hide();
                    }
                });

                $("#txtItem").focus(function () {
                    $(".selected").removeClass("selected");
                    search();
                    $("#dlgBuscar").dialog("open");
                    return false;
                });


                $(".updatable").blur(function () {
                    validar();
                });


                $("#dlgBuscar").dialog({
                    autoOpen : false,
                    width    : 525,
                    height   : 600,
                    modal    : true
                });

            });
        </script>

    </body>
</html>
