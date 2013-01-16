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
        <title>Orden de compra</title>

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
            <div id="create-ordenCompra" class="content scaffold-create" role="main">
                <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                    <ul style="margin-bottom:0;">
                        <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    </ul>
                </div>


                <div class="contenedor" style="height: 650px">
                    <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all" id="divErrores">
                        <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                        <span style="font-weight: solid;" id="spanError">Se encontraron los siguientes errores:</span>

                        <ul id="listaErrores"></ul>
                    </div>


                    <fieldset style="margin: 10px;">
                        <legend>Orden de compra</legend>

                        <div class="span-20">
                            <div class="span-3">Número:</div>

                            <div class="span-10">
                                <g:textField name="numero" value="${ordenCompraInstance.numero}" style="width: 100px" class="required span-6 ui-widget-content ui-corner-all"/>
                            </div>

                        </div>

                        <div class="span-20">
                            <div class="span-3">Centro de costo:</div>

                            <div class="span-10">
                                <g:select from="${cratos.CentroCosto.findAllByEmpresa(session.empresa, [sort: 'nombre'])}"
                                          name="centroCosto" class="required span-6 ui-widget-content ui-corner-all"
                                          value="${ordenCompraInstance.centroCostoId}" style="width: 100px" optionKey="id"
                                          optionValue="nombre"/>
                            </div>

                            <div class="span-3 prepend-1">Fecha:</div>

                            <div class="span-2">
                                %{--<g:if test="${ordenCompraInstance.id}">--}%
                                %{--<g:formatDate date="${ordenCompraInstance.fecha}" format="dd-MM-yyyy"/>--}%
                                %{--</g:if>--}%
                                %{--<g:else>--}%
                                %{--<g:formatDate date="${new java.util.Date()}" format="dd-MM-yyyy"/>--}%
                                %{--</g:else>--}%
                                %{----}%

                                <g:set var="periodo"
                                       value="${cratos.Periodo.findAllByFechaInicioLessThanEqualsAndFechaFinGreaterThanEquals(new Date(), new Date())[0]}"/>


                                %{--${periodo.fechaInicio}--}%



                                <input type="text" id="datepicker" class="field ui-corner-all  datepicker" style="width: 70px">

                            </div>
                        </div>

                        <div class="span-20">
                            <div class="span-3">Descripci&oacute;n:</div>

                            <div class="span-10">
                                <g:textArea name="descripcion" class="required" rows="15" cols="15" style="width: 380px; height: 25px;"
                                            value="${ordenCompraInstance.descripcion}"/>
                            </div>

                            <div class="span-3 prepend-1">Estado:</div>

                            <div class="span-2">
                            %{--<g:select from="${['N': 'No registrado', 'R': 'Registrado']}" name="estado"--}%
                            %{--class="required span-6 ui-widget-content ui-corner-all"--}%
                            %{--value="${ordenCompraInstance.estado}" style="width: 100px" optionKey="key"--}%
                            %{--optionValue="value"/>--}%

                                <g:if test="${ordenCompraInstance.id != null}">

                                    <td>${ordenCompraInstance.estado}</td>

                                </g:if>

                                <g:else>

                                    No Registrado

                                </g:else>

                            </div>
                        </div>

                        <div class="span-20">

                            <div class="span-3">Observaciones:</div>

                            <div class="span-10">
                                <g:textArea name="observaciones" rows="15" cols="15" style="width: 380px; height: 25px;"
                                            value="${ordenCompraInstance.observaciones}"/>
                            </div>
                        </div>

                    </fieldset>

                    <fieldset style="margin: 10px;">
                        <legend>Productos</legend>

                        <table class="bg" style="width: 100%;">
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
                                %{--<td class="label" width="100">--}%
                                %{--Descuento--}%
                                %{--</td>--}%
                                <td class="label">
                                    Precio total
                                </td>
                                %{--<td class="label">--}%
                                %{--Observaciones--}%
                                %{--</td>--}%
                                <td></td>
                            </tr>

                            <tr>
                                <td id="tdItem">
                                    <input type="text" class=" ui-corner-all" id="txtItem" style="width: 250px;"/>
                                </td>
                                <td id="tdCodigo">

                                </td>
                                <td id="tdPrecioU">
                                    <input type="number" class=" ui-corner-all updatable" id="txtPrecio"
                                           style="width: 75px; text-align:right;"/>
                                </td>
                                <td id="tdCantidad">
                                    <input type="number" class=" ui-corner-all updatable" id="txtCantidad"
                                           style="width: 75px; text-align:right;"/>
                                </td>
                                %{--<td id="tdDescuento">--}%
                                %{--<input type="number" min="0" max="100" id="txtDescuento"--}%
                                %{--class=" ui-corner-all updatable" value="0"--}%
                                %{--style="width: 45px; text-align:right;" s/>%--}%
                                %{--</td>--}%
                                <td id="tdPrecioT">

                                </td>
                                %{--<td id="tdObservaciones">--}%
                                %{--<textarea id="txaObservaciones" class=" ui-corner-all updatable" rows="10" cols="10"--}%
                                %{--style="width: 150px;resize: none; height: 19px;"></textarea>--}%
                                %{--</td>--}%
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
                                    %{--<th width="80" class="descuento">--}%
                                    %{--Descuento--}%
                                    %{--</th>--}%
                                    <th width="80" class="subtotal">
                                        Subtotal
                                    </th>
                                    %{--<th width="200">--}%
                                    %{--Observaciones--}%
                                    %{--</th>--}%
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
                        </table>
                    </fieldset>
                </div>

                <div class="ui-widget-header buttons botones">
                    <a href="#" class="btnGuardar">Guardar</a>
                </div>

                <div id="dlgBuscar" title="Buscar item">
                    <div style="height: 40px;">
                        <input type="text" id="txtBuscar" class="span-6  ui-corner-all"/>
                        <span class="span-1">
                            <a href="#" id="btnItem">Buscar</a>
                        </span>
                    </div>

                    <div id="area" style="width: 500px; max-height: 500px; overflow-y: auto; overflow-x: hidden;">

                    </div>

                </div>
            </div>
        </form>

        <script type="text/javascript">


            //datepicker

            $(function () {
                $("#datepicker").datepicker({ minDate : new Date(${periodo.fechaInicio.format("yyyy")}, ${periodo.fechaInicio.format("MM")}, ${periodo.fechaInicio.format("dd")}),
                    maxDate                           : new Date(${periodo.fechaFin.format("yyyy")}, ${periodo.fechaFin.format("MM")}, ${periodo.fechaFin.format("dd")})

                });
            });

            var url = "${resource(dir:'images', file:'loading_bg.gif')}";
            var img = "<div style='text-align: center;'><img src='" + url + "' alt='Cargando...'/></div>";

            function loadItems() {
                var id = "${ordenCompraInstance.id}";
                if (id != "") {
                    $("#tbItems").html(img);

                    $.ajax({
                        type     : "POST",
                        url      : "${createLink(action:'loadItems')}",
                        data     : {
                            id : id
                        },
                        dataType : 'json',
                        success  : function (msg) {
                            $("#tbItems").html("");
                            for (var i = 0; i < msg.length; i++) {
                                createRow(msg[i]);
                            }
                        }
                    });
                }
            }

            function search() {
                var search = $("#txtBuscar").val();

                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: "item", action: 'buscarItemOrdenCompra')}",
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

            function createRow(item) {
                var tr = $("<tr>");
                tr.data("item", item);

                var tdCantidad = $("<td>" + number_format(item.cantidad, 2, ".", "") + "</td>").css({textAlign : "right"});
                var tdCodigo = $("<td>" + item.codigo + "</td>");
                var tdItem = $("<td>" + item.nombre + "</td>");
                var tdPrecioU = $("<td>" + number_format(item.precio, 2, ".", "") + "</td>").css({textAlign : "right"});
//                    var tdDescuento = $("<td>" + number_format(item.descuento, 2, ".", "") + "%</td>").css({textAlign : "right"});
                var tdSubtotal = $("<td>" + number_format(item.total, 2, ".", "") + "</td>").css({textAlign : "right"});
//                    var tdObservaciones = $("<td>" + item.observaciones + "</td>");

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
//                                $("#txtDescuento").val(item.descuento);
                            $("#tdPrecioT").text(number_format(item.total, 2, ".", "")).css({textAlign : "right"});
//                                $("#txaObservaciones").val(item.observaciones);
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
                                if (item.saved) {
                                    $.ajax({
                                        type    : "POST",
                                        url     : "${createLink(action:'deleteDetalle')}",
                                        data    : {
                                            id : item.detalle
                                        },
                                        success : function (msg) {
                                            if (msg == "OK") {
                                                tr.remove();
                                            } else {
                                                alert("Ha ocurrido un error al eliminar: " + msg);
                                            }
                                        }
                                    });
                                } else {
                                    tr.remove();
                                }
                            }
                            calcularTotales();
                        });

                tdAcciones.append(btnEdit);
                tdAcciones.append(btnDelete);

                tr.append(tdCantidad);
                tr.append(tdCodigo);
                tr.append(tdItem);
                tr.append(tdPrecioU);
