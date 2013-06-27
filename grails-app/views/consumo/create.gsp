<%@ page import="cratos.Consumo" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'consumo.label', default: 'Consumo')}"/>
    <title>Crear Consumo</title>

    <style type="text/css">
    ul {
        list-style: disc;
        padding-left: 40px;
    }

    .error {
        border: solid 2px #cc0000;
        background: #ccaaaa;
    }

    #listaErrores {
        margin-bottom: 0 !important;
    }
    </style>

</head>

<body>
<a href="#create-consumo" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                default="Skip to content&hellip;"/></a>

<div id="create-consumo" class="content scaffold-create" role="main">
<div class="ui-widget-header ui-corner-all nav navegacion" role="navigation">
    <ul style="margin-bottom:0;">
        <li><g:link class="list linkButton" action="list">Lista</g:link></li>
    </ul>
</div>

<div style="padding: 0.7em; margin-top:5px; display: none;" class="ui-state-error ui-corner-all" id="divErrores">
    <span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
    <span style="font-weight: solid;" id="spanError">Se encontraron los siguientes errores:</span>

    <ul id="listaErrores"></ul>
</div>

<g:form name="form-consumo" action="save">
<div class="contenedor">
<fieldset style="margin: 10px;">
    <legend>Cliente</legend>

    <div class="span-20">
        <div class="span-3">Factura #:</div>

        <div class="span-6">
            <g:if test="${factura.secuencial}">
                ${factura.secuencial}
                <input type="hidden" id="numero" class="" value="${factura.secuencial}" maxlength="15"/>
            </g:if>
            <g:else>
                <input type="text" id="numero" class="required span-6 ui-widget-content ui-corner-all" value=""
                      maxlength="15" style="width: 100px"/>
            </g:else>
        </div>

    </div>

    <div class="span-20">
        <div class="span-3">Cédula/RUC:</div>

        <div class="span-6">
            <g:if test="${factura.proveedor}">
                ${factura.proveedor.ruc}
                <input type="hidden" id="ci" class="" value="${factura.proveedor?.ruc}"/>
            </g:if>
            <g:else>
                <input type="text" id="ci" class="required span-6 ui-widget-content ui-corner-all"
                       value="${factura.proveedor?.ruc}" style="width: 80px"/>
            </g:else>
        </div>

        <div class="span-1">
            <g:if test="${factura.proveedor}">

            </g:if>
            %{--<g:else>--}%
            %{--<a href="#" id="btnBuscar">Buscar</a>--}%
            %{--</g:else>--}%
        </div>
    </div>

    <div class="span-20">
        <g:if test="${factura.proveedor}">
            <div class="span-3 label">
                Nombre:
            </div>

            <div class="span-15 campo">
                ${factura.persona}
                <input type="hidden" id="nombre" class="" value="${factura.persona.split(" ")[0]}"/>
                <input type="hidden" id="apellido" class="" value="${factura.persona.split(" ")[1]}"/>
            </div>
        </g:if>
        <g:else>
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
        </g:else>
    </div>

    <div class="span-20">
        <div class="span-3">
            Dirección:
        </div>

        <div class="span-6">
            <g:if test="${factura.proveedor}">
                ${factura.direccion}
                <input type="hidden" id="direccion" class="" value="${factura.direccion}"/>
            </g:if>
            <g:else>
                <input type="text" id="direccion" class="required span-6 ui-widget-content ui-corner-all"
                       value="${factura.direccion}"/>
            </g:else>
        </div>

        <div class="span-3 prepend-1">
            Teléfono:
        </div>

        <div class="span-6">
            <g:if test="${factura.proveedor}">
                ${factura.telefono}
                <input type="hidden" id="telefono" class="" value="${factura.telefono}"/>
            </g:if>
            <g:else>
                <input type="text" id="telefono" class="required span-6 ui-widget-content ui-corner-all"
                       value="${factura.telefono}"/>
            </g:else>
        </div>
    </div>

    <div class="span-20">
        <div class="span-3">
            Paciente:
        </div>

        <div class="span-16">
            <g:if test="${factura.proveedor}">
                ${factura.paciente}
                <input type="hidden" id="paciente" class="required span-16 ui-widget-content ui-corner-all"
                       value="${factura.paciente}"/>
            </g:if>
            <g:else>
                <input type="text" id="paciente" class="required span-16 ui-widget-content ui-corner-all"
                       value="${factura.paciente}"/>
            </g:else>
        </div>
    </div>
