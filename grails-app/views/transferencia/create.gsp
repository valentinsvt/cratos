<%@ page import="cratos.Proceso; cratos.Transferencia" %>
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

            var loading = $("<img src='" + "${resource(dir:'images', file:'loading_sm.gif')}" + "' alt='Cargando...' /> ");

            var precioAnt = 0;
            var cantAnt = 0;
            function addItem() {
                if (validar(false)) {
                    var item = $("#tdItem").data("item");

                    var tr = $("<tr>");
                    tr.data("item", item);

                    var tdCantidad = $("<td>" + number_format(item.cantidad, 2, ".", "") + "</td>").css({textAlign : "right"});
                    var tdCodigo = $("<td>" + item.codigo + "</td>");
                    var tdItem = $("<td>" + item.nombre + "</td>");
                    var tdPrecioC = $("<td>" + number_format(item.precio, 2, ".", "") + "</td>").css({textAlign : "right"});
                    var tdSubtotal = $("<td>" + number_format(item.total, 2, ".", "") + "</td>").css({textAlign : "right"});
//                    var tdBodega = $("<td>" + item.bodega.texto + "</td>");
                    var tdObservaciones = $("<td>" + item.observaciones + "</td>");

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
                                            },
                                            "Cancelar" : function () {
                                            }
                                        }
                                    }
                                });
                            });

                    tr.append(tdCantidad);
                    tr.append(tdCodigo);
                    tr.append(tdItem);
                    tr.append(tdPrecioC);
                    tr.append(tdSubtotal);
