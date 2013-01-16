<form id="frmSri">
    <div id="area3" style="max-height: 700px; overflow-y: auto; overflow-x: hidden; ">
        <div class="span-8">
            <div class="span-3">
                <label id="tipoComprobanteId">
                    Tipo Comprobante:
                </label>
            </div>

            <div class="span-4">
                <g:select name="tipoComprobanteId" from="${tiposComprobante}" optionKey="id" optionValue="descripcion"
                          id="tcti" style="width: 120px"/>
            </div>
        </div>

        <div class="span-8">
            <div class=" span-3${hasErrors(bean: cratos.Proceso, field: 'fechaEmision', 'error')}">
                <label for="fechaEmision">
                    Fecha Emision
                </label>
            </div>

            <div class="span-4">
                <elm:datePicker class="field ui-corner-all"
                                title="${cratos.Proceso.constraints.fechaEmision.attributes.title}"
                                name="fechaEmision" format="yyyy-MM-dd" style="width: 85px"/>
            </div>
        </div>

        <div class="span-8">
            <div class=" span-3 ${hasErrors(bean: cratos.Proceso, field: 'fechaRegistro', 'error')}">
                <label for="fechaRegistro">
                    Fecha Registro
                </label>
            </div>

            <div class="span-4">
                <elm:datePicker class="field ui-corner-all"
                                title="${cratos.Proceso.constraints.fechaRegistro.attributes.title}"
                                name="fechaRegistro" format="yyyy-MM-dd" style="width: 85px"/>
            </div>
        </div>

        <div class="span-8">
            <div class="span-3 ${hasErrors(bean: cratos.Proceso, field: 'autorizacionSRI', 'error')}">
                <label for="autorizacionSRI">
                    Autorización SRI
                </label>
            </div>

            <div class="span-4">
                <g:textField class="field  ui-corner-all required" id="autorizacionSRI" name="autorizacionSRI"
                             maxlength="10"
                             title="${cratos.Proceso.constraints.autorizacionSRI.attributes.title}"
                             style="width: 100px"/>
            </div>
        </div>

        %{--<div class="span-8">--}%
        %{--<label style="padding-bottom: 20px;padding-left: 50px; font-style: italic;">--}%
        %{--Valor Retenido--}%
        %{--</label>--}%
        %{--</div>--}%

        %{--<div class="span-8">--}%
        %{--<div class="span-3 ${hasErrors(bean: cratos.Proceso, field: 'retencionIvaBienes', 'error')}">--}%
        %{--<label for="retencionIvaBienes">--}%
        %{--Retención IVA Bienes--}%
        %{--</label>--}%
        %{--</div>--}%

        %{--<div class="span-4">--}%
        %{--<g:textField name="retencionIvaBienes" id="retencionIvaBienes" class="field ui-corner-all"--}%
        %{--maxlength="6" title="${cratos.Proceso.constraints.retencionIvaBienes.attributes.title}"--}%
        %{--style="width: 100px"/>--}%
        %{--</div>--}%
        %{--</div>--}%

        %{--<div class="span-8">--}%
        %{--<div class="span-3" ${hasErrors(bean: cratos.Proceso, field: 'retencionIvaServicios', 'error')}>--}%
        %{--<label for="retencionIvaServicios">--}%
        %{--Retención IVA Servicios--}%
        %{--</label>--}%
        %{--</div>--}%

        %{--<div class="span-4">--}%
        %{--<g:textField name="retencionIvaServicios" id="retencionIvaServicios" class="field ui-corner-all"--}%
        %{--maxlength="6" title="${cratos.Proceso.constraints.retencionIvaServicios.attributes.title}"--}%
        %{--style="width: 100px"/>--}%
        %{--</div>--}%
        %{--</div>--}%

        %{--<div class="span-8">--}%
        %{--<div class="span-3" ${hasErrors(bean: cratos.Proceso, field: 'retencionIva', 'error')}>--}%
        %{--<label for="retencionIva">--}%
        %{--Retención IVA 100%--}%
        %{--</label>--}%
        %{--</div>--}%

        %{--<div class="span-4">--}%
        %{--<g:textField name="retencionIva" id="retencionIva" class="field ui-corner-all"--}%
        %{--maxlength="6" title="${cratos.Proceso.constraints.retencionIva.attributes.title}"--}%
        %{--style="width: 100px"/>--}%
        %{--</div>--}%
        %{--</div>--}%



        <div class="span-8">
            <label style="padding-bottom: 20px;padding-left: 20px; font-style: italic;">
                Comprobante de rentenci&oacute;n
            </label>
        </div>

        <div class="span-12">
            <div class="span-3">
                <label>
                    Tipo de retenci&oacute;n
                </label>
            </div>

            <div class="span-6">
                <g:radioGroup values="['N', 'B', 'S']" name="tipoRetencion" value="N" labels="['Ninguna', 'Bienes', 'Servicios']" class='rbt'>
                    ${it.radio} ${it.label}
                </g:radioGroup>
            </div>
        </div>

        <div class="span-12">
            <div class="span-3">
                <label>
                    Número de Serie y Secuencia
                </label>
            </div>

            <div class="span-6">
                <g:textField disabled="disabled" name="rentaSerie1" id="rentaSerie1" maxlength="3" style="width: 35px" class="retencion field ui-corner-all"
                /><g:textField disabled="disabled" name="rentaSerie2" id="rentaSerie2" maxlength="3" style="width: 35px" class="retencion field ui-corner-all"
                /><g:textField disabled="disabled" name="rentaSecuencial" id="rentaSecuencial" maxlength="11" style="width: 80px" class="retencion field ui-corner-all"/>
            </div>
        </div>

        <div class="span-8">
            <div class="span-3">
                <label>
                    Número de Autorización
                </label>
            </div>

            <div class="span-4">
                <g:textField disabled="disabled" name="rentaAutorizacion" id="rentaAutorizacion" style="width: 100px" class="retencion field ui-corner-all"/>
            </div>

        </div>

        <div class="span-8">
            <div class="span-3">
                <label>
                    Fecha Emisión
                </label>
            </div>

            <div class="span-4">
                <elm:datePicker disabled="disabled" name="rentaFechaEmision" id="rentaFechaEmision" class="retencion field ui-corner-all" format="yyyy-MM-dd" style="width: 85px"/>
            </div>
        </div>

        %{--<div class="span-8">--}%
        %{--<label style="padding-bottom: 20px;padding-left: 20px; font-style: italic;">--}%
        %{--Comprobante IVA--}%
        %{--</label>--}%
        %{--</div>--}%

        %{--<div class="span-12">--}%
        %{--<div class="span-3">--}%

        %{--<label>--}%

        %{--Número de Serie y Secuencia--}%
        %{--</label>--}%
        %{--</div>--}%


        %{--<div class="span-6">--}%
        %{--<g:textField name="ivaSerie1" id="ivaSerie1" maxlength="3" style="width: 35px" class="field ui-corner-all"/><g:textField name="ivaSerie2" id="ivaSerie2" maxlength="3" style="width: 35px" class="field ui-corner-all"/><g:textField name="ivaSecuencial" id="ivaSecuencial" maxlength="11" style="width: 80px" class="field ui-corner-all"/>--}%

        %{--</div>--}%

        %{--</div>--}%

        %{--<div class="span-8">--}%

        %{--<div class="span-3">--}%
        %{--<label>--}%

        %{--Número de Autorización--}%
        %{--</label>--}%

        %{--</div>--}%

        %{--<div class="span-4">--}%

        %{--<g:textField name="ivaAutorizacion" id="ivaAutorizacion" style="width: 100px" class="field ui-corner-all"/>--}%

        %{--</div>--}%

        %{--</div>--}%

        %{--<div class="span-8">--}%
        %{--<div class="span-3">--}%

        %{--<label>--}%

        %{--Fecha Emisión--}%

        %{--</label>--}%


        %{--</div>--}%

        %{--<div class="span-4">--}%

        %{--<elm:datePicker name="ivaFechaEmision" id="ivaFechaEmision" class="field ui-corner-all" format="yyyy-MM-dd" style="width: 85px"/>--}%

        %{--</div>--}%


        %{--</div>--}%

        %{--<div class="ui-widget-header buttons">--}%
        %{--<a href="#" class="btnGuardar" style="margin-left: 285px">Guardar</a>--}%
        %{--</div>--}%
    </div>
