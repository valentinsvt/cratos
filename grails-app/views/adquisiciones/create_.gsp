<%@ page import="cratos.Adquisiciones" %>
<!doctype html>
<html>
    <head>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
        <link type="text/css" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" rel="stylesheet"/>

        <style type="text/css">

        .hover {
            background : #ffd125 !important;
            cursor     : pointer;
        }

        .selected {
            border     : #FF8010 solid 2px !important;
            background : #F7E7D9 !important;
        }
        </style>

        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'adquisiciones.label', default: 'Adquisiciones')}"/>
        <title>Crear Adquisiciones</title>
    </head>

    <body>
        <a href="#create-adquisiciones" class="skip" tabindex="-1">
            <g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
        </a>

        <div id="create-adquisiciones" class="content scaffold-create" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                </ul>
            </div>
            <g:form name="form-adquisiciones" action="save">

                <div class="contenedor" style="width: 950px; height: 800px">

                <div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all" id="divErrores">
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
                <g:render template="form"/>

            </g:form>


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
                        <td class="label" style="display: none">
                            Precio unitario
                        </td>
                        <td class="label">
                            Cantidad
                        </td>
                        <td class="label">
                            Precio total
                        </td>
                        <td class="label" width="190">
                            Observaciones
                        </td>
                        <td></td>
                    </tr>

                    <tr>
                        <td id="tdItem">
                            <input type="text" class="ui-widget-content ui-corner-all" id="txtItem" style="width: 290px;"/>
                        </td>
                        <td id="tdCodigo">

                        </td>
                        <td id="tdPrecioU" style="display: none">
                            <input type="number" class="ui-widget-content ui-corner-all updatable" id="txtPrecio"
                                   style="width:75px; display: none; text-align:right;"/>
                        </td>
                        <td id="tdCantidad">
                            <input type="number" class="ui-widget-content ui-corner-all updatable" id="txtCantidad"
                                   style="width: 75px; text-align:right;"/>
                        </td>
                        <td id="tdPrecioT">
                        </td>
                        <td id="tdObservaciones">
                            <textarea id="txaObservaciones" class="ui-widget-content ui-corner-all updatable" rows="10"
                                      cols="10" style="width: 180px; height: 19px; resize: none"></textarea>
                        </td>


                        <td>
                            <a href="#" id="btnAdd">Agregar</a>
                        </td>
                    </tr>
                </table>
                <g:textField name="verifItems" class="ui-helper-hidden-accessible"/>
                <table id="tblItems" border="1" style="border-collapse: collapse;">
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
                        <th width="200">
                            Observaciones
                        </th>
                        <th width="70">
                            Acciones
                        </th>
                    </thead>
                    <tbody id="tbItems" name="tbItems">

                    </tbody>
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
                        <th>TOTAL</th>
                        <td id="tdTotalFin" style="text-align: right;">0.00</td>
                    </tr>
                </table>
            </fieldset>


            <div class="ui-widget-header buttons botones">

                %{--<a href="#" class="btnGuardar">Guardar</a>--}%

                <g:actionSubmit value="Continuar" class="btnContinuar"/>


                %{--<g:actionSubmit class="save" action="save" value="Guardar"/>--}%
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


        <script type="text/javascript">

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
                $("#txtCantidad").val(1);
                $("#txtPrecio").val(0);
                $("#txaObservaciones").val("");
                $("#tdCodigo").text("");
                $("#tdPrecioT").text("");
                $("#tdAcciones").text("");

                $("#tdItem").removeData("item");


            }

            function addItem() {
                if (validar()) {
                    var item = $("#tdItem").data("item");

                    var tr = $("<tr>");
                    tr.data("item", item);

                    var tdCantidad = $("<td>" + number_format(item.cantidad, ".", "") + "</td>").css({textAlign : "right"});
                    var tdCodigo = $("<td>" + item.codigo + "</td>");
                    var tdItem = $("<td>" + item.nombre + "</td>");
                    var tdPrecioC = $("<td>" + number_format(item.precio, 2, ".", "") + "</td>").css({textAlign : "right"});
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
                                $("#tdPrecioT").text(number_format(item.total, 2, ".", "")).css({textAlign : "right"});
                                $("#txaObservaciones").val(item.observaciones);
                            });
                    btnDelete.button({
                        text  : false,
                        icons : {
                            primary : "ui-icon-trash"
                        }
                    }).css({
                                width  : 15,
                                height : 15

                            }).click(function () {
                                if (confirm("Estas seguro que desea eliminar este item?")) {

                                    tr.remove();

                                }

                                calcularTotales();
                            });


                    tr.append(tdCantidad);
                    tr.append(tdCodigo);
                    tr.append(tdItem);
                    tr.append(tdPrecioC);
                    tr.append(tdSubtotal);
                    tr.append(tdObservaciones);
                    tr.append(tdAcciones);

                    tdAcciones.append(btnEdit);
                    tdAcciones.append(btnDelete);


                    var trOrig, band = false;

                    var cont = item.cantidad;
                    var c = 0;

