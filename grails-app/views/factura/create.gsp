<%@ page import="cratos.Gestor; cratos.TipoTarjeta; cratos.TipoPago; cratos.TipoFactura" %>
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
            padding-top : 8px
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

        .label {
            /*background : green;*/
        }

        .campo {
            /*background : orange;*/
        }

        #listaErrores {
            margin-bottom : 0 !important;
        }
        </style>

    </head>

    <body>
        <form action="" id="frmAll">
            <div id="create-facturas" class="content scaffold-create" role="main">
                <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                    <ul style="margin-bottom:0;">
                        <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    </ul>
                </div>


                <div class="contenedor" style="height: 750px">
                    <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all" id="divErrores">
                        <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                        <span style="font-weight: solid;" id="spanError">Se encontraron los siguientes errores:</span>

                        <ul id="listaErrores"></ul>
                    </div>

                    <fieldset style="margin: 10px;">
                        <legend>Factura</legend>

                        %{--<form id="frmFactura">--}%
                        <div class="span-22">

                            <div class="span-3 label">
                                Número factura:
                            </div>

                            %{--<div class="span-5 campo">--}%
                            %{--<g:textField name="numero" class="required span-5  ui-corner-all" style="width: 100px" maxlength="15"/>--}%
                            %{--</div>--}%

                            <div class="span-5 campo">

                                <g:textField name="serie01" class="span-5 ui-corner-all required" style="width: 25px" maxlength="3" id="serie1"/>

                                <g:textField name="serie02" class="span-5 ui-corner-all required" style="width: 25px" maxlength="3" id="serie2"/>

                                <g:textField name="secuencial" class="span-6 ui-corner-all required" style="width: 65px" maxlength="11" id="secuencial"/>

                            </div>


                            <div class="span-3 label">
                                Fecha:
                            </div>

                            <div class="span-5 campo" align="left">
                                ${new Date().format("dd-MM-yyyy")}
                            </div>

                        </div>

                        <div class="span-22">
                            <div class="span-3 label">
                                Gestor:
                            </div>

                            <div class="span-5 campo">
                                <g:select name="gestor" from="${Gestor.list([sort: 'descripcion'])}" optionKey="id"
                                          optionValue="descripcion" noSelection="['': '']" class="required span-4  ui-corner-all"/>
                            </div>

                            <div class="span-3 label">
                                Tipo de factura:
                            </div>

                            <div class="span-3 campo">
                                <g:select name="tipoFactura" from="${TipoFactura.list([sort: 'descripcion'])}" optionKey="id"
                                          optionValue="descripcion" noSelection="['': '']" class="required span-3  ui-corner-all"/>
                            </div>
                        </div>

                        <div class="span-22">
                            <div class="span-3 label">
                                Forma de pago:
                            </div>

                            <div class="span-5 campo">
                                <g:select name="tipoPago" from="${TipoPago.list([sort: 'descripcion'])}" optionKey="id"
                                          optionValue="descripcion" noSelection="['': '']" class="required span-4  ui-corner-all"/>
                            </div>

                            <div class="span-3 tarjeta label" id="tipoTarjetaLabel">
                                Tipo de tarjeta:
                            </div>

                            <div class="span-3 tarjeta campo" id="tipoTarjeta">
                                <g:select name="tipoTarjeta" id="tipoTarjetaSel" from="${TipoTarjeta.list()}" optionKey="id"
                                          optionValue="descripcion"
                                          noSelection="['': '']" class="span-3  many-to-one ui-corner-all"/>
                            </div>
                        </div>
                        %{--</form>--}%
                    </fieldset>

                    <fieldset style="margin: 10px;">
                        <legend>Cliente</legend>

                        %{--<form id="frmCliente">--}%
                        <div class="span-20">
                            <div class="span-3 label">Cédula/RUC:</div>

                            <div class="span-6 campo">
                                <g:textField name="ci" class="required span-6 ui-corner-all" style="width: 80px" id="ci"/>

                            </div>

                            <div class="span-20">
                                <div class="span-3 label">
                                    Nombre:
                                </div>

                                <div class="span-6 campo">
                                    <g:textField name="nombre" class="span-6 required ui-corner-all"/>
                                </div>

                                <div class="span-3 prepend-1 label">
                                    Apellido:
                                </div>

                                <div class="span-6 campo">
                                    <g:textField name="apellido" class="span-6 required ui-corner-all"/>
                                </div>
                            </div>

                            <div class="span-20">
                                <div class="span-3 label">
                                    Dirección:
                                </div>

                                <div class="span-6 campo">
                                    <g:textField name="direccion" class="span-6 required ui-corner-all"/>
                                </div>

                                <div class="span-3 prepend-1 label">
                                    Teléfono:
                                </div>

                                <div class="span-6 campo">
                                    <g:textField name="telefono" class="span-6 required ui-corner-all"/>
                                </div>
                            </div>
                            %{--</form>--}%
                    </fieldset>

                    <fieldset style="margin: 10px;">
                        <legend>Productos</legend>

                        <div class="span-22">

                            <div class="span-3 label">
                                Bodega:
                            </div>

                            <div class="span-5 campo">

                                <g:select name="bodega" from="${bodegas}" optionKey="id" optionValue="descripcion" id="bodega"></g:select>

                            </div>

                        </div>

                        <table class="bg">
                            <tr>
                                <td class="label">
                                    Item
                                </td>
                                <td class="label">
                                    Código
                                </td>
                                <td class="label" style="display: none;">
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
                                    <input type="text" class=" ui-corner-all" id="txtItem" style="width: 250px;"/>
                                </td>
                                <td id="tdCodigo">

                                </td>
                                <td id="tdPrecioU" style="display: none">
                                    <input type="number" class=" ui-corner-all updatable" id="txtPrecio"
                                           style="width: 75px; text-align:right;"/>
                                </td>
                                <td id="tdCantidad">
                                    <input type="number" class=" ui-corner-all updatable" id="txtCantidad"
                                           style="width: 75px; text-align:right;"/>
                                </td>
                                <td id="tdDescuento">
                                    <input type="number" min="0" max="100" id="txtDescuento"
                                           class=" ui-corner-all updatable" value="0"
                                           style="width: 45px; text-align:right;" s/>%
                                </td>
                                <td id="tdPrecioT">

                                </td>
                                <td id="tdObservaciones">
                                    <textarea id="txaObservaciones" class=" ui-corner-all updatable" rows="10" cols="10"
                                              style="width: 150px;resize: none; height: 19px;"></textarea>
                                </td>
                                <td>
                                    <a href="#" id="btnAdd">Agregar</a>
                                </td>
                            </tr>
                        </table>
                        <br/>
                        <g:textField name="verifItems" class="ui-helper-hidden-accessible"/>
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
                                    <th width="70">
                                        Acciones
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tbItems" name="tbItems">

                            </tbody>
                        </table>

                        <br/>

                        <table border="1" style="border-collapse: collapse;">
                            <tr>
                                <th>Subtotal</th>
                                <td id="tdSubtotalFin" style="text-align: right;">0.00</td>
                            </tr>
                            <tr>
                                <th>Descuentos</th>
                                <td id="tdDescuentosFin" style="text-align: right;">0.00</td>
                            </tr>
                            <tr>
                                <th>Tarifa IVA ${iva}%</th>
                                <td id="tdIva12Fin" style="text-align: right;">0.00</td>
                            </tr>
                            <tr>
                                <th>Tarifa IVA 0%</th>
                                <td id="tdIva0Fin" style="text-align: right;">0.00</td>
                            </tr>
                            <tr>
                                <th>IVA (${iva}%)</th>
                                <td id="tdIvaFin" style="text-align: right;">0.00</td>
                            </tr>
                            <tr>
                                <th>TOTAL</th>
                                <td id="tdTotalFin" style="text-align: right;">0.00</td>
                            </tr>
                        </table>
                    </fieldset>
                </div>


                <div id="dlgBuscar" title="Buscar item">
                    <div style="height: 40px;">
                        <input type="text" id="txtBuscar" class="span-6  ui-corner-all"/>
                        <span class="span-1">
                            <a href="#" id="btnItem">Buscar</a>
                        </span>
                    </div>

                    <div id="area" style="width: 600px; max-height: 500px; overflow-y: auto; overflow-x: hidden;">

                    </div>

                </div>


                <div id="dlgBuscarCliente" title="Buscar Cliente">
                    <div style="height: 40px">

                        <input type="text" id="txtBuscarCli" class="span-6 ui-corner-all"/>
                        <span class="span-1">

                            <a href="#" id="btnCliente">Buscar Cliente</a>
                        </span>

                    </div>

                    <div id="area2" style="width: 630px; max-height: 500px; overflow-y: auto; overflow-x: hidden;">

                    </div>

                </div>


                <div class="ui-widget-header buttons botones">

                    <a href="#" class="btnFactura">Generar factura</a>
                </div>
            </div>
        </form>

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
                    url     : "${createLink(action: 'buscarItemBodega')}",
                    data    : {
                        search : search,
                        bodega : $("#bodega").val()
                    },
                    success : function (msg) {
                        $("#area").html(msg);
                    }
                });
            }

            function buscarCliente() {
                var search = $("#txtBuscarCli").val();

                $.ajax({

                    type : "POST",
                    url  : "${createLink(action: 'buscarCliente')}",
                    data : {

                        search : search

                    },

                    success : function (msq) {

                        $("#area2").html(msq);

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

                    if (cont > item.max) {
                        cont = item.max;
                        $.box({
                            iconClose  : false,
                            imageClass : "box_warning",
                            title      : "Alerta",
                            text       : "No puede ingresar más de " + item.max,
                            dialog     : {
                                resizable : false,
                                buttons   : {
                                    "Aceptar" : function () {
                                    }
                                }
                            }
                        });
                    }

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

                var max = $("#tdItem").data("item").max;

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
                        if (cantidad > parseFloat(max)) {
                            cantidad = max;
                            $("#txtCantidad").val(max);
                            $.box({
                                iconClose  : false,
                                imageClass : "box_warning",
                                title      : "Alerta",
                                text       : "No puede ingresar más de " + max,
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
//                    item.conIva = obj.conIva;

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

                $("#frmAll").validate({
                    errorLabelContainer : "#listaErrores",
                    wrapper             : "li",
                    invalidHandler      : function (form, validator) {
                        var errors = validator.numberOfInvalids();
                        if (errors) {
                            var message = errors == 1
                                    ? 'Se encontró 1 error:'
                                    : 'Se encontraron ' + errors + ' errores:';
                            $("#divErrores").show();
                            $("#spanError").html(message);
                        } else {
                            $("#divErrores").hide();
                        }
                    },
                    rules               : {
                        gestor      : {
                            required : true
                        },
                        serie01     : {
                            required  : true,
                            digits    : true,
                            maxlength : 3
                        },
                        serie02     : {
                            required  : true,
                            digits    : true,
                            maxlength : 3
                        },
                        secuencial  : {
                            required  : true,
                            digits    : true,
                            maxlength : 11
                        },
                        tipoFactura : {
                            required : true
                        },
                        tipoPago    : {
                            required : true
                        },
                        tipoTarjeta : {
                            required : function (element) {
                                return $("#tipoPago").val() == "4";
                            }
                        },
                        ci          : {
                            required  : true,
                            digits    : true,
                            minlength : 10,
                            maxlength : 13

                        },
                        nombre      : {
                            required  : true,
                            maxlength : 32
                        },
                        apellido    : {
                            required  : true,
                            maxlength : 32
                        },
                        direccion   : {
                            required  : true,
                            maxlength : 127
                        },
                        telefono    : {
                            required  : true,
                            maxlength : 15
                        },
                        verifItems  : {
                            minRows : ["#tbItems tr", 1]
                        }
                    },
                    messages            : {
                        gestor      : {
                            required : "Seleccione un gestor para la factura"
                        },
                        serie01     : {
                            required  : "Ingrese el número de factura",
                            maxlength : jQuery.format("El número de factura debe tener hasta {0} caracteres"),
                            digits    : "El número de la factura debe tener únicamente dígitos"
                        },
                        serie02     : {
                            required  : "Ingrese el número de factura",
                            maxlength : jQuery.format("El número de factura debe tener hasta {0} caracteres"),
                            digits    : "El número de la factura debe tener únicamente dígitos"
                        },
                        secuencial  : {
                            required  : "Ingrese el número de factura",
                            maxlength : jQuery.format("El número de factura debe tener hasta {0} caracteres"),
                            digits    : "El número de la factura debe tener únicamente dígitos"
                        },
                        tipoFactura : {
                            required : "Seleccione el tipo de factura"
                        },
                        tipoPago    : {
                            required : "Seleccione la forma de pago de la factura"
                        },
                        tipoTarjeta : {
                            required : "Ingrese el tipo de tarjeta de pago"
                        },
                        ci          : {
                            required  : "Ingrese el número de cédula o RUC del cliente",
                            digits    : "El número de cédula o RUC debe tener únicamente dígitos",
                            minlength : "Ingrese 10 o 13 dígitos para la cédula o RUC del cliente",
                            maxlength : "Ingrese 10 o 13 dígitos para la cédula o RUC del cliente"

                        },
                        nombre      : {
                            required  : "Ingrese el nombre del cliente",
                            maxlength : jQuery.format("El nombre del cliente debe tener hasta {0} caracteres")
                        },
                        apellido    : {
                            required  : "Ingrese el apellido del cliente",
                            maxlength : jQuery.format("El apellido del cliente debe tener hasta {0} caracteres")
                        },
                        direccion   : {
                            required  : "Ingrese la dirección del cliente",
                            maxlength : jQuery.format("La dirección del cliente debe tener hasta {0} caracteres")
                        },
                        telefono    : {
                            required  : "Ingrese el teléfono del cliente",
                            maxlength : jQuery.format("El teléfono del cliente debe tener hasta {0} caracteres")
                        }
                    }
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

                $(".btnFactura").button({
                    icons : {
                        primary : "ui-icon-check"
                    }
                }).click(function () {

                            if ($("#frmAll").valid()) {

                                var ci = trim($("#ci").val());
                                var nombre = trim($("#nombre").val());
                                var apellido = trim($("#apellido").val());
                                var direccion = trim($("#direccion").val());
                                var telefono = trim($("#telefono").val());

                                var tipoFactura = $("#tipoFactura").val();
                                var tipoPago = $("#tipoPago").val();
                                var tipoTarjeta = $("#tipoTarjetaSel").val();

                                var gestor = $("#gestor").val();
                                var numero = $("#numero").val();
                                var s1 = $("#serie1").val()
                                var s2 = $("#serie2").val()
                                var sec = $("#secuencial").val()

                                var fecha = "${new Date().format("yyyy-MM-dd")}"

                                var items = "";

                                $("#tbItems").find("tr").each(function () {
                                    var item = $(this).data("item");

                                    var stotal = item.cantidad * item.precio;
                                    var desc = stotal * (item.descuento / 100);
                                    var total = stotal - desc;

                                    items += "&item=" + item.id + "^" + item.cantidad + "^" + item.precio + "^" + item.descuento + "^" + item.conIva + "^" + item.observaciones + "^" + item.bodega
                                });

                                var data = "ci=" + ci + "&persona=" + nombre + " " + apellido + "&direccion=" + direccion + "&telefono=" + telefono;
                                data += "&nombre=" + nombre + "&apellido=" + apellido;
                                data += "&tipoFactura.id=" + tipoFactura + "&tipoPago.id=" + tipoPago;

                                data += "&fecha=" + fecha;

                                data += "&tipoTarjeta.id=" + tipoTarjeta;

                                data += "&gestor=" + gestor;
                                data += "&numero=" + numero;

                                data += "&subtotal=" + $("#tdSubtotalFin").data("val");
                                data += "&descuentos=" + $("#tdDescuentosFin").data("val");
                                data += "&iva1=" + $("#tdIva12Fin").data("val");
                                data += "&iva0=" + $("#tdIva0Fin").data("val");
                                data += "&iva=" + $("#tdIvaFin").data("val");
                                data += "&total=" + $("#tdTotalFin").data("val");
                                data += "&facturaSerie01=" + s1
                                data += "&facturaSerie02=" + s2
                                data += "&secuencial=" + sec
                                data += items;

                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink (action: 'save') }",
                                    data    : data,
                                    success : function (msg) {

                                        if (msg != "error")
                                            location.href = "${g.createLink(action:'show')}/" + msg
                                    }
                                });
                            }
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

                $("#btnCliente").button({
                    text  : false,
                    icons : {
                        primary : "ui-icon-search"

                    }

                }).click(function () {

                            buscarCliente();
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

                $("#ci").focus(function () {

                    $(".selected").removeClass("selected");

                    buscarCliente();
                    $("#dlgBuscarCliente").dialog("open");
                    return false;
                });

                $(".updatable").blur(function () {
                    validar();
                });

                $("#dlgBuscar").dialog({
                    autoOpen : false,
                    width    : 625,
                    height   : 600,
                    modal    : true
                });

                $("#dlgBuscarCliente").dialog({

                    autoOpen : false,
                    width    : 650,
                    height   : 600,
                    modal    : true

                });

            });
        </script>

    </body>
</html>