//                    tr.append(tdObservaciones);
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
//                        var ibd = i.bodega.id;
                        if (iid == item.id /*&& ibd == item.bodega.id*/) {
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
                        }
                        item.edit = false;
                        trOrig.replaceWith(tr);
                    }
                    tr.show("pulsate");
                    reset();
                }

            }
            function search() {
                var search = $("#txtBuscar").val();

                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action: 'buscarItem')}",
                    data    : {
                        search     : search,
                        bodegaSale : $("#bodegaSale").val()
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

                $("#tdItem").removeData("item");

                cantAnt = 0;
                precioAnt = 0;
            }
            function resetBodega() {
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

            function validarNumeros(max) {
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

                var obj = {
                    precio    : precio,
                    cantidad  : cantidad,
                    descuento : descuento
                };
                return obj;
            }

            function validar($target) {
                if (trim($("#txtItem").val()) != "") {
                    var item = $("#tdItem").data("item");
                    var obj = validarNumeros(item.max);
                    var observaciones = $("#txaObservaciones").val();

//                    var bodegaId = $("#bodega").val();
//                    var bodega = $("#bodega option:selected").text();

                    item.cantidad = obj.cantidad;
                    item.precio = obj.precio;
                    item.descuento = obj.descuento;
                    item.observaciones = observaciones;
//                    item.bodega = {id : bodegaId, texto : bodega};

                    var stotal = item.cantidad * item.precio;
                    var desc = stotal * (item.descuento / 100);
                    var total = stotal - desc;

                    item.total = total;

                %{--var pctIva = parseFloat("${iva}") / 100;--}%
//                    var pctIce = item.pctIce;

//                    var iva, ice;
//                    iva = item.conIva * (total * pctIva);
//                    ice = total * pctIce;

                    var totalTodo = total;// + iva + ice;

                    item.totalTodo = totalTodo;
//                    item.iva = iva;
//                    item.ice = ice;

                    $("#tdItem").data("item", item);
                    $("#tdPrecioT").text(number_format(total, 2, ".", "")).css({textAlign : "right"});
//                    $("#txtIva").val(number_format(iva, 2, ".", ""));
//                    $("#txtIce").val(number_format(ice, 2, ".", ""));
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

            function actualizarBodega(tipo) {
                var id;
                switch (tipo.toLowerCase()) {
                    case "sale":
                        id = $("#centroCostosSale").val();
                        break;
                    case "recibe":
                        id = $("#centroCostosRecibe").val();
                        break;
                }
                $("#spBodega" + tipo).html(loading);
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'getBodegaFromCentroCostos')}",
                    data    : {
                        transfer : "${transferenciaInstance.id}",
                        id       : id,
                        tipo     : tipo
                    },
                    success : function (msg) {
                        $("#spBodega" + tipo).html(msg);
                        checkOverlay();
                    }
                });
            }

            function checkOverlay() {
                var cs = $("#centroCostosSale").val();
                var cr = $("#centroCostosRecibe").val();
                var bs = $("#bodegaSale").val();
                var br = $("#bodegaRecibe").val();
                if (cs && cr && bs && br && (bs != br)) {
                    $("#overlay").hide();
                } else {
                    $("#overlay").show();
                }
            }
        </script>

        <meta name="layout" content="main">
        <title>Crear Transferencia</title>
    </head>

    <body>
        <a href="#create-transferencia" class="skip" tabindex="-1">
            <g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
        </a>

        <div id="create-transferencia" class="content scaffold-create" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                </ul>
            </div>

            <div class="contenedor" style="width: 950px; height: 850px">
                <g:form name="form-transferencia" action="save">
                    <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all"
                         id="divErrores">
                        <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
                        <span style="font-weight: bold;" id="spanError">Se encontraron los siguientes errores:</span>

                        <ul id="listaErrores"></ul>
                    </div>
                    <g:if test="${flash.message}">
                        <div class="message ${flash.clase}" role="status"><span
                                class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                        </div>
                    </g:if>
                    <g:hasErrors bean="${transferenciaInstance}">
                        <ul class="errors" role="alert">
                            <g:eachError bean="${transferenciaInstance}" var="error">
                                <li><g:if
                                        test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if><g:message
                                        error="${error}"/></li>
                            </g:eachError>
                        </ul>
                    </g:hasErrors>
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

                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td id="tdItem">
                                        <input type="text" class="ui-widget-content ui-corner-all" id="txtItem"
                                               style="width: 200px;"/>
                                    </td>
                                    <td id="tdCodigo">
                                    </td>
                                    <td id="tdPrecioU">
                                        <input type="number" class="ui-widget-content ui-corner-all updatable" id="txtPrecio"
                                               style="width:50px; text-align:right;"/>
                                    </td>
                                    <td id="tdCantidad">
                                        <input type="number" class="ui-widget-content ui-corner-all updatable" id="txtCantidad"
                                               style="width: 50px; text-align:right;"/>
                                    </td>

                                    <td>
                                        <a href="#" id="btnAdd">Agregar</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <table id="tblItems" border="1" style="border-collapse: collapse; border-color: #555;">
                            <thead>
                                <th width="50">
                                    Cantidad
                                </th>
                                <th width="100">
                                    Código
                                </th>
                                <th width="200">
                                    Item
                                </th>
                                <th width="100">
                                    Precio Unitario
                                </th>
                                <th width="80">
                                    Subtotal

                                </th>
                                %{--<th>--}%
                                %{--Bodega--}%

                                %{--</th>--}%
                                %{--<th width="100">--}%
                                %{--Observaciones--}%

                                %{--</th>--}%

                                <th width="70">
                                    Acciones
                                </th>
                            </thead>
                            <tbody id="tbItems" name="tbItems">
                                <g:if test="${transferenciaInstance.id}">
                                    <g:each in="${cratos.DetalleTransferencia.findAllByTransferencia(transferenciaInstance)}" var="dt">
                                        <g:set var="bodegaSale" value="${transferenciaInstance.bodegaSale}"/>
                                        <g:set var="detalle" value="${cratos.Existencias.findByItemAndBodega(dt.item, bodegaSale).cantidad}"/>
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
                                                max       : parseFloat("${detalle}")
                                            }
                                            item.totalTodo = item.total;
                                            $("#tdItem").data("item", item);
                                            $("#txtItem").val(item.nombre);
                                            $("#tdCodigo").text(item.codigo);
                                            $("#txtPrecio").val(number_format(item.precio, 2, ".", ""));
                                            $("#txtCantidad").val(item.cantidad);
                                            $("#txtDescuento").val(0);
                                            $("#tdPrecioT").text(number_format(item.total, 2, ".", "")).css({textAlign : "right"});
                                            $("#hCantidad").val(parseFloat(item.max));

                                            //                                            $("#txtIva").text(number_format(item.iva, 2, ".", ""));
                                            //                                            $("#txtIce").text(number_format(item.ice, 2, ".", ""));

                                            %{--$("#spIva").text(number_format(parseFloat("${iva/100}") * 100, 2, ".", "") + "%");--}%
                                            %{--$("#spIce").text(number_format(parseFloat(item.pctIce) * 100, 2, ".", "") + "%");--}%

                                            $("#tdTotal").text(number_format(item.totalTodo, 2, ".", ""));

                                            addItem();
                                        </script>
                                    </g:each>
                                </g:if>
                            </tbody>
                        </table>
                    </fieldset>

                    <div class="ui-widget-header buttons botones">
                        <a href="#" id="btnGuardar">Guardar</a>
                    </div>

                    <div id="overlay">
                        <div class="ui-overlay">
                            <div class="ui-widget-overlay">
                            </div>

                            <div style="width: 302px; height: 152px; position: absolute; left: 50px; top: 30px;" class="ui-widget-shadow ui-corner-all">
                            </div>
                        </div>

                        <div class="ui-widget ui-widget-content ui-corner-all" style="position: absolute; width: 280px; height: 130px;left: 50px; top: 30px; padding: 10px;">
                            <p>Seleccione las bodegas para transferir productos</p>
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

                actualizarBodega("Sale");
                actualizarBodega("Recibe");

                $(".centroCostos").change(function () {
                    actualizarBodega($(this).data("tipo"));
                });

                <g:if test="${!transferenciaInstance.id}">
                $("input").not("#txtBuscarOC,#ordenes").val("");
                $("select").attr("selectedIndex", 0);
                reset();
                </g:if>
                <g:else>
                $("#overlay").hide();
                </g:else>

                $("#form-transferencia").validate({
                    errorLabelContainer : "#listaErrores",
                    wrapper             : "li",
                    invalidHandler      : function (form, validator) {
                        var errors = validator.numberOfInvalids();
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
                    rules               : {
                        bodegaRecibe : {
                            notEqualTo : "#bodegaSale",
                            required   : true
                        },
                        bodegaSale   : {
                            notEqualTo : "#bodegaRecibe",
                            required   : true
                        },
                        fecha        : {
                            required : true
                        },
                        verifItems   : {
                            minRows : ["#tbItems tr", 1]
                        }
                    },
                    messages            : {
                        bodegaRecibe : {
                            required   : "Seleccione la bodeda que Recibe",
                            notEqualTo : "Seleccione un valor diferente de la Bodega Sale"
                        },
                        bodegaSale   : {
                            required : "Seleccione la bodega de Salida",

                            notEqualTo : "Seleccione un valor diferente de la Bodega Recibe"
                        },
                        fecha        : {
                            required : "Ingrese una Fecha"
                        }
                    }
                });

                $("#btnAdd").button({
                    icons : {
                        primary : "ui-icon-plusthick"
                    },
                    text  : false
                }).click(function () {
                            addItem();
                        });
                $("#btnGuardar").button({
                    icons : {
                        primary : "ui-icon-disk"
                    }
                }).click(function () {
                            if ($("#form-transferencia").valid()) {
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
                                var id = "${transferenciaInstance.id}"
                                var fecha = $("#fecha").val();
                                var observaciones = ($("#observaciones").val());
                                var bodegaRecibe = $("#bodegaRecibe").val();
                                var bodegaSale = $("#bodegaSale").val();

                                var items = "";

                                var item = "";

                                var msgError = "";

                                $("#tbItems").find("tr").each(function () {
                                    item = $(this).data("item");
                                    var stotal = item.cantidad * item.precio;
                                    var desc = stotal * (item.descuento / 100);
                                    var total = stotal - desc;

                                    items += "&item=" + item.id + "^" + item.cantidad + "^" + item.precio + "^"

                                });

                                var data = "&fecha=" + fecha + "&observaciones=" + observaciones;
                                if (id * 1 > 0) {
                                    data += "&id=" + id
                                }

                                data += "&bodegaRecibe.id=" + bodegaRecibe;
                                data += "&bodegaSale.id=" + bodegaSale;
                                data += items;

                                $.ajax({
                                    type    : "POST",
                                    url     : "${createLink(action: 'save')}",
                                    data    : data,
                                    success : function (msg) {
                                        if (msg != "error") {
                                            window.location.href = "${g.createLink(controller: 'transferencia',action: 'show')}/" + msg
                                        }
                                    }
                                });

                            } else {
//                        console.log("AQUI")
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

                $("#txtItem").focus(function () {
                    $(".selected").removeClass("selected");
                    search();
                    $("#dlgBuscar").dialog("open");
                    return false;
                });

                $(".updatable").blur(function () {
                    validar($(this));
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