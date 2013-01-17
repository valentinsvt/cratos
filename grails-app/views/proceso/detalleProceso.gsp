<g:if test="${comprobantes}">
    <g:set var="totalD" value="${0}"/>
    <g:set var="totalH" value="${0}"/>
    <g:each in="${comprobantes}" var="comp" status="k">

        <g:if test="${comp.registrado != 'S'}">

            <a href="#" class="btn registrar  ui-corner-all" id="reg_${comp?.id}" idComp="${comp?.id}" style="margin-bottom: 10px;">
                Registrar comprobante
            </a>
        </g:if>
        <g:else>
            <a href="#" class="btn ui-corner-all" id="imprimir" iden="${comp?.proceso?.id}" style="margin-bottom: 10px;">
                Imprimir
            </a>
        </g:else>
        <br>

        <div class="etiqueta">Descripción:</div> ${comp?.descripcion}     <br>

        <div class="etiqueta">Fecha:</div> ${comp?.fecha?.format('dd/MM/yyyy')}<br>

        <table width="400px">
        <thead>
          <tr>
            <th ></th>
            <th>&nbsp;</th>
            <th style="width: 140px; text-align: center;">Debe</th>
            <th style="width: 140px; text-align: center;">Haber</th>
            <th>&nbsp;</th>
          </tr>
          <tr style="background: #818A91;">
            <th style="width: 20px;">Auxiliar</th>
            <th>C&oacute;digo(nombre)</th>
            <th style="width: 120px; text-align: center;">Valor</th>
            <th style="width: 120px; text-align: center;">Valor</th>
            <th></th>
          </tr>
        </thead>
        <tbody>

        <g:set var="val" value="${0}"/>
        <g:set var="valH" value="${0}"/>
        <g:each var="asiento" in="${asientos}" status="i">
            <g:set var="aux" value="${asiento.suma()}"/>
            <g:if test="${asiento.comprobante == comp}">
                <tr>
              <td style="width: 40px;"><g:if test="${asiento.cuenta.auxiliar == 'S'}">
                <div style="float: left; margin-left: 15px;" class="auxbtn btnpq ui-state-default ui-corner-all" id="axul_${asiento.cuenta.id}"
                     idAs="${asiento.id}" reg="${comp.registrado}" max="${Math.abs(asiento.debe - asiento.haber)}" aux="${aux ?: 0}"
                     data-debe="${asiento.debe ?: 0}" data-haber="${asiento.haber ?: 0}">
                    <span class="ui-icon ui-icon-circle-plus"></span>
                </div>
            </g:if></td>
                <td>${asiento.cuenta.numero + '(' + asiento.cuenta.descripcion + ')'}
                    <input type="hidden" id="hid_${i}" name="idAsientos" value="${asiento.id}">
                </td>
                <g:if test="${comp.registrado != 'S'}">
                    <td><input type="text" name="valor" id="vald_${i}" style="width: 100px;float: right;text-align: right" value="${asiento.debe ?: 0}"/>
                    </td>
                    <td><input type="text" name="valor" id="valh_${i}" style="width: 100px;float: right;text-align: right" value="${asiento.haber ?: 0}"/>
                    </td></td>
                    <td>
                        <div style="float: left; margin-right: 5px;" class="guardarDatos btnpq ui-state-default ui-corner-all" id="guardar_${i}" posicion="${i}">
                            <span class="ui-icon ui-icon-circle-check"></span>
                        </div>

                    </td>
                </g:if>
                <g:else>
                    <td><input type="text" name="valor" id="vald_${i}" style="width: 100px;float: right;color: black;text-align: right" value="${asiento.debe ?: 0}" disabled/>
                    </td>
                    <td><input type="text" name="valor" id="valh_${i}" style="width: 100px;float: right;color: black;text-align: right" value="${asiento.haber ?: 0}" disabled/>
                    </td></td>
                    <td></td>
                </g:else>
                <g:set var="val" value="${val + asiento.debe ?: 0}"/>
                <g:set var="valH" value="${valH + asiento.haber ?: 0}"/>


                </tr>
            </g:if>
        </g:each>
        <tr>
            <td></td>
            <td>TOTAL COMPROBANTE:</td>

            <td style="background-color: ${(val.toFloat().round(2) == valH.toFloat().round(2)) ? '#d0ffd0' : '#ffd0d0'}; text-align: right">${val.toFloat().round(2)}</td>
            <td style="background-color: ${(val.toFloat().round(2) == valH.toFloat().round(2)) ? '#d0ffd0' : '#ffd0d0'}; text-align: right">${valH.toFloat().round(2)}</td>
            <td>&nbsp;</td>
        </tr>
        </tbody>
          </tbody>
        </table>

        <g:set var="totalD" value="${totalD + val}"/>
        <g:set var="totalH" value="${totalH + valH}"/>
    </g:each>
    <div style="width: 810px; height: 1px;border-top: #000 dotted 2px; margin: 10px;"></div>

    <div style="margin-right:5px;margin-top: -5px; width: 400px;border: #bbb dotted 1px; padding: 5px;float: right; text-align: right;">
        <div style="float: left"><b>TOTAL:</b></div>

        <div style="float: left;width: 155px;text-align: right;margin-left: 5px;background-color: ${(totalD.toFloat().round(2) == totalH.toFloat().round(2)) ? '#d0ffd0' : '#ffd0d0'}"><b>DEBE:&nbsp;</b> ${totalD.toFloat().round(2)}
        </div>

        <div style="float: left;width: 155px;text-align: right;background-color: ${(totalD.toFloat().round(2) == totalH.toFloat().round(2)) ? '#d0ffd0' : '#ffd0d0'}"><b>HABER:&nbsp;</b> ${totalH.toFloat().round(2)}
        </div>

    </div>

    <div id="auxiliares" style="display: none; width: 900px; height: 300px;">
        <input type="hidden" id="idAsiento">

        <div style="width: 900px;">
            <div id="cab" style="display: none">

                <div style="height: 30px;">
                    <div style="width: 145px;float: left">
                        <div class="etiqueta">Asiento <span class="spRazon"></span>:</div>
                        <span id="spAsiento"></span>
                    </div>

                    <div style="width: 145px;float: left; margin-left: 10px;">
                        <div class="etiqueta">Registrado:</div>
                        <span id="spAsignado"></span>
                    </div>

                    <div style="width: 145px;float: left; margin-left: 10px;">
                        <div class="etiqueta">Por registrar:</div>
                        <span id="spAsignar"></span>
                    </div>
                </div>

                <div id="contenido" style="width: 870px;">
                    <div class="etiqueta">Descripción:</div>
                    <textarea style="width: 700px;height: 40px;" name="descripcionAux" class="ui-corner-all"></textarea> <br>
                    <g:if test="${proceso?.proveedor == null}">
                        <div class="etiqueta">Proveedor:</div>  <g:select id="pr" name="proveedor.id" from="${cratos.Proveedor.list()}" label=" Proveedor: " value="" optionKey="id"></g:select><br>
                    </g:if>
                </div>

                %{--<div class="span-4" style="float: left;">--}%
                %{--<div class="etiqueta">Documento:</div><g:select id="td" name="tipoDocumento.id" from="${cratos.TipoDocumento.list()}" value="" optionKey="id" optionValue="descripcion" style="width: 120px;"></g:select>  <br>--}%
                %{--</div>--}%

                <div class="span-4" style="float: left;">
                    <div class="etiqueta">Fecha de pago:</div><elm:datePicker class="field ui-corner-all" title="Fecha" name="fecha" id="axlr_fecha" style="width:100px;"/>  <br>
                </div>
                %{--<div style="width: 145px;float: left;margin-left: -10px">--}%
                %{--<div class="etiqueta">Factura:</div> <input type="text" class=" ui-widget-content ui-corner-all" name="factura" id="fac" style="width: 60px"> <br>--}%
                %{--</div>--}%
                %{--<div  style="width: 145px;float: left">--}%

                %{--<div class="span-3" style="float: left;">--}%
                %{--<div class="etiqueta">Referencia:</div>  <br><input type="text" class=" ui-widget-content ui-corner-all" name="referencia" id="ref" style="width: 80px">--}%
                %{--</div>--}%

            </div>

            <div style="width: 420px;float: left;">
                <div style="width: 145px;float: left">
                    <div class="etiqueta">Valor <span class="spRazon"></span>:</div>
                    <input type="text" class=" ui-widget-content ui-corner-all" name="valor" id="valor" style="width: 60px">
                </div>

                %{--<div class="bs" style="margin-top: 20px;float: left;width: 150px; " id="divRazon">--}%
                %{--<input type="radio" class="chk" name="tipo" id="radio1" value="D" checked><label style="" for="radio1">Debe</label>--}%
                %{--<input type="radio" class="chk" name="tipo" id="radio2" value="H"><label style="" for="radio2">Haber</label>--}%
                %{--</div>--}%

                <div style="float: left;width: 70px; text-align: center;margin-top: 20px;margin-left: 0px;cursor: pointer;height: 20px;padding-top: 5px" class="agregarCuenta fg-button ui-state-default  ui-corner-all " id="agregar_axul">Agregar</div>
            </div>
        </div>

        <div style="width: 900px;margin-top: 25px;float: left;margin-bottom: 15px;">
            <fieldset style="width: 880px;border: #FF8010 solid 1px">
                <legend>Auxiliares:</legend>

                <div id="listaAuxl" style="width:870px;">
                    <img src="${resource(dir: 'images', file: 'loading_bg.gif')}" alt="Cargando...."/>
                </div>
            </fieldset>
        </div>
    </div>
    </div>
