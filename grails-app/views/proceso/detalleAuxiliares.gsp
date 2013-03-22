<g:if test="${msn}">
    <div class="errors" style="padding-left: 10px;">
        ${msn}
    </div>
</g:if>
<g:if test="${auxiliares.size() > 0}">
    <g:set var="totalD" value="${0}"/>
    <g:set var="totalH" value="${0}"/>


    <table width="400px" border="1px">
    <thead>

      <tr style="background: #818A91;">
        <th>Descripcion(Tipo documento : # documento)</th>
        <th>Fecha</th>
        <th>Razón</th>
        <th style="width: 120px; text-align: center;">Monto</th>
        <th>Eliminar</th>
        <th style="text-align: center">Pagos</th>
      </tr>
    </thead>
    <tbody style="border:1px solid black">

    <g:set var="val" value="${0}"/>
    <g:set var="valH" value="${0}"/>
    <g:each var="aux" in="${auxiliares}" status="i">
        <tr>
            <td style=";">
                ${aux?.descripcion}
                <input type="hidden" id="hid_${i}" name="idAuxiliares" value="${aux?.id}">
            </td>
            <td>${aux.fechaPago.format("dd/MM/yyyy")}</td>
            <td>${aux.debe != 0 ? "Debe" : "Haber"}</td>
            <td style="text-align: right;">
                <g:formatNumber number="${aux?.debe != 0 ? aux.debe : aux.haber}" minFractionDigits="2" maxFractionDigits="2"/>
            </td>
            <td style="text-align: center;">
                %{--<g:if test="${asiento?.comprobante?.registrado!='R'}">--}%
                <div style="margin:auto;width: 16px;cursor: pointer" class="borrar btnpq ui-state-default ui-corner-all" id="borrar_${i}" idaux="${aux?.id}" posicion="${i}"
                     data-valor="${aux?.debe != 0 ? aux.debe : aux.haber}">
                    <span class="ui-icon ui-icon-circle-close"></span>
                </div>
                %{--</g:if>--}%
            </td>

            <g:set var="valH" value="${valH + aux?.haber ?: 0}"/>
            <td style="text-align: center;">
                <a href="#" class="pagos" id="${aux.id}" max="${aux.haber}"
                   data-fecha="${aux.fechaPago.format("dd-MM-yyyy")}"
                   data-valor="${aux?.debe != 0 ? aux.debe : aux.haber}"
                   data-pagos="${cratos.PagoAux.findAllByAuxiliar(aux).monto.sum() ?: 0}">
                    Pagos
                </a>
            </td>
        </tr>
    </g:each>
    <tr>
        <td>TOTAL:</td>

        <td></td>
        <td></td>
        <td style="background-color: #d0ffd0;text-align: right">
            <g:formatNumber number="${valH}" minFractionDigits="2" maxFractionDigits="2"/>
        </td>
        <td>&nbsp;</td>
    </tr>
    </tbody>
    </tbody>
  </table>

</g:if>


<div id="dlg_pagos">
    <input type="hidden" id="iden_aux">
    <input type="hidden" id="max_aux">
    <fieldset style="width: 730px;height: 450px;" class="ui-corner-all">
        <legend>Pagos</legend>


        <table border="1">
            <tr>
                <td>
                    <label>Pago de:</label>
                </td>
                <td id="tdPago"></td>
                <td>
                    <label>Pagado:</label>
                </td>
                <td id="tdPagado"></td>
                <td>
                    <label>Por pagar:</label>
                </td>
                <td id="tdPagar"></td>
            </tr>
            <tr>
                <td>
                    <label>Gestor contable:</label>
                </td>
                <td>
                    <g:select name="pgo_gestor" from="${cratos.Gestor.findAllByEstado('A')}" id="pgo_gestor" class="required ui-widget-content ui-corner-all" noSelection="['-1': 'Seleccione']" optionKey="id" optionValue="descripcion"/>
                </td>
                <td>
                    <label>Fecha:</label>
                </td>
                <td>
                    <elm:datePicker class="required field ui-corner-all" title="Fecha" name="fecha" id="pgo_fecha" style="width:90px;"/>
                </td>
                <td>
                    <label>Monto:</label>
                </td>
                <td>
                    <input type="text" class="required ui-corner-all" id="pgo_monto" style="width:100px;"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label>Factura:</label>
                </td>
                <td>
                    <input type="text" class="required ui-corner-all" id="pgo_factura" style="width:100px;"/>
                </td>
                <td>
                    <label>Documento:</label>
                </td>
                <td>
                    <g:select id="td" name="tipoDocumento.id" from="${cratos.TipoDocumento.list()}" class="required ui-widget-content ui-corner-all" value="" optionKey="id" optionValue="descripcion" style="width: 120px;"/>
                </td>
                <td>
                    <label>Referencia:</label>
                </td>
                <td>
                    <input type="text" class="required ui-widget-content ui-corner-all" name="referencia" id="ref" style="width: 100px"/>
                </td>
            </tr>
        </table>

        <div class="fieldcontain  " style="margin-top: 0px;">
            <a href="#" id="pgo_save" style="margin-left: 10px">Guardar</a>
        </div>

        <div id="pgo_ajax" style="width: 700px;margin: auto;overflow: auto;height: 380px;margin-top: 10px">
            <img src="${resource(dir: 'images', file: 'loading_bg.gif')}" alt="Cargando...."/>
        </div>
    </fieldset>
</div>

<script type="text/javascript">
    $(function () {

        $(".pagos").button({
            icons : {
                primary : "ui-icon-plusthick"
            },
            text  : false
        }).click(function () {
                    $("#pgo_ajax").html(loading);
                    $("#iden_aux").val($(this).attr("id"));
                    $("#max_aux").val($(this).attr("max"));
                    var data = {
                        max      : parseFloat($(this).data("valor")),
                        pagos    : parseFloat($(this).data("pagos")),
                        restante : parseFloat($(this).data("valor")) - parseFloat($(this).data("pagos")),
                        boton    : $(this)
                    };
                    $("#tdPago").text(number_format(data.max, 2, ".", ""));
                    $("#tdPagado").text(number_format(data.pagos, 2, ".", ""));
                    $("#tdPagar").text(number_format(data.restante, 2, ".", ""));
                    $("#pgo_fecha").val($(this).data("fecha"));

                    $("#pgo_monto").val($(this).data("valor") - $(this).data("pagos"));

                    $("#pgo_save").data(data);

                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(action: 'detallePagos')}",
                        data    : "id=" + $(this).attr("id"),
                        success : function (msg) {
                            $("#pgo_ajax").html(msg).show("slide")
                        }
                    });
                    $("#dlg_pagos").dialog("open");
                });
        $("#dlg_pagos").dialog({
            autoOpen : false,
            width    : 800,
            height   : 600,
            title    : "Pagos",
            modal    : true,
            buttons  : {
                "Cerrar" : function () {
                    $("#dlg_pagos").dialog("close")
                }
            }
        });
        $("#pgo_save").unbind("click")
        $("#pgo_save").bind("click", function () {
            var $btn = $("#pgo_save");
            var errores = "";

            if ($("#pgo_gestor").val() == -1) {
                errores += "<li>Seleccione un gestor</li>";
            }
            if ($.trim($("#pgo_factura").val()) == "") {
                if (errores != "") {
                    errores += "\<br/>";
                }
                errores += "<li>Ingrese el número de factura</li>"
            }
            if ($.trim($("#ref").val()) == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese el número de referencia del documento</li>"
            }
            if (isNaN($("#pgo_monto").val())) {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>El monto del pago debe ser un número válido</li>";
            } else {
                if (parseFloat($.trim($("#pgo_monto").val())) <= 0) {
                    if (errores != "") {
                        errores += "<br/>";
                    }
                    errores += "<li>El monto del pago debe ser mayor que 0</li>";
                }
                if (parseFloat($.trim($("#pgo_monto").val())) > parseFloat($(this).data("restante"))) {
                    if (errores != "") {
                        errores += "<br/>";
                    }
                    errores += "<li>La suma de los pagos no debe exceder " + number_format($(this).data("max"), 2, ".", "") + "<br/>";
                    errores += "&nbsp;&nbsp;&nbsp(valor máximo para este pago: " + number_format($(this).data("restante"), 2, ".", "") + ")</li>";
                }
            }

            if (errores == "") {
                $.box({
                    id         : "loadingPgo",
                    imageClass : "box_loading",
                    text       : "Por favor espere...",
                    title      : "Cargando",
                    iconClose  : false,
                    dialog     : {
                        draggable     : false,
                        resizable     : false,
                        closeOnEscape : false,
                        buttons       : false
                    }
                });
                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(action: 'savePago')}",
                    data    : {
                        "auxiliar.id"      : $("#iden_aux").val(),
                        fecha              : $("#pgo_fecha").val(),
                        monto              : $("#pgo_monto").val(),
                        factura            : $("#pgo_factura").val(),
                        gestor             : $("#pgo_gestor").val(),
                        "tipoDocumento.id" : $("#td").val(),
                        referencia         : $("#ref").val()
                    },
                    success : function (msg) {
                        if (msg == "ok") {
                            $.ajax({
                                type    : "POST",
                                url     : "${g.createLink(action: 'detallePagos')}",
                                data    : "id=" + $("#iden_aux").val(),
                                success : function (msg) {
                                    $("#loadingPgo").dialog("close");
                                    $("#pgo_ajax").html(msg).show("slide");
                                    var monto = parseFloat($.trim($("#pgo_monto").val()));
                                    var pagos = parseFloat($btn.data("pagos")) + monto;
                                    var restante = parseFloat($btn.data("restante")) - monto;
                                    var $boton = $btn.data("boton");
                                    $boton.data("pagos", pagos);
                                    $btn.data("pagos", pagos);
                                    $btn.data("restante", restante);
                                    $("#pgo_monto").val("");
                                    $("#ref").val("");
                                    $("#pgo_factura").val("");
                                    $("#tdPagado").text(number_format(pagos, 2, ".", ""));
                                    $("#tdPagar").text(number_format(restante, 2, ".", ""));
                                }
                            });
                        }

                    }
                });
            } else {
                $.box({
                    imageClass : "box_error",
                    text       : "Por favor corrija lo siguiente:<br/><ul>" + errores + "</ul>",
                    title      : "Error",
                    iconClose  : false,
                    dialog     : {
                        draggable     : false,
                        resizable     : false,
                        closeOnEscape : false,
                        buttons       : {
                            "Aceptar" : function () {
                            }
                        }
                    }
                });
            }

        });
        $("#pgo_save").button({
            icons : {
                primary : "ui-icon-disk"
            }
        });

        $(".borrar").click(function () {

            var resultado = false;
            var id = $(this).attr("idaux");
            var asientoId = $("#idAsiento").val();

            var valor = $(this).data("valor");

            $.ajax({
                type    : "POST",
                url     : "../borrarAuxiliar",
                data    : "id=" + id + "&idAs=" + asientoId,
                success : function (msg) {
                    $("#listaAuxl").html(msg).show("slide");
//
                    var enAux = $("#agregar_axul").data("enAux");
                    var restante = $("#agregar_axul").data("restante");

                    enAux -= valor;
                    restante += valor;

                    $("#agregar_axul").data("enAux", enAux);
                    $("#agregar_axul").data("restante", restante);

                    $("#spAsignado").text(number_format(enAux, 2, ".", ""));
                    $("#spAsignar").text(number_format(restante, 2, ".", ""));
                }
            });
        });

    });
</script>