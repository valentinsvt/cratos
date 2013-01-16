<%@ page import="cratos.TipoTarjeta; cratos.TipoPago; cratos.TipoFactura" %>
<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 1/31/12
  Time: 12:51 PM
  To change this template use File | Settings | File Templates.
--%>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title>Facturaci&oacute;n</title>

        <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
        <link type="text/css" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"
              rel="stylesheet"/>

        <style type="text/css">
        tr:nth-child(2n+1), tr:nth-child(2n) {
            background : none;
        }

        table {
            border : none;
            width  : auto;
        }

        .bg td {
            background : #eee;
        }

        .hover {
            background : #ffd125 !important;
            cursor     : pointer;
        }

        .label {
            font-weight : bold;
        }

        .selected {
            border     : #FF8010 solid 2px !important;
            background : #F7E7D9 !important;
        }

        .tarjeta {
            display : none;
        }

        ul {
            list-style   : disc;
            padding-left : 40px;
        }

        .error {
            border     : solid 2px #cc0000;
            background : #ccaaaa;
        }
        </style>

    </head>

    <body>

        <g:set var="detalles" value="${cratos.DetalleFactura.findAllByFactura(facturaInstance)}"/>
        <g:set var="tipo" value="factura"/>
        <g:if test="${detalles.size() == 0}">
            <g:set var="detalles" value="${cratos.Consumo.findAllByFactura(facturaInstance)}"/>
            <g:set var="tipo" value="consumo"/>
        </g:if>

        <div id="create-facturas" class="content scaffold-create noshowgrid" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista facturas</g:link></li>
                    <g:if test="${tipo == 'consumo'}">
                        <li><g:link class="list linkButton" controller="consumo" action="list">Lista consumos</g:link></li>
                    </g:if>
                %{--<g:if test="${facturaInstance}">--}%
                %{--<li> <g:link class="list linkButton" controller="reportes" action="retencion" id="${facturaInstance.numero}" params="${[id:facturaInstance.numero,empr:facturaInstance?.empresa?.id]}" target="_blank">Retención</g:link></li>--}%
                %{--</g:if>--}%
                </ul>
            </div>


            <div class="contenedor">
                <g:if test="${tipo == 'factura'}">
                    <h1>Ver Factura</h1>
                </g:if>
                <g:else>
                    <h1>Ver Consumo</h1>
                </g:else>

                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all" id="divErrores">
                    <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                    <strong>Se encontraron los siguientes errores:</strong>

                    <div id="listaErrores"></div>
                </div>

                <g:if test="${tipo == 'factura'}">
                    <fieldset style="margin: 10px;">
                        <legend>Factura</legend>


                        <div class="span-22">
                            <div class="span-3 label">
                                Gestor:
                            </div>

                            <div class="span-5 campo">
                                ${facturaInstance.gestor?.descripcion}
                            </div>

                            <div class="span-3 label">
                                Número factura:
                            </div>

                            <div class="span-5 campo">
                                ${facturaInstance.facturaSerie01+" "+facturaInstance.facturaSerie02+" "+facturaInstance.secuencial }
                            </div>
                        </div>

                        <div class="span-22">
                            <div class="span-3 label">
                                Fecha:
                            </div>

                            <div class="span-5 campo">
                                ${facturaInstance.fecha.format("dd-MM-yyyy")}
                            </div>

                            <div class="span-3 label">
                                Tipo de factura:
                            </div>

                            <div class="span-3 campo">
                                ${facturaInstance.tipoFactura?.descripcion}
                            </div>
                        </div>

                        <div class="span-22">
                            <div class="span-3 label">
                                Forma de pago:
                            </div>

                            <div class="span-5 campo">
                                ${facturaInstance.tipoPago?.descripcion}
                            </div>

                            <g:if test="${facturaInstance.tipoTarjeta}">
                                <div class="span-3 label">
                                    Tipo de tarjeta:
                                </div>

                                <div class="span-3 campo">
                                    ${facturaInstance.tipoTarjeta?.descripcion}
                                </div>
                            </g:if>
                        </div>
                    </fieldset>
                </g:if>

                <fieldset style="margin: 10px;">
                    <legend>Cliente</legend>

                    <div class="span-20">
                        <div class="span-3 label">Cédula/RUC:</div>

                        <div class="span-6">
                            ${facturaInstance.proveedor?.ruc}
                        </div>
                    </div>

                    <div class="span-20">
                        <div class="span-3 label">
                            Nombre:
                        </div>

                        <div class="span-16">
                            ${facturaInstance.persona}
                        </div>
                    </div>

                    <div class="span-20">
                        <div class="span-3 label">
                            Dirección:
                        </div>

                        <div class="span-6">
                            ${facturaInstance.proveedor?.direccion}
                        </div>

                        <div class="span-3 prepend-1 label">
                            Teléfono:
                        </div>

                        <div class="span-6">
                            ${facturaInstance.proveedor?.telefono}
                        </div>
                    </div>

                    <div class="span-20">
                        <div class="span-3 label">
                            Paciente:
                        </div>

                        <div class="span-16">
                            ${facturaInstance.paciente}
                        </div>
                    </div>

                </fieldset>

                <fieldset style="margin: 10px;">
                    <legend>Productos</legend>

                    <table id="tblItems" border="1" style="border-collapse: collapse;">
                        <thead>
                            <tr>
                                <th width="50" class="cantidad">
                                    Cantidad
                                </th>
                                <th width="100">
                                    Código
                                </th>
                                <th width="300">
                                    Item
                                </th>
                                <th width="100" class="precioUnitario">
                                    Precio Unitario
                                </th>
                                <th width="80" class="descuento">
                                    Descuento
                                </th>
                                <th width="80" class="subtotal">
                                    Subtotal
                                </th>
                                <th width="200">
                                    Observaciones
                                </th>
                            </tr>
                        </thead>
                        <tbody id="tbItems">
                            <g:each in="${detalles}" var="item">
                                <tr>
                                    <td>${item.cantidad}</td>
                                    <td>${item.item.codigo}</td>
                                    <td>${item.item.nombre}</td>
                                    <td><g:formatNumber number="${item.precioUnitario}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                    <td><g:formatNumber number="${item.descuento}" minFractionDigits="2" maxFractionDigits="2"/></td>
                                    <td>
                                        <g:set var="total" value="${(item.cantidad * item.precioUnitario) - (item.cantidad * item.precioUnitario * (item.descuento / 100))}"/>
                                        <g:formatNumber number="${total}" minFractionDigits="2" maxFractionDigits="2"/>
                                    </td>
                                    <td>${item.observaciones}</td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>

                    <br/>

                    <g:if test="${tipo == 'factura'}">
                        <table border="1" style="border-collapse: collapse;">
                            <tr>
                                <th>Subtotal</th>
                                <td id="tdSubtotalFin" style="text-align: right;"><g:formatNumber number="${facturaInstance.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></td>
                            </tr>
                            <tr>
                                <th>Descuentos</th>
                                <td id="tdDescuentosFin" style="text-align: right;"><g:formatNumber number="${facturaInstance.descuentos}" minFractionDigits="2" maxFractionDigits="2"/></td>
                            </tr>
                            <tr>
                                <th>Tarifa IVA ${iva}%</th>
                                <td id="tdIva12Fin" style="text-align: right;"><g:formatNumber number="${facturaInstance.iva1}" minFractionDigits="2" maxFractionDigits="2"/></td>
                            </tr>
                            <tr>
                                <th>Tarifa IVA 0%</th>
                                <td id="tdIva0Fin" style="text-align: right;"><g:formatNumber number="${facturaInstance.iva0}" minFractionDigits="2" maxFractionDigits="2"/></td>
                            </tr>
                            <tr>
                                <th>IVA (${iva}%)</th>
                                <td id="tdIvaFin" style="text-align: right;"><g:formatNumber number="${facturaInstance.iva}" minFractionDigits="2" maxFractionDigits="2"/></td>
                            </tr>
                            <tr>
                                <th>TOTAL</th>
                                <td id="tdTotalFin" style="text-align: right;"><g:formatNumber number="${facturaInstance.pagado}" minFractionDigits="2" maxFractionDigits="2"/></td>
                            </tr>
                        </table>
                    </g:if>

                </fieldset>
            </div>

            <div class="ui-widget-header buttons botones">
                %{--<g:actionSubmit class="save" action="save" value="Generar Factura"/>--}%
                <g:if test="${tipo == 'consumo'}">
                    <g:link controller="consumo" action="create" class="btnFactura" id="${facturaInstance.id}">Editar</g:link>
                    <g:link action="generar" class="btnFactura" id="${facturaInstance.id}">Generar factura</g:link>
                </g:if>
            </div>
        </div>
        <script type="text/javascript">
            function buscarCedula() {
                var ci = $("#ci").val();
                if (ci.length >= 10) {
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action: 'buscarCedula')}",
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

                                $("#nombre").val(nombre);
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
                    url     : "${createLink(action: 'buscarItem')}",
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
                                item.edit = true;
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
                    var cont = item.cantidad;

                    var descuento = item.descuento;
                    var total = item.total;
                    var obs = item.observaciones;

                    $("#tbItems").find("tr").each(function () {
                        var i = $(this).data("item");
                        var iid = i.id;

                        if (iid == item.id) {
                            trOrig = $(this);
                            band = true;
                            if (!item.edit) {
                                cont += i.cantidad;
                                descuento = i.descuento;
                                obs += ' ' + i.observaciones;
                            }

                        }
                    });

                    if (!band) {
                        $("#tbItems").prepend(tr);
                    } else {
                        if (!item.edit) {
                            total = (item.precio * cont) - ((item.precio * cont) * (descuento / 100));

                            item.cantidad = cont;
                            item.descuento = descuento;
                            item.observaciones = obs;

//                tr.css({background:'orange'});
                            tdCantidad.text(number_format(cont, 2, ".", ""));
                            tdDescuento.text(number_format(descuento, 2, ".", ""));
                            tdObservaciones.text(obs);

                            item.total = total;
                            tdSubtotal.text(number_format(total, 2, ".", ""));
                        }

                        item.edit = false;

                        trOrig.replaceWith(tr);
                    }

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
                    item.conIva = obj.conIva;

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

                $(".btnFactura").button({
                    icons : {
                        primary : "ui-icon-pencil"
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
                    if ($(this).val() == 4) {
                        $("#tipoTarjeta").show();
                        $("#tipoTarjetaLabel").show();
                    } else {
                        $("#tipoTarjeta").hide();
                        $("#tipoTarjetaLabel").hide();
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