</form>

<script type="text/javascript">

    $(".rbt").change(function () {
        if ($(this).val() != 'N') {
            $(".retencion").addClass("required");
            $(".retencion").removeAttr("disabled");
        } else {
            $(".retencion").removeClass("required");
            $(".retencion").attr("disabled", true);
        }
    });

    $("#frmSri").validate({
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
        groups              : {
            numeroRetencion : "rentaSerie1 rentaSerie2 rentaSecuencial"
        },
        rules               : {
            rentaSerie1       : {
                required  : function () {
                    return $(".rbt:checked").val() != 'N';
                },
                digits    : true,
                maxlength : 3
            },
            rentaSerie2       : {
                required  : function () {
                    return $(".rbt:checked").val() != 'N';
                },
                digits    : true,
                maxlength : 3
            },
            rentaSecuencial   : {
                required  : function () {
                    return $(".rbt:checked").val() != 'N';
                },
                digits    : true,
                maxlength : 10
            },
            rentaAutorizacion : {
                required : function () {
                    return $(".rbt:checked").val() != 'N';
                }
            },
            rentaFechaEmision : {
                required : function () {
                    return $(".rbt:checked").val() != 'N';
                }
            }
        },
        messages            : {
            autorizacionSRI   : {
                required : "Ingrese el número de autorización del SRI",
                digits   : "El número de factura debe tener únicamente dígitos"
            },
            rentaSerie1       : {
                required : "Ingrese el número de serie del comprobante de retención (dos seriales y un secuencial)",
                digits   : "El número de factura debe tener únicamente dígitos"
            },
            rentaSerie2       : {
                required : "Ingrese el número de serie del comprobante de retención (dos seriales y un secuencial)",
                digits   : "El número de factura debe tener únicamente dígitos"
            },
            rentaSecuencial   : {
                required : "Ingrese el número de serie del comprobante de retención (dos seriales y un secuencial)",
                digits   : "El número de factura debe tener únicamente dígitos"
            },
            rentaAutorizacion : {
                required : "Ingrese el número de autorización del SRI del comprobante de retención",
                digits   : "El número de factura debe tener únicamente dígitos"
            },
            rentaFechaEmision : "Ingrese la fecha del comprobante de retención"
        }
    });
</script>