</fieldset>

<g:textField name="verifItems" class="ui-helper-hidden-accessible"/>

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
                <input type="hidden" id="txtId"/>
                <input type="text" class="ui-widget-content ui-corner-all" id="txtItem" style="width: 170px;"/>
            </td>
            <td id="tdCodigo">

            </td>
            <td id="tdPrecioU">
                <input type="number" class="ui-widget-content ui-corner-all updatable" id="txtPrecio"
                       style="width: 75px; text-align:right;"/>
            </td>
            <td id="tdCantidad">
                <input type="number" class="ui-widget-content ui-corner-all updatable" id="txtCantidad"
                       style="width: 75px; text-align:right;"/>
            </td>
            <td id="tdDescuento">
                <input type="number" min="0" max="100" id="txtDescuento"
                       class="ui-widget-content ui-corner-all updatable" value="0"
                       style="width: 36px; text-align:right;"/>%
            </td>
            <td id="tdPrecioT">

            </td>
            <td id="tdObservaciones">
                <textarea id="txaObservaciones" class="ui-widget-content ui-corner-all updatable" rows="10" cols="10"
                          style="width: 150px; height: 19px;"></textarea>
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
</fieldset>
</div>

<div class="ui-widget-header buttons botones">
    <g:link controller="factura" action="show" id="${factura.id}" class="btn">Cancelar</g:link>
    <g:link controller="factura" action="generar" class="btnFactura" id="${factura.id}">Generar factura</g:link>
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

<div id="dlgBuscarCliente" title="Buscar Cliente">

    <div style="height: 40px">
        <input type="text" id="txtBuscarCli" class="span-6 ui-widget-content ui-corner-all"/>
        <span class="span-1">

            <a href="#" id="btnCliente">Buscar Cliente</a>

        </span>

    </div>

    <div id="area2" style="width: 650px; max-height:500px; overflow-y:auto; overflow-x: hidden;">

    </div>

</div>