//                    tr.append(tdDescuento);
                tr.append(tdSubtotal);
//                    tr.append(tdObservaciones);
                tr.append(tdAcciones);

                var trOrig, band = false;
                var cont = item.cantidad;

//                    var descuento = item.descuento;
                var total = item.total;
//                    var obs = item.observaciones;

                $("#tbItems").find("tr").each(function () {
                    var i = $(this).data("item");
                    var iid = i.id;

                    if (iid == item.id) {
                        trOrig = $(this);
                        band = true;
                        if (!item.edit) {
                            cont += i.cantidad;
//                                descuento = i.descuento;
//                                obs += ' ' + i.observaciones;
                        }

                    }
                });

                if (!band) {
                    $("#tbItems").prepend(tr);
                } else {
                    if (!item.edit) {
                        total = (item.precio * cont) /*- ((item.precio * cont) * (descuento / 100))*/;

                        item.cantidad = cont;
//                            item.descuento = descuento;
//                            item.observaciones = obs;

//                tr.css({background:'orange'});
                        tdCantidad.text(number_format(cont, 2, ".", ""));
//                            tdDescuento.text(number_format(descuento, 2, ".", ""));
//                            tdObservaciones.text(obs);

                        item.total = total;
                        tdSubtotal.text(number_format(total, 2, ".", ""));
                    }

                    item.edit = false;

                    trOrig.replaceWith(tr);
                }

                reset();
                calcularTotales();

            }

            function addItem() {
                if (validar()) {
                    var item = $("#tdItem").data("item");
                    createRow(item);
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
//                    item.observaciones = observaciones;
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

                loadItems();

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
                        verifItems : {
                            minRows : ["#tbItems tr", 1]
                        }
                    },
                    messages            : {
                        descripcion : 'Ingrese la descripción de la orden de compra',
                        numero      : {
                            required : "Ingrese el número de la orden de compra"
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

                $(".btnGuardar").button({
                    icons : {
                        primary : "ui-icon-check"
                    }
                }).click(function () {

                            if ($("#frmAll").valid()) {
                                $.box({
                                    imageClass : "box_loading",
                                    text       : "Cargando... Por favor espere...",
                                    title      : "Cargando...",
                                    iconClose  : false,
                                    dialog     : {
                                        draggable     : false,
                                        resizable     : false,
                                        closeOnEscape : false,
                                        buttons       : false
                                    }
                                });

                                var centroCosto = $("#centroCosto").val();
                                var estado = $("#estado").val();
                                var observaciones = $("#observaciones").val();
                                var descripcion = $("#descripcion").val();

                                var fecha = "${new Date().format("yyyy-MM-dd")}";

                                var numero = $.trim($("#numero").val());

                                var items = "";

                                $("#tbItems").find("tr").each(function () {
                                    var item = $(this).data("item");

                                    var stotal = item.cantidad * item.precio;

                                    items += "&item=" + item.id + "^" + item.cantidad + "^" + item.precio;
                                    if (item.saved) {
                                        items += "^" + item.detalle
                                    }
                                });

                                var data = "centroCosto=" + centroCosto + "&estado=" + estado + "&observaciones=" + observaciones + "&fecha=" + fecha + "&descripcion=" + descripcion;
                                data += "&subtotal=" + $("#tdSubtotalFin").data("val");
                                data += "&numero=" + numero;
                                var idoc = "${ordenCompraInstance.id}";
                                if (idoc != "") {
                                    data += "&id=" + idoc;
                                }
                                data += items;

                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink (action: 'save') }",
                                    data    : data,
                                    success : function (msg) {
                                        if (msg != "error") {
                                            location.href = "${g.createLink(action:'show')}/" + msg
                                        } else {
                                            alert("HA ocurrido un error!!");
                                        }
                                    }
                                });
                            }
                        });
//
//        $("#btnBuscar").button({
//            text:false,
//            icons:{
//                primary:"ui-icon-search"
//            }
//        }).click(function () {
//
//                    var c2 = $("#ci").val();
//
//                    if (c2.length >= 10) {
//                        buscarCedula();
//                        return false;
//                    }
//                    else {
//                        $.box({
//                            iconClose:false,
//                            imageClass:"box_error",
//                            title:"Error",
//                            text:"Cédula o RUC incorrectos!!",
//                            dialog:{
//                                resizable:false,
//                                buttons:{
//                                    "Aceptar":function () {
//                                    }
//                                }
//                            }
//                        });
//                        return false;
//
//                    }
//                });

                $("#btnItem").button({
                    text  : false,
                    icons : {
                        primary : "ui-icon-search"
                    }
                }).click(function () {
                            search();
                            return false;
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