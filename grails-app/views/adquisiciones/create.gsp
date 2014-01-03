<%@ page import="cratos.Empresa; cratos.Proceso; cratos.Adquisiciones" %>
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
            background : #ffd125 !important;
            cursor     : pointer;
        }

        .selected {
            border     : #FF8010 solid 2px !important;
            background : #F7E7D9 !important;
        }

        tfoot tr {
            background : #aaa;
        }
        </style>
        <script type="text/javascript">
            var precioAnt = 0;
            var cantAnt = 0;
            function addItem() {
                if (validar(false)) {
                    var item = $("#tdItem").data("item");

                    var tr = $("<tr>");
                    tr.data("item", item);

                    var tdCantidad = $("<td>" + number_format(item.cantidad, ".", "") + "</td>").css({textAlign : "right"});
                    var tdCodigo = $("<td>" + item.codigo + "</td>");
                    var tdItem = $("<td>" + item.nombre + "</td>");
                    var tdPrecioC = $("<td>" + number_format(item.precio, 2, ".", "") + "</td>").css({textAlign : "right"});
                    var tdSubtotal = $("<td>" + number_format(item.total, 2, ".", "") + "</td>").css({textAlign : "right"});
//                    var tdBodega = $("<td>" + item.bodega.texto + "</td>");
                    var tdObservaciones = $("<td>" + item.observaciones + "</td>");

                    var tdIva = $("<td>" + number_format(item.iva, 2, ".", "") + "</td>").css({textAlign : "right"});

                    var tdIce = $("<td>" + number_format(item.ice, 2, ".", "") + "</td>").css({textAlign : "right"});
                    var tdTotal = $("<td>" + number_format(item.totalTodo, 2, ".", "") + "</td>").css({textAlign : "right"});

                    var tdAcciones = $("<td>");

//                    var btnEdit = $("<a href='#'>Editar</a>");
                    var btnDelete = $("<a href='#'>Eliminar</a>");

                    btnDelete.button({
                        text  : false,
                        icons : {
                            primary : "ui-icon-trash"
                        }
                    }).css({
                                width  : 15,
                                height : 15
                            }).click(function () {
                                $.box({
                                    imageClass : "box_pregunta",
                                    text       : "Está seguro que desea eliminar este item?",
                                    title      : "Eliminar Item",
                                    dialog     : {
                                        resizable : false,
                                        draggable : false,
                                        width     : 350,
                                        buttons   : {
                                            "Aceptar"  : function () {
                                                tr.remove();
                                                calcularTotales();
                                            },
                                            "Cancelar" : function () {
                                                calcularTotales();
                                            }
                                        }
                                    }
                                });
                            });

                    tr.append(tdCodigo);
                    tr.append(tdItem);
                    tr.append(tdCantidad);
                    tr.append(tdPrecioC);
                    tr.append(tdSubtotal);
                    tr.append(tdIva);
                    tr.append(tdIce);
                    tr.append(tdTotal);
                    tr.append(tdObservaciones);
                    tr.append(tdAcciones);

                    tdAcciones.append(btnDelete);

                    var trOrig, band = false;

                    var cont = item.cantidad;
                    var c = 0;
                    var total = item.total;
                    var obs = item.observaciones;

                    $("#tbItems").find("tr").each(function () {
                        var i = $(this).data("item");
                        var iid = i.id;
                        var ibd = i.bodega.id;
                        if (iid == item.id && ibd == item.bodega.id) {
                            trOrig = $(this);
                            band = true;
                            if (!item.edit) {
                                cont += i.cantidad;
                                obs += ' ' + i.observaciones;
                            }
                            item.iva += i.iva;
                            item.ice += i.ice;
                            item.totalTodo += i.totalTodo;
                        }
                    });

                    if (!band) {
                        $("#tbItems").prepend(tr);
                    } else {

                        if (!item.edit) {
                            if (cont > item.max) {
                                cont = item.max;
                                $.box({
                                    imageClass : "box_info",
                                    text       : "Ha exedido el máximo para este item. (" + item.max + ")",
                                    title      : "Alerta",
                                    iconClose  : false,
                                    dialog     : {
                                        resizable : false,
                                        draggable : false,
                                        buttons   : {
                                            "Aceptar" : function () {
                                            }
                                        }
                                    }
                                });
                            }
                            total = (item.precio * cont);

                            item.cantidad = cont;
//                    item.descuento = descuento;
                            item.observaciones = obs;

                            tdCantidad.text(number_format(cont, 2, ".", ""));
                            tdObservaciones.text(obs);

                            item.total = total;
                            tdSubtotal.text(number_format(total, 2, ".", ""));

                        %{--var pctIva = parseFloat("${iva}") / 100;--}%
                        %{--item.iva = item.conIva * item.total * pctIva;--}%
                        %{--item.ice = item.pctIce * item.total;--}%

                        %{--item.totalTodo = item.total + item.iva + item.ice;--}%

                            tdIva.text(number_format(item.iva, 2, ".", ""));
                            tdIce.text(number_format(item.ice, 2, ".", ""));
                            tdTotal.text(number_format(item.totalTodo, 2, ".", ""));
                        }
                        item.edit = false;
                        trOrig.replaceWith(tr);
                    }

                    reset();
                    calcularTotales();
                }

            }
            function search() {
                var search = $("#txtBuscar").val();

                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action: 'buscarItem')}",
                    data    : {
                        search : search,
                        orden  : $("#ordenes").val()
                    },
                    success : function (msg) {
                        $("#area").html(msg);

                    }
                });
            }
            //Buscar Proveedor
            function buscarPro() {
                var buscar = $("#txtBuscarPro").val();

                $.ajax({
                    type : "POST",
                    url  : "${createLink(action: 'buscarProveedor')}",
                    data : {
                        search : buscar
                    },

                    success : function (msq) {
                        $("#area2").html(msq);

                    }
                });

            }
            //Buscar Orden de compra
            function buscarOC() {
                var buscar = $("#txtOC").val();
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action: 'buscarOC')}",
                    data    : {
                        search : buscar
                    },
                    success : function (msq) {
                        $("#areaOC").html(msq);
                    }
                });
            }

            function reset() {

//        console.log("reset")
                $("#txtItem").val("");
                $("#txtCantidad").val(1);
                $("#txtPrecio").val(0);
                $("#txaObservaciones").val("");
                $("#tdCodigo").text("");
                $("#tdPrecioT").text("");
                $("#tdAcciones").text("");
                $("#hCantidad").val("");

                $("#txtIva").text("");
                $("#txtIce").text("");
                $("#spIva").text("");
                $("#spIce").text("");
                $("#tdTotal").text("");

                $("#tdItem").removeData("item");

                cantAnt = 0;
                precioAnt = 0;
            }
            function resetOrden() {
                reset();

                $("#sumSubtotal").text("");
                $("#sumIva").text("");
                $("#sumIce").text("");
                $("#sumTotal").text("");
                $("#tbItems").html("");

                $("#tdSubtotalFin").text("");
                $("#tdIva12Fin").text("");
                $("#tdIva0Fin").text("");
                $("#tdIvaFin").text("");
                $("#tdIceFin").text("");
                $("#tdTotalFin").text("");

            }

            function calcularTotales() {
                var pctIva = parseFloat("${iva}") / 100;
                var subtotal = 0;
                var descuentos = 0;
                var iva12 = 0;
                var iva0 = 0;
                var iva1 = 0;
                var total1 = 0;
                var ice = 0;

                var sumSubtotal = 0;
                var sumIva = 0;
                var sumIce = 0;
                var sumTotal = 0;

                $("#tbItems").find("tr").each(function () {
                    var item = $(this).data("item");

                    subtotal += item.total;
                    descuentos += ((item.precio * item.cantidad) * (item.descuento / 100));
                    if (item.conIva == 1 || item.conIva == '1') {
                        iva12 += item.total;
                    } else {
                        iva0 += item.total;
                    }
                    ice += item.ice;

                    sumSubtotal += item.total;
                    sumIva += item.iva;
                    sumIce += item.ice;
                    sumTotal += item.totalTodo;

                });

                iva1 = subtotal * pctIva;

                total1 = subtotal - descuentos + iva1 + ice;

                $("#tdSubtotalFin").text(number_format(subtotal, 2, ".", "")).data("val", subtotal);
                $("#tdIva12Fin").text(number_format(iva12, 2, ".", "")).data("val", iva12);
                $("#tdIva0Fin").text(number_format(iva0, 2, ".", "")).data("val", iva0);
                $("#tdIvaFin").text(number_format(sumIva, 2, ".", "")).data("val", iva1);
                $("#tdIceFin").text(number_format(ice, 2, ".", "")).data("val", sumIce);
                $("#tdTotalFin").text(number_format(sumTotal, 2, ".", "")).data("val", total1);

                $("#sumSubtotal").text(number_format(sumSubtotal, 2, ".", "")).data("val", sumSubtotal);
                $("#sumIva").text(number_format(sumIva, 2, ".", "")).data("val", sumIva);
                $("#sumIce").text(number_format(sumIce, 2, ".", "")).data("val", sumIce);
                $("#sumTotal").text(number_format(sumTotal, 2, ".", "")).data("val", sumTotal);

            }

            function validarNumeros(max) {
                var precio = $("#txtPrecio").val();
                var cantidad = $("#txtCantidad").val();
                var descuento = $("#txtDescuento").val();

                var iva = $("#txtIva").val();
                var ice = $("#txtIce").val();

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
                        if (cantidad > max) {
                            cantidad = max;
                            $("#txtCantidad").val(max);
                            $.box({
                                imageClass : "box_info",
                                text       : "Ha exedido el máximo para este item. Ingrese una cantidad igual o inferior a " + max,
                                title      : "Alerta",
                                iconClose  : false,
                                dialog     : {
                                    resizable : false,
                                    draggable : false,
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

                if (trim(iva) == "") {
                    iva = 0;
                    $("#txtIva").val(0);
                } else {
                    if (isNaN(iva)) {
                        iva = 0;
                        $("#txtIva").val(0);
                    } else {
                        iva = parseFloat(iva);
                    }
                }

                if (trim(ice) == "") {
                    ice = 0;
                    $("#txtIce").val(0);
                } else {
                    if (isNaN(ice)) {
                        ice = 0;
                        $("#txtIce").val(0);
                    } else {
                        ice = parseFloat(ice);
                    }
                }

                if (descuento > 100) {
                    descuento = 100;
//                    0.38
                } else if (descuento < 0) {
                    descuento = 0;
                }
                if (precio < 0) {
                    precio = 0;
                }
                if (cantidad < 0) {
                    cantidad = 0;
                }
                if (iva < 0) {
                    iva = 0;
                }
                if (ice < 0) {
                    ice = 0;
                }

                var obj = {
                    precio    : precio,
                    cantidad  : cantidad,
                    descuento : descuento,
                    iva       : iva,
                    ice       : ice
                };
                return obj;
            }

            function validar($target) {
                if (trim($("#txtItem").val()) != "") {
                    var item = $("#tdItem").data("item");
                    var obj = validarNumeros(item.max);
                    var observaciones = $("#txaObservaciones").val();

                    var bodegaId = $("#bodega").val();
                    var bodega = $("#bodega option:selected").text();

                    item.cantidad = obj.cantidad;
                    item.precio = obj.precio;
                    item.descuento = obj.descuento;
                    item.observaciones = observaciones;
                    item.bodega = {id : bodegaId, texto : bodega};

                    var stotal = item.cantidad * item.precio;
                    var desc = stotal * (item.descuento / 100);
                    var total = stotal - desc;

                    item.total = total;

                    var pctIva = parseFloat("${iva}") / 100;
                    var pctIce = item.pctIce;

                    var iva, ice;
                    iva = item.conIva * (total * pctIva);
                    ice = total * pctIce;

                    var totalTodo = total + iva + ice;

                    item.totalTodo = totalTodo;
                    item.iva = iva;
                    item.ice = ice;

                    $("#tdItem").data("item", item);
                    $("#tdPrecioT").text(number_format(total, 2, ".", "")).css({textAlign : "right"});
                    $("#txtIva").val(number_format(iva, 2, ".", ""));
                    $("#txtIce").val(number_format(ice, 2, ".", ""));
                    $("#tdTotal").text(number_format(totalTodo, 2, ".", "")).css({textAlign : "right"});
                    if (0 > item.cantidad) {
                        $.box({
                            iconClose  : false,
                            imageClass : "box_warning",
                            title      : "Alerta",
                            text       : "La cantidad debe ser un número positivo",
                            dialog     : {
                                resizable : false,
                                buttons   : {
                                    "Aceptar" : function () {
                                    }
                                }
                            }
                        });
                    } else {
                        if (item.cantidad > $("#hCantidad").val() * 1) {
                            $.box({
                                iconClose  : false,
                                imageClass : "box_warning",
                                title      : "Alerta",
                                text       : "La máxima cantidad es " + $("#hCantidad").val() * 1,
                                dialog     : {
                                    resizable : false,
                                    buttons   : {
                                        "Aceptar" : function () {
                                        }
                                    }
                                }
                            });
                        } else {
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
        </script>

        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'adquisiciones.label', default: 'Adquisiciones')}"/>
        <title>Crear Adquisición</title>
    </head>

    <body>
        <a href="#create-adquisiciones" class="skip" tabindex="-1">
            <g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
        </a>

        <div id="create-adquisiciones" class="content scaffold-create" role="main">

            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <g:if test="${ordenesCompra}">
                        <li><g:link class="create linkButton" controller="ordenCompra" action="create">Crear orden de compra</g:link></li>
                    </g:if>
                </ul>
            </div>

            <div class="contenedor" style="width: 950px; height: 850px">
                <g:form name="form-adquisiciones" action="save">
                    <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all"
                         id="divErrores">
                        <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                        <span style="font-weight: solid;" id="spanError">Se encontraron los siguientes errores:</span>

                        <ul id="listaErrores"></ul>
                    </div>
                    <g:if test="${flash.message}">
                        <div class="message ${flash.clase}" role="status"><span
                                class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                        </div>
                    </g:if>
                    <g:hasErrors bean="${adquisicionesInstance}">
                        <ul class="errors" role="alert">
                            <g:eachError bean="${adquisicionesInstance}" var="error">
                                <li><g:if
                                        test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if><g:message
                                        error="${error}"/></li>
                            </g:eachError>
                        </ul>
                    </g:hasErrors>
                    <g:if test="${ordenesCompra}">
                        <div style="height: 30px;width: 900px;float: left;margin-left: 35px;margin-bottom: 0px">
                            <div class="fila span-22" style="height: 30px">

                                <div class="span-4 " style="height: 30px">
                                    <label for="odc" id="odc_lbl" style="height: 30px;line-height: 30px;">
                                        Orden de compra:
                                    </label>
                                </div>

                                <div class="span-6">
                                    <g:hiddenField name="ordenes" value="${ordenCompra ? ordenCompra.id : ''}"/>
                                    <input type="text" class="ui-corner-all" id="txtBuscarOC" value="${ordenCompra ? ordenCompra.descripcion : ''}"/>
                                </div>

                                %{--<div class="span-4 " style="height: 30px">--}%
                                %{--<label for="odc" id="odc_lbl" style="height: 30px;line-height: 30px;">--}%
                                %{--Centro de costo:--}%
                                %{--</label>--}%
                                %{--</div>--}%

                                %{--<div class="span-6">--}%
                                %{--<g:select name="centro" from="${cratos.CentroCosto.findAllByEmpresa(session.empresa)}"--}%
                                %{--optionKey="id" optionValue="nombre" id="centro"></g:select>--}%

                                %{--</div>--}%

                            </div>
                        </div>
                    </g:if>
                    <g:render template="form"/>

                    <g:textField name="validarItems" class="ui-helper-hidden-accessible"/>
                </g:form>
                <div style="position: relative; overflow:hidden; min-height: 280px; width: 100%;">
                    <fieldset style="margin: 10px">
                        <legend>Productos</legend>

                        <table class="bg">
                            <thead>
                                <tr>
                                    <th class="label">
                                        Item
                                    </th>
                                    <th class="label">
                                        Código
                                    </th>
                                    <th class="label">
                                        Precio unitario
                                    </th>
                                    <th class="label">
                                        Cantidad
                                    </th>
                                    <th class="label">
                                        Subtotal
                                    </th>
                                    <th class="label">
                                        IVA
                                    </th>
                                    <th class="label">
                                        ICE
                                    </th>
                                    <th class="label">
                                        Total
                                    </th>
                                    <th class="label" width="190">
                                        Observaciones
                                    </th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td id="tdItem">
                                        <input type="text" class="ui-widget-content ui-corner-all" id="txtItem" style="width: 180px;"/>
                                    </td>
                                    <td id="tdCodigo">
                                    </td>
                                    <td id="tdPrecioU">
                                        <input type="number" class="ui-widget-content ui-corner-all updatable" id="txtPrecio"
                                               style="width:50px; text-align:right;"/>
                                    </td>
                                    <td id="tdCantidad">
                                        <input type="hidden" id="hCantidad">
                                        <input type="number" class="ui-widget-content ui-corner-all updatable" id="txtCantidad"
                                               style="width: 50px; text-align:right;"/>
                                    </td>
                                    <td id="tdPrecioT">
                                    </td>
                                    <td id="tdIva">

                                        <span id="txtIva" style="width: 35px; text-align: right"></span>


                                        <span id="spIva" style="width: 25px;"></span>

                                    </td>
                                    <td id="tdIce">

                                        <span id="txtIce" style="width: 35px; text-align: right"></span>

                                        <span id="spIce" style="width: 25px;"></span>
                                    </td>
                                    <td id="tdTotal">

                                    </td>
                                    <td id="tdObservaciones">
                                        <textarea id="txaObservaciones" class="ui-widget-content ui-corner-all updatable" rows="10"
                                                  cols="10" style="width: 150px; height: 19px; resize: none"></textarea>
                                    </td>
                                    <td style="width: 10px">
                                        <a href="#" id="btnAdd">Agregar</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <table id="tblItems" border="1" style="border-collapse: collapse; border-color: #555;">
                            <thead>
                                <th class="label">
                                    Código
                                </th>
                                <th class="label" style="width: 190px;">
                                    Item
                                </th>
                                <th class="label">
                                    Cantidad
                                </th>
                                <th class="label">
                                    Precio unitario
                                </th>
                                <th class="label">
                                    Subtotal
                                </th>
                                <th class="label">
                                    IVA
                                </th>
                                <th class="label">
                                    ICE
                                </th>
                                <th class="label">
                                    Total
                                </th>
                                <th class="label" width="190">
                                    Observaciones
                                </th>

                                <th width="30">

                                </th>
                            </thead>
                            <tbody id="tbItems" name="tbItems">
                                <g:if test="${adquisicionesInstance.id}">
                                    <g:each in="${cratos.DetalleAdquisicion.findAllByAdquisiciones(adquisicionesInstance)}" var="dt">
                                        <g:set var="orden" value="${adquisicionesInstance.orden}"/>
                                        <g:set var="detalle" value="${cratos.DetalleOrdenCompra.findByItemAndOrdenCompra(dt.item, orden).cantidad}"/>
                                        <script type="text/javascript">
                                            var item = {
                                                id        : ${dt.item.id},
                                                codigo    : '${dt.item.codigo}',
                                                nombre    : '${dt.item.nombre}',
                                                marca     : '${dt.item.marca}',
                                                conIva    : parseInt("${dt.item.iva}"),
                                                precio    : parseFloat("${dt.precioUnitario}"),
                                                cantidad  : parseFloat("${dt.cantidad}"),
                                                descuento : 0,
                                                total     : parseFloat("${dt.precioUnitario*dt.cantidad}"),
                                                max       : parseFloat(${detalle-cantidades[dt.item]}),
                                                iva       : parseFloat("${dt.precioUnitario*dt.cantidad*iva/100}"),
                                                ice       : parseFloat("${dt.precioUnitario*dt.cantidad*dt.item.ice}"),
                                                pctIce    : parseFloat("${dt.item.ice}")
                                            }
                                            item.totalTodo = item.total + item.iva + item.ice;
                                            $("#tdItem").data("item", item);
                                            $("#txtItem").val(item.nombre);
                                            $("#tdCodigo").text(item.codigo);
                                            $("#txtPrecio").val(number_format(item.precio, 2, ".", ""));
                                            $("#txtCantidad").val(item.cantidad);
                                            $("#txtDescuento").val(0);
                                            $("#tdPrecioT").text(number_format(item.total, 2, ".", "")).css({textAlign : "right"});
                                            $("#hCantidad").val(parseFloat(item.max));

                                            $("#txtIva").text(number_format(item.iva, 2, ".", ""));
                                            $("#txtIce").text(number_format(item.ice, 2, ".", ""));

                                            $("#spIva").text(number_format(parseFloat("${iva/100}") * 100, 2, ".", "") + "%");
                                            $("#spIce").text(number_format(parseFloat(item.pctIce) * 100, 2, ".", "") + "%");

                                            $("#tdTotal").text(number_format(item.totalTodo, 2, ".", ""));

                                            addItem();
                                        </script>
                                    </g:each>
                                    <script type="text/javascript">
                                        calcularTotales();
                                    </script>
                                </g:if>
                            </tbody>
                            <tfoot>
                                <td colspan="4"></td>
                                <td style="text-align: right;" id="sumSubtotal"></td>
                                <td style="text-align: right;" id="sumIva"></td>
                                <td style="text-align: right;" id="sumIce"></td>
                                <td style="text-align: right;" id="sumTotal"></td>
                                <td colspan="2"></td>
                            </tfoot>
                        </table>

                        <table class="span-5" border="1" style="border-collapse: collapse;">
                            <tr>
                                <th>Subtotal</th>
                                <td id="tdSubtotalFin" style="text-align: right;">0.00</td>
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
                                <th>ICE</th>
                                <td id="tdIceFin" style="text-align: right;">0.00</td>
                            </tr>
                            <tr>
                                <th>TOTAL</th>
                                <td id="tdTotalFin" style="text-align: right;">0.00</td>
                            </tr>
                        </table>

                    </fieldset>

                    <div class="ui-widget-header buttons botones">

                        <a href="#" id="btnUpdatePrecio">Actualizar Precio</a>
                        %{--<a href="#" class="btnGuardar">Guardar</a>--}%
                        <a href="#" class="btnContinuar">Continuar</a>

                    </div>

                    <div id="overlay">
                        <div class="ui-overlay">
                            <div class="ui-widget-overlay">
                            </div>

                            <div style="width: 302px; height: 152px; position: absolute; left: 50px; top: 30px;" class="ui-widget-shadow ui-corner-all">
                            </div>
                        </div>

                        <div class="ui-widget ui-widget-content ui-corner-all" style="position: absolute; width: 280px; height: 130px;left: 50px; top: 30px; padding: 10px;">
                            <p>Seleccione una orden de compra para ingresar productos</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div id="dlgBuscar" title="Buscar item">
            <div style="height: 40px;">
                <input type="text" id="txtBuscar" class="span-5 ui-widget-content ui-corner-all"/>
                <span class="span-1">
                    <a href="#" id="btnItem">Buscar</a>
                </span>
            </div>

            <div id="area" style="width: 500px; max-height: 500px; overflow-y: auto; overflow-x: hidden;">

            </div>
        </div>

        <div id="dlgBuscarPro" title="Buscar Proveedor">

            <div style="height: 40px">
                <input type="text" id="txtBuscarPro" class="span-5 ui-widget-content ui-corner-all">
                <span class="span-1">

                    <a href="#" id="btnPro">Buscar Proveedor</a>

                </span>

            </div>


            <div id="area2" style="width: 500px; max-height: 500px; overflow-y: auto; overflow-x: hidden; ">

            </div>
        </div>

        <div id="dlgBuscarOC" title="Buscar Orden de compra">
            <div style="height: 40px">
                <input type="text" id="txtOC" class="span-5 ui-widget-content ui-corner-all">
                <span class="span-1">
                    <a href="#" id="btnOC">Buscar Proveedor</a>
                </span>
            </div>

            <div id="areaOC" style="width: 500px; max-height: 500px; overflow-y: auto; overflow-x: hidden; ">
            </div>
        </div>


        <div id="dlgContinuar" title="Continuar">

        </div>


        <script type="text/javascript">

            //validar

            $(function () {

                $("#btnUpdatePrecio").button({
                    text : "Actualizar",

                    icons : {
                        primary : "ui-icon-circle-arrow-s"

                    }
                }).click(function () {

                            $.box({
                                imageClass : "box_question",
                                text       : "Está seguro de actualizar el precio en la tabla Items?",
                                title      : "Confirmación",
                                iconClose  : false,
                                dialog     : {
                                    resizable     : false,
                                    draggable     : false,
                                    closeOnEscape : false,
                                    buttons       : {
                                        "Aceptar"  : function () {
                                            var id = $("#btnUpdatePrecio").attr("item");
                                            var precio = $("#txtPrecio").val();
                                            $.ajax({
                                                type    : "POST",
                                                url     : "${createLink(controller: 'item', action: 'updatePrecio')}",
                                                data    : {
                                                    id     : id,
                                                    precio : precio
                                                },
                                                success : function (msg) {
                                                    var parts = msg.split("_");
                                                    $.box({
                                                        imageClass : "box_" + parts[1],
                                                        text       : parts[0],
                                                        title      : parts[2],
                                                        iconClose  : false,
                                                        dialog     : {
                                                            resizable     : false,
                                                            draggable     : false,
                                                            closeOnEscape : false,
                                                            buttons       : {
                                                                "Aceptar"  : function () {
                                                                },
                                                                "Cancelar" : function () {
                                                                }
                                                            }
                                                        }
                                                    });
                                                }
                                            });
                                        },
                                        "Cancelar" : function () {
                                        }
                                    }
                                }
                            });
                        });
//

                $("#form-adquisiciones").validate({
                    errorLabelContainer : "#listaErrores",
                    wrapper             : "li",
                    invalidHandler      : function (form, validator) {
                        var errors = validator.numberOfInvalids();
//                        console.log("**" + errors);
                        if (errors) {
                            var message = errors == 1
                                    ? 'Se encontró 1 error.'
                                    : 'Se encontraron ' + errors + ' errores';
                            $("#divErrores").show();
                            $("#spanError").html(message);

                        } else {
                            $("#divErrores").hide();

                        }
                    },
                    groups              : {
                        factura : "facturaSerie1 facturaSerie2 facturaNumero"
                    },
                    rules               : {
                        "gestor\.id"    : {
                            required : true
                        },
                        facturaSerie1   : {
                            required  : true,
                            maxlength : 3,
                            digits    : true
                        },
                        facturaSerie2   : {
                            required  : true,
                            maxlength : 3,
                            digits    : true
                        },
                        facturaNumero   : {
                            required  : true,
                            maxlength : 10,
                            digits    : true
                        },
                        "proveedor\.id" : {
                            required : true
                        },
                        "tipoPago\.id"  : {
                            required : true
                        },
//                cheque          : {
//                    required  : function (element) {
//                        return $("#tipoPago").val() == "2";
//                    },
//                    maxlength : 15
//
//                },
//                estadoCheque    : {
//                    required : function (element) {
//                        return $("#tipoPago").val() == "2";
//                    }
//                },
                        validarItems    : {
                            minRows : ["#tbItems tr", 1]
                        }
                    },
                    messages            : {
                        "gestor\.id"    : {
                            required : "Seleccione un gestor para la factura"
                        },
                        facturaSerie1   : {
                            required : "Ingrese el número de factura (dos seriales y un secuencial)",
                            digits   : "El número de factura debe tener únicamente dígitos"
                        },
                        facturaSerie12  : {
                            required : "Ingrese el número de factura (dos seriales y un secuencial)",
                            digits   : "El número de factura debe tener únicamente dígitos"
                        },
                        facturaNumero   : {
                            required : "Ingrese el número de factura (dos seriales y un secuencial)",
                            digits   : "El número de factura debe tener únicamente dígitos"
                        },
                        "proveedor\.id" : {
                            required : "Seleccione un proveedor"
                        },
                        "empresa\.id"   : {
                            required : "Seleccione una empresa"
                        },
                        "tipoPago\.id"  : {
                            required : "Ingrese el tipo de pago"
                        },
                        cheque          : {
                            required  : "Ingrese el número del cheque",
                            maxlength : jQuery.format("El número del cheque debe tener máximo hasta {0} caracteres")

                        },
                        estadoCheque    : {
                            required : "Ingrese el estado del cheque"

                        },
                        validarItems    : {
                            minRows : "Ingrese al menos 1 item"
                        },
                        descripcion     : {
                            required : "Ingrese la descripción de la adquisición"
                        }

                    }
                });

                <g:if test="${ordenCompra==null}">
                $("input").val("");
                </g:if>
                <g:else>
                $("#overlay").hide();
                </g:else>
                <g:if test="${!ordenesCompra}">
                $("#overlay").hide();
                </g:if>

                <g:if test="${!adquisicionesInstance.id}">
                $("input").not("#txtBuscarOC,#ordenes").val("");
                $("select").attr("selectedIndex", 0);
                reset();
                </g:if>
                <g:else>
                calcularTotales()
                </g:else>

                $("#btnAdd").button({
                    icons : {
                        primary : "ui-icon-plusthick"
                    },
                    text  : false
                }).click(function () {
                            addItem();
                            $("#form-adquisiciones").valid();
                        });

                $(".btnContinuar").button({
                    icons : {
                        primary : "ui-icon-check"
                    }
                }).click(function () {
                            if ($("#form-adquisiciones").valid()) {
                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(action:'datosSri')}",
                                    data    : {
                                        ordenCompra : $("#ordenes").val(),
                                        proveedor   : $("#proveedorHidden").val()
                                    },
                                    success : function (msg) {
                                        $("#dlgContinuar").html(msg);
                                        $("#dlgContinuar").dialog("open");
                                    }
                                });
                            }
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

                $("#btnPro").button({
                    text  : false,
                    icons : {

                        primary : "ui-icon-search"
                    }
                }).click(function () {
                            buscarPro();
                            return false;
                        });

                $("#btnOC").button({
                    text  : false,
                    icons : {

                        primary : "ui-icon-search"
                    }
                }).click(function () {
                            buscarOC();
                            return false;
                        });

//        $("#tipoPago").change(function () {
//            if ($(this).val() == 2) {
//                $("#cheque").show();
//                $("#chequeLabel").show();
//                $("#estadoCheque").show();
//                $("#estadoChequeLabel").show();
//            } else {
//                $("#cheque").hide();
//                $("#chequeLabel").hide();
//                $("#estadoCheque").hide();
//                $("#estadoChequeLabel").hide();
//            }
//        });

                $("#txtItem").focus(function () {
                    $(".selected").removeClass("selected");
                    search();
                    $("#dlgBuscar").dialog("open");
                    return false;
                });

                $("#txtBuscarOC").focus(function () {
                    $(".selected").removeClass("selected");
                    buscarOC();
                    $("#dlgBuscarOC").dialog("open");
                    return false;
                });

                $("#proveedor").focus(function () {
                    $(".selected").removeClass("selected");
                    buscarPro();
                    $("#dlgBuscarPro").dialog("open");
                    return false;
                });

                $(".updatable").blur(function () {
                    validar($(this));
                });

                $("#dlgContinuar").dialog({
                    autoOpen : false,
                    width    : 400,
                    height   : 400,
                    modal    : true,
                    close    : function (event, ui) {
                        $("#divErrores").hide();
                    },
                    buttons  : {
                        "Cancelar" : function () {
                            $("#dlgContinuar").dialog("close");
                        },
                        "Aceptar"  : function () {
                            if ($("#form-adquisiciones").valid() && $("#frmSri").valid()) {
                                $.box({
                                    imageClass : "box_loading",
                                    text       : "Cargando...Por favor espere...",
                                    title      : "Cargando",
                                    iconClose  : false,
                                    dialog     : {
                                        resizable : false,
                                        draggable : false,
                                        buttons   : {}
                                    }
                                });
                                var id = "${adquisicionesInstance.id}"
                                var proveedor = $("#proveedorHidden").val();
                                var factura = trim($("#factura").val());
                                var empresa = ${session.empresa.id};
                                var tipoPago = $("#tipoPago").val();
                                var fecha = "${new Date().format('yyyy-MM-dd')}";
                                var fechaPago = $("#fechaPago").val();
                                var observaciones = trim($("#observaciones").val());
                                var descripcion = trim($("#descripcion").val());
                                var estadoCheque = $("#estadoCheque").val();
                                var registro = $("#registro").val();
                                var cheque = $("#cheque").val();
                                var gestorContable = $("#gestor").val();
                                var orden = $("#ordenes").val()
                                var centro = $("#centro").val()

                                var facturaSerie1 = $("#facturaSerie1").val();
                                var facturaSerie2 = $("#facturaSerie2").val();
                                var facturaNumero = $("#facturaNumero").val();

                                var items = "";

                                var item = "";

                                var msgError = "";

                                var tipoComprobanteId = $("#tipoComprobanteId").val();
                                var fechaEmision = $("#fechaEmision").val();
                                var fechaRegistro = $("#fechaRegistro").val();
                                var autorizacionSRI = $("#autorizacionSRI").val();
                                var baseImponibleNoIva = $("#baseImponibleNoIva").val();
                                var iceGenerado = $("#sumIce").data("val");
                                var retencionIvaBienes = $("#retencionIvaBienes").val();
                                var retencionIvaServicios = $("#retencionIvaServicios").val();
                                var retencionIva = $("#retencionIva").val();

                                var tipoRetencion = $(".rbt:checked").val();

                                $("#tbItems").find("tr").each(function () {

                                    item = $(this).data("item");
                                    var stotal = item.cantidad * item.precio;
                                    var desc = stotal * (item.descuento / 100);
                                    var total = stotal - desc;

                                    items += "&item=" + item.id + "^" + item.cantidad + "^" + item.precio + "^" + item.descuento + "^" + item.conIva + "^" + item.bodega.id + "^" + item.iva + "^" + item.ice

                                });

                                var data = "factura=" + factura + "&fecha=" + fecha + "&fechaPago=" + fechaPago + "&observaciones=" + observaciones + "&cheque=" + cheque + "&descripcion=" + descripcion;
                                if (id * 1 > 0)
                                    data += "&id=" + id
                                data += "&facturaSerie1=" + facturaSerie1;
                                data += "&facturaSerie2=" + facturaSerie2;
                                data += "&facturaNumero=" + facturaNumero;

                                data += "&tipoComprobanteId=" + tipoComprobanteId;
                                data += "&fechaEmision=" + fechaEmision;
                                data += "&fechaRegistro=" + fechaRegistro;
                                data += "&autorizacionSRI=" + autorizacionSRI;
                                data += "&baseImponibleNoIva=" + baseImponibleNoIva;
                                data += "&iceGenerado=" + iceGenerado;
                                data += "&retencionIvaBienes=" + retencionIvaBienes;
                                data += "&retencionIvaServicios=" + retencionIvaServicios;
                                data += "&retencionIva=" + retencionIva;

                                data += "&proveedor.id=" + proveedor;
                                data += "&tipoPago.id=" + tipoPago;
                                data += "&empresa.id=" + empresa;
                                data += "&estadoCheque=" + estadoCheque;
                                data += "&registro=" + registro;
                                data += "&subtotal=" + $("#tdSubtotalFin").data("val");
                                data += "&iva1=" + $("#tdIva12Fin").data("val");
                                data += "&iva0=" + $("#tdIvaFin").data("val");
                                data += "&total=" + $("#tdTotalFin").data("val");
                                data += "&gestor.id=" + $("#gestor").val();
                                data += "&centroCosto=" + $("#centro").val();
                                data += "&tipoRetencion=" + tipoRetencion;
                                if (orden * 1 > -1)
                                    data += "&orden.id=" + orden
                                data += items;
                                data += "&iva=" + $("#tdIvaFin").data("val");

                                data += "&retencionSerie1=" + $("#rentaSerie1").val();
                                data += "&retencionSerie2=" + $("#rentaSerie2").val();
                                data += "&retencionSecuencial=" + $("#rentaSecuencial").val();
                                data += "&retencionAutorizacion=" + $("#rentaAutorizacion").val();

                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(action: 'save')}",
                                    data    : data,
                                    success : function (msg) {
                                        if (msg != "error") {
                                            window.location.href = "${g.createLink(controller: 'adquisiciones',action: 'show')}/" + msg
                                        }
                                    }
                                });

                            } else {
//                        console.log("AQUI")
                            }
                        }
                    }
                });

                $("#dlgBuscar").dialog({
                    autoOpen : false,
                    width    : 525,
                    height   : 600,
                    modal    : true
                });

                $("#dlgBuscarPro").dialog({
                    autoOpen : false,
                    width    : 525,
                    height   : 600,
                    modal    : true
                });

                $("#dlgBuscarOC").dialog({
                    autoOpen : false,
                    width    : 525,
                    height   : 600,
                    modal    : true
                });
//
//                $("#ordenes").change(function () {
//                    resetOrden();
//                });

            });




        </script>

    </body>
</html>