<script type="text/javascript">

    function updateItems() {
//                tbItems
        var ci = trim($("#ci").val());
        var nombre = trim($("#nombre").val());
        var apellido = trim($("#apellido").val());
        var direccion = trim($("#direccion").val());
        var telefono = trim($("#telefono").val());
        var paciente = trim($("#paciente").val());
        var numero = trim($("#numero").val())
        $.ajax({
            type:"POST",
            url:"${createLink(action: 'saveItem')}",
            data:{
                add:"false",
                factura:"${factura.id}",
                ci:ci,
                nombre:nombre,
                apellido:apellido,
                paciente:paciente,
                direccion:direccion,
                telefono:telefono,
                numero:numero,
                update:false
            },
            success:function (msg) {
                $("#tbItems").html(msg);
            }
        });
    }

    %{--function buscarCedula() {--}%
    %{--var ci = $("#ci").val();--}%
    %{--if (ci.length >= 10) {--}%
    %{--$.ajax({--}%
    %{--type    : "POST",--}%
    %{--url     : "${createLink(controller: 'proveedor', action: 'buscarCedula')}",--}%
    %{--data    : {--}%
    %{--ci : ci--}%
    %{--},--}%
    %{--success : function (msg) {--}%
    %{--var parts = msg.split("&");--}%
    %{--if (parts[0] == "OK") {--}%
    %{--var nombre = parts[1];--}%
    %{--var apellido = parts[2];--}%
    %{--var direccion = parts[3];--}%
    %{--var telefono = parts[4];--}%
    %{--var paciente = nombre + " " + apellido;--}%

    %{--$("#nombre").val(nombre);--}%
    %{--$("#apellido").val(apellido);--}%
    %{--$("#direccion").val(direccion);--}%
    %{--$("#telefono").val(telefono);--}%
    %{--$("#paciente").val(paciente);--}%
    %{--} else {--}%
    %{--$("#divErrores").show();--}%
    %{--$("#listaErrores").html("<ul><li>" + parts[1] + "</li></ul>");--}%
    %{--}--}%
    %{--}--}%
    %{--});--}%
    %{--}--}%
    %{--}--}%


    function buscarCliente() {
        var search = $("#txtBuscarCli").val();

        $.ajax({
            type:"POST",
            url:"${createLink(action: "buscarCliente")}",
            data:{

                search:search
            },
            success:function (msq) {

                $("#area2").html(msq);
            }
        })
    }


    function search() {
        var search = $("#txtBuscar").val();

        $.ajax({
            type:"POST",
            url:"${createLink(controller: 'item', action: 'buscarItem')}",
            data:{
                search:search
            },
            success:function (msg) {
                $("#area").html(msg);
            }
        });
    }

    function reset() {
        $("#txtId").val("");
        $("#txtItem").val("");
        $("#txtDescuento").val(0);
        $("#txtCantidad").val(1);
        $("#txtPrecio").val(0);
        $("#txaObservaciones").val("");
        $("#tdCodigo").text("");
        $("#tdPrecioT").text("");

        $("#tdItem").removeData("item");

        $("#btnAdd").button("option", "icons", {primary:"ui-icon-plusthick"});
    }

    function addItem() {
        if (validar()) {
            var item = $("#tdItem").data("item");

            var ci = trim($("#ci").val());
            var nombre = trim($("#nombre").val());
            var apellido = trim($("#apellido").val());
            var direccion = trim($("#direccion").val());
            var telefono = trim($("#telefono").val());
            var paciente = trim($("#paciente").val());
            var numero = trim($("#numero").val());

            var id
//                    console.log(item.id)
            if (item.id && item.id != "") {
                id = item.id;
//                        console.log("1");
            } else {
                id = $("#txtId").val();
                //console.log("2");
            }

//                    console.log(id);

            $.ajax({
                type:"POST",
                url:"${createLink(action: 'saveItem')}",
                data:{
                    add:"true",
                    factura:"${factura.id}",
                    numero:numero,
                    ci:ci,
                    nombre:nombre,
                    apellido:apellido,
                    paciente:paciente,
                    direccion:direccion,
                    telefono:telefono,
                    item:id,
                    precio:item.precio,
                    consumo:item.consumo,
                    cantidad:item.cantidad,
                    descuento:item.descuento,
                    observaciones:item.observaciones,
                    update:true
                },
                success:function (msg) {
                    $("#tbItems").html(msg);
                    reset();
                }
            });
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
            precio:precio,
            cantidad:cantidad,
            descuento:descuento

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
            $("#tdPrecioT").text(number_format(total, 2, ".", "")).css({textAlign:"right"});

            if (item.precio == 0) {
                $.box({
                    iconClose:false,
                    imageClass:"box_warning",
                    title:"Alerta",
                    text:"El precio unitario del item es 0.",
                    dialog:{
                        resizable:false,
                        buttons:{
                            "Aceptar":function () {
                            }
                        }
                    }
                });
            } else {
                if (total == 0) {
                    $.box({
                        iconClose:false,
                        imageClass:"box_warning",
                        title:"Alerta",
                        text:"El precio total del item es 0.",
                        dialog:{
                            resizable:false,
                            buttons:{
                                "Aceptar":function () {
                                }
                            }
                        }
                    });
                }
            }
            return true;
        } else {
            $.box({
                iconClose:false,
                imageClass:"box_error",
                title:"Error",
                text:"Por favor seleccione un item",
                dialog:{
                    resizable:false,
                    buttons:{
                        "Aceptar":function () {
                        }
                    }
                }
            });
            return false;
        }
    }

    $(function () {

        $(".btn").button();

        $(".btnFactura").button({
            icons:{
                primary:"ui-icon-pencil"
            }
        });

        $("#nombre, #apellido").keyup(function () {
            var nombre = $("#nombre").val();
            var apellido = $("#apellido").val();
            var paciente = nombre + " " + apellido;
            $("#paciente").val(paciente);
        });

        $(".field").qtip();

        $("#form-consumo").validate({
            errorLabelContainer:"#listaErrores",
            wrapper:"li",
            invalidHandler:function (form, validator) {
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
            rules:{
                ci:{
                    required:true,
                    minlength:10,
                    maxlength:13,
                    digits:true
                },
                nombre:{
                    required:true,
                    maxlength:32
                },
                apellido:{
                    required:true,
                    maxlength:32
                },
                direccion:{
                    required:true,
                    maxlength:127
                },
                telefono:{
                    required:true,
                    maxlength:15
                },
                verifItems:{
                    minRows:["#tbItems tr", 1]
                }
            },
            messages:{
                ci:{
                    required:"Ingrese el número de cédula o RUC del cliente",
                    minlength:"Ingrese 10 o 13 dígitos para la cédula o RUC del cliente",
                    maxlength:"Ingrese 10 o 13 dígitos para la cédula o RUC del cliente",
                    digits:"El número de cédula o RUC debe tener únicamente dígitos"
                },
                nombre:{
                    required:"Ingrese el nombre del cliente",
                    maxlength:jQuery.format("El nombre del cliente debe tener hasta {0} caracteres")
                },
                apellido:{
                    required:"Ingrese el apellido del cliente",
                    maxlength:jQuery.format("El apellido del cliente debe tener hasta {0} caracteres")
                },
                direccion:{
                    required:"Ingrese la dirección del cliente",
                    maxlength:jQuery.format("La dirección del cliente debe tener hasta {0} caracteres")
                },
                telefono:{
                    required:"Ingrese el teléfono del cliente",
                    maxlength:jQuery.format("El teléfono del cliente debe tener hasta {0} caracteres")
                }
            }
        });

//                $("input").val("");
        $("select").attr("selectedIndex", 0);
        reset();
        updateItems();

        $("#btnAdd").button({
            icons:{
                primary:"ui-icon-plusthick"
            },
            text:false
        }).click(function () {
                    addItem();
                });

        $(".btnSave").button({
            icons:{
                primary:"ui-icon-check"
            }
        }).click(function () {

                    if ($("#form-consumo").valid()) {
                        var ci = trim($("#ci").val());
                        var nombre = trim($("#nombre").val());
                        var apellido = trim($("#apellido").val());
                        var direccion = trim($("#direccion").val());
                        var telefono = trim($("#telefono").val());

                        $("#divErrores").hide();

                        var data = "ci=" + ci + "&nombre=" + nombre + "&apellido=" + apellido + "&direccion=" + direccion + "&telefono=" + telefono;
                        data += "&factura=${factura.id}";

                        $.ajax({
                            type:"POST",
                            url:"${createLink (action: 'save') }",
                            data:data,
                            success:function (msg) {
                                alert("Datos guardados");
                                //console.log(msg);
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
//                    buscarCedula();
//                    return false;
//                });

        $("#btnItem").button({
            text:false,
            icons:{
                primary:"ui-icon-search"
            }
        }).click(function () {
                    search();
                    return false;
                });

        $("#btnCliente").button({
            text:false,
            icons:{


                primary:"ui-icon-search"
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
            autoOpen:false,
            width:525,
            height:600,
            modal:true
        });

        $("#dlgBuscarCliente").dialog({

            autoOpen:false,
            width:700,
            height:600,
            modal:true


        });

    });
</script>

</body>
</html>