//            var descuento = item.descuento;
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

                                obs += ' ' + i.observaciones;
                            }
                        }
                    });

                    if (!band) {
                        $("#tbItems").prepend(tr);
                    } else {

                        if (!item.edit) {
                            total = (item.precio * cont);

                            item.cantidad = cont;
//                    item.descuento = descuento;
                            item.observaciones = obs;


                            tdCantidad.text(number_format(cont, 2, ".", ""));
//                    tdDescuento.text(number_format(descuento, 2, ".", ""));
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
                var iva1 = 0;
                var total1 = 0;

                $("#tbItems").find("tr").each(function () {
                    var item = $(this).data("item");

                    subtotal += (item.precio * item.cantidad);
                    descuentos += ((item.precio * item.cantidad) * (item.descuento / 100));
                });

                iva1 = subtotal * pctIva;

                total1 = subtotal - descuentos + iva1;


                $("#tdSubtotalFin").text(number_format(subtotal, 2, ".", "")).data("val", subtotal);
                $("#tdIva12Fin").text(number_format(iva12, 2, ".", "")).data("val", iva12);
                $("#tdIva0Fin").text(number_format(iva0, 2, ".", "")).data("val", iva0);
                $("#tdIvaFin").text(number_format(iva1, 2, ".", "")).data("val", iva1);
                $("#tdTotalFin").text(number_format(total1, 2, ".", "")).data("val", total1);
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

            //validar

            $(function () {

                $("#form-adquisiciones").validate({
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
                        gestor       : {
                            required : true
                        },
                        factura      : {
                            required  : true,
                            maxlength : 15,
                            digits    : true
                        },
                        proveedor    : {
                            required : true
                        },
                        empresa      : {
                            required : true
                        },
                        tipoPago     : {

                            required : true
//
                        },
                        cheque       : {
                            required  : function (element) {
                                return $("#tipoPago").val() == "2";
                            },
                            maxlength : 15

                        },
                        estadoCheque : {
                            required : function (element) {
                                return $("#tipoPago").val() == "2";
                            }

                        },
//                registro    : {
//                    required  : true
//
//                },
//
                        verifItems   : {
                            minRows : ["#tbItems tr", 1]
                        }



                    },
                    messages            : {
                        gestor       : {
                            required : "Seleccione un gestor para la factura"
                        },
                        factura      : {
                            required  : "Ingrese el número de factura",
                            maxlength : jQuery.format("El número de factura debe tener máximo hasta {0} caracteres"),
                            digits    : "El número de factura debe tener únicamente dígitos"
                        },
                        proveedor    : {
                            required : "Seleccione un proveedor"
                        },
                        empresa      : {
                            required : "Seleccione una empresa"
                        },
                        tipoPago     : {
                            required : "Ingrese el tipo de pago"
                        },
                        cheque       : {
                            required  : "Ingrese el número del cheque",
                            maxlength : jQuery.format("El número del cheque debe tener máximo hasta {0} caracteres")

                        },
                        estadoCheque : {
                            required : "Ingrese el estado del cheque"

                        }
//                registro    : {
//                    required  : "Ingrese el estado del registro"
//
//                }

                    }
                });
            });


            //salvar


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


                $(".btnContinuar").button ({



                });


                //guardar

                $(".btnGuardar").button({
                    icons : {
                        primary : "ui-icon-check"
                    }
                }).click(function () {
                            $("#form-adquisiciones").valid();

//                    $(".error").removeClass("error");

                            var proveedor = $("#proveedor").val();
                            var factura = trim($("#factura").val());
                            var empresa = $("#empresa").val();
//                    var bodega = $("#bodega").val();
                            var tipoPago = $("#tipoPago").val();
                            var fecha = "${new Date().format('yyyy-MM-dd')}";
                            var fechaPago = $("#fechaPago").val();
                            var observaciones = trim($("#observaciones").val());
                            var estadoCheque = $("#estadoCheque").val();
                            var registro = $("#registro").val();
                            var cheque = $("#cheque").val();
                            var gestorContable = $("#gestor").val();

                            var items = "";

                            var item = "";
                            var msgError = "";
                            var id="${adquisicionesInstance?.id}"
                            $("#tbItems").find("tr").each(function () {

                                item = $(this).data("item");
                                var stotal = item.cantidad * item.precio;
                                var desc = stotal * (item.descuento / 100);
                                var total = stotal - desc;

                                items += "&item=" + item.id + "^" + item.cantidad + "^" + item.precio + "^" + item.descuento + "^" + item.conIva
                            });

                            var data = "factura=" + factura + "&fecha=" + fecha + "&fechaPago=" + fechaPago + "&observaciones=" + observaciones + "&cheque=" + cheque;
                            if(id*1>0){
                                data+="&id="+id;
                            }
                            data += "&proveedor.id=" + proveedor;
                            data += "&tipoPago.id=" + tipoPago;
                            data += "&bodega.id=" + bodega;
                            data += "&empresa.id=" + empresa;
                            data += "&estadoCheque=" + estadoCheque;
                            data += "&registro=" + registro;
                            data += "&subtotal=" + $("#tdSubtotalFin").data("val");
                            data += "&iva1=" + $("#tdIva12Fin").data("val");
                            data += "&iva0=" + $("#tdIvaFin").data("val");
                            data += "&total=" + $("#tdTotalFin").data("val");
                            data += "&gestor.id=" + $("#gestor").val()

                            data += items;
                            data += "&iva=" + $("#tdIvaFin").data("val");

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

//                    }

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


                $("#tipoPago").change(function () {
                    if ($(this).val() == 2) {
                        $("#cheque").show();
                        $("#chequeLabel").show();
                        $("#estadoCheque").show();
                        $("#estadoChequeLabel").show();
                    } else {
                        $("#cheque").hide();
                        $("#chequeLabel").hide();
                        $("#estadoCheque").hide();
                        $("#estadoChequeLabel").hide();
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