</g:if>

<script type="text/javascript">
    var urlLoading = "${resource(dir: 'images', file: 'loading_bg.gif')}";
    var loading = $('<img src="' + urlLoading + '" alt="Cargando...."/>');
    $(function () {
        $(".btn").button()

        $("#imprimir").click(function(){

            var url = "${g.createLink(controller: 'reportes',action: 'comprobante')}/"+$(this).attr("iden")
            location.href="${g.createLink(controller: 'pdf',action: 'pdfLink')}?url="+url

        }) ;


        $(".guardarDatos").click(function () {
            var vd = $("#vald_" + $(this).attr("posicion")).val()
            if (isNaN(vd))
                vd = 0
            var vh = $("#valh_" + $(this).attr("posicion")).val()
            if (isNaN(vd))
                vd = 0

            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'proceso',action: 'valorAsiento')}",
                data    : "proceso=" + $("#idProceso").val() + "&vd=" + vd + "&vh=" + vh + "&id=" + $("#hid_" + $(this).attr("posicion")).val(),
                success : function (msg) {
                    $("#registro").html(msg).show("slide");
                    location.reload(true);
                }
            });
        });
        $(".registrar").click(function () {
            var id = $(this).attr("idComp")
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'proceso',action: 'registrarComprobante')}",
                data    : "id=" + id,
                success : function (msg) {
                    $("#registro").html(msg).show("slide");
                    location.reload(true)
                }
            });
        });
        function cargarAuxiliares() {
            $("#listaAuxl").html(loading);
            var id = $("#idAsiento").val();
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'proceso',action: 'cargarAuxiliares')}",
                data    : "id=" + id,
                success : function (msg) {
                    $("#listaAuxl").html(msg).show("slide", 500);
                }
            });
        }

        $("#auxiliares").dialog({
            autoOpen  : false,
            resizable : false,
            title     : 'Auxiliares',
            modal     : true,
            draggable : false,
            width     : 940,
            position  : 'center',
            open      : function (event, ui) {
                $(".ui-dialog-titlebar-close").hide();
            },
            buttons   : {
                "Cerrar" : function () {
                    $(this).dialog("close");
                }
            }
        });

        $(".auxbtn").click(function () {
            var data = {};
            data.max = parseFloat($(this).attr("max"));
            data.enAux = parseFloat($(this).attr("aux"));
            data.restante = data.max - data.enAux;

            if ($(this).data("debe") != 0) {
                $(".spRazon").text("Debe");
                $("#spAsiento").text(number_format($(this).data("debe"), 2, ".", ""));
            } else {
                $(".spRazon").text("Haber");
                $("#spAsiento").text(number_format($(this).data("haber"), 2, ".", ""));
            }
            $("#spAsignado").text(number_format(data.enAux, 2, ".", ""));
            $("#spAsignar").text(number_format(data.restante, 2, ".", ""));

            $("#agregar_axul").data(data);

            var id = $(this).attr("idAs");
            $("#idAsiento").val(id);
            $("#cab").show();

            cargarAuxiliares();
            $("#auxiliares").dialog("open");
        });
        $("#agregar_axul").click(function () {
            var $btn = $(this);
            var btnRestante = $btn.data("restante");
            var btnMax = $btn.data("max");
            var btnEnAux = $btn.data("enAux");
            var errores = "";
            var valor = $.trim($("#valor").val());
            var asientoId = $("#idAsiento").val();
            var td = $("#td option:selected").val();
            var referencia = $.trim($("#ref").val());
            var razon;
            if ($(".auxbtn").data("debe") != 0)
                razon = "D";
            else
                razon = "H";
            var des = $.trim($("[name=descripcionAux]").val());
            var pro = $("#pr option:selected").val();
            var fecha = $.trim($("#axlr_fecha").val());
            if (pro == undefined) {
                pro = "-1";
            }

            if (des == "") {
                errores += "<li>Ingrese la descripción</li>";
            }
            if (fecha == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese la fecha</li>";
            }
            if (valor == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese el valor</li>";
            }
            if (btnRestante == 0 || btnMax == btnEnAux) {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ya ha ingresado el valor total de este asiento.</li>"
            } else if (parseFloat(valor) > btnRestante) {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ha sobrepasado el valor límite. La sumatoria de los auxiliares no debe exceder " + number_format(btnMax, 2, ".", "");
                errores += "<br/>&nbsp;&nbsp;&nbsp(Valor máximo para este auxiliar: " + number_format(btnRestante, 2, ".", "") + ")</li>";
            }

            if (isNaN(valor)) {
                valor = 0;
            }

            if (parseFloat(valor) <= 0) {
                if (errores != "") {
                    errores += "\n";
                }
                errores += "<li>Ingrese un valor superior a 0</li>";
            }

            if (errores == "") {
                $.box({
                    id         : "loadingAux",
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
                    url     : "${g.createLink(controller: 'proceso',action: 'nuevoAuxiliar')}",
                    data    : "asiento.id=" + asientoId + "&tipoDocumento.id=" + td + "&valor=" + valor + "&razon=" + razon + "&descripcion=" + des + "&proceso=" + $("#idProceso").val() + "&proveedor.id=" + pro + "&fechaPago=" + fecha + "&referencia=" + referencia,
                    success : function (msg) {
                        $("#loadingAux").dialog("close");
                        $("#listaAuxl").html("");
                        $("#listaAuxl").html(msg).show("slide", 700);
                        $("#td option:first").attr("selected", "selected");
                        $("#valor").val("");
                        $('input[name=tipo]').attr('checked', true);
                        $("[name=descripcionAux]").val("");
                        $("#pr option:first").attr("selected", true);
                        $("#axlr_fecha").val("");
                        $btn.data("enAux", btnEnAux + parseFloat(valor));
                        $btn.data("restante", btnRestante - parseFloat(valor));

                        $("#spAsignado").text(number_format($btn.data("enAux"), 2, ".", ""));
                        $("#spAsignar").text(number_format($btn.data("restante"), 2, ".", ""));
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
        $(".bs").buttonset();
    });
</script>