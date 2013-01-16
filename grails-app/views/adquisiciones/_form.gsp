<%@ page import="cratos.Adquisiciones" %>

<g:hiddenField name="id" value="${adquisicionesInstance?.id}"/>
<g:hiddenField name="version" value="${adquisicionesInstance?.version}"/>


<div class="container span-19" align="left" style="margin-top: 0px;">

    <fieldset style="margin: 30px">
        <legend>Adquisición</legend>

        <div class="fila span-20 ">
            <div class="span-3  ${hasErrors(bean: adquisicionesInstance, field: 'registro', 'error')} ">
                <label for="registroGestor" id="registroLabel">
                    Gestor Contable
                </label>
            </div>

            <div class="span-6">
                <g:select class="field  many-to-one ui-corner-all required" name="gestor.id" id="gestor" maxlenght="15"
                          value="${adquisicionesInstance?.gestor?.id}"
                          title="${Adquisiciones.constraints.gestor.attributes.title}" from="${cratos.Gestor.list([sort: 'nombre'])}" noSelection="${['': '']}" optionKey="id" optionValue="nombre"/>
            </div>

            <div class="span-3 prepend-1 ${hasErrors(bean: adquisicionesInstance, field: 'factura', 'error')}">
                <label for="factura">
                    Factura
                </label>
            </div>

            <div class="span-6">
                <g:textField class="field  ui-corner-all required" name="facturaSerie1" maxlength="3" style="width: 35px"
                             value="${adquisicionesInstance?.facturaSerie1}"
                             title="${Adquisiciones.constraints.facturaSerie1.attributes.title}"/><g:textField class="field  ui-corner-all required" name="facturaSerie2" maxlength="3" style="width: 35px"
                                                                                                               value="${adquisicionesInstance?.facturaSerie2}"
                                                                                                               title="${Adquisiciones.constraints.facturaSerie2.attributes.title}"/><g:textField class="field  ui-corner-all required" name="facturaNumero" maxlength="11" style="width: 80px"
                                                                                                                                                                                                 value="${adquisicionesInstance?.facturaNumero}"
                                                                                                                                                                                                 title="${Adquisiciones.constraints.facturaNumero.attributes.title}"/>
            </div>
        </div>

        <div class="fila span-20">

            <div class="span-3 ${hasErrors(bean: adquisicionesInstance, field: 'fecha', 'error')}">
                <label for="fecha" id="fecha">
                    Fecha
                </label>
            </div>

            <div class="span-6">
                ${new Date().format("dd-MM-yyyy")}
            </div>

            <div class=" span-3 prepend-1${hasErrors(bean: adquisicionesInstance, field: 'fechaPago', 'error')}">
                <label for="fechaPago">
                    Fecha Pago
                </label>
            </div>

            <div class="span-6">
                <elm:datePicker class="field ui-corner-all"
                                title="${Adquisiciones.constraints.fechaPago.attributes.title}"
                                name="fechaPago" format="yyyy-MM-dd" style="width: 80px" value="${adquisicionesInstance.fechaPago}"/>
            </div>
        </div>

        <div class="fila span-20">
            <div class="span-3 ${hasErrors(bean: adquisicionesInstance, field: 'proveedor', 'error')}">
                <label for="proveedor.id">
                    Proveedor
                </label>
            </div>

            <div class="span-6">
                <g:textField name="proveedor.id" id="proveedor" class="field ui-corner-all required" optionValue="nombreContacto" optionKey="id"
                             value="${adquisicionesInstance?.proveedor?.id}" title="${Adquisiciones.constraints.proveedor.attributes.title}"/>
                <g:hiddenField name="proveedorHidden" id="proveedorHidden" class="field ui-corner-all"
                               value="${adquisicionesInstance?.proveedor?.id}"/>
            </div>

            <div class="span-3 prepend-1 ${hasErrors(bean: adquisicionesInstance, field: 'tipoPago', 'error')} required">
                <label for="tipoPago">
                    Tipo Pago
                </label>
            </div>

            <div class="span-6">
                <g:select id="tipoPago" name="tipoPago.id" optionValue="descripcion" from="${cratos.TipoPago.list()}"
                          optionKey="id"
                          value="${adquisicionesInstance?.tipoPago?.id}" class="field  many-to-one ui-corner-all required"
                          title="${Adquisiciones.constraints.tipoPago.attributes.title}" noSelection="['': '']"/>
            </div>

            %{--<div class="span-3 prepend-1 ${hasErrors(bean: adquisicionesInstance, field: 'empresa', 'error')}">--}%
            %{--<label for="empresa">--}%
            %{--Empresa--}%
            %{--</label>--}%
            %{--</div>--}%

            %{--<div class="span-6">--}%
            %{--<input type="text" id="empresa" name="empresa.id" value="${session.empresa.id}" >--}%
            %{--<g:select id="empresa" name="empresa.id" optionValue="nombre" from="${cratos.Empresa.list()}"--}%
            %{--optionKey="id"--}%
            %{--value="${adquisicionesInstance?.empresa?.id}" class="field  many-to-one ui-corner-all required"--}%
            %{--title="${Adquisiciones.constraints.empresa.attributes.title}" noSelection="['': '']"/>--}%

            %{--</div>--}%

        </div>

        <div class="fila span-10">
            <div class="span-3${hasErrors(bean: adquisicionesInstance, field: 'cheque', 'error')} ">
                <label for="cheque" id="chequeLabel" style="display: none">
                    Cheque
                </label>
            </div>

            <div class="span-6">
                <g:textField class="field  ui-corner-all required" id="cheque" name="cheque" maxlength="15"
                             value="${adquisicionesInstance?.cheque}"
                             title="${Adquisiciones.constraints.cheque.attributes.title}" style="display: none"/>
            </div>
        </div>

        <div class="fila span-10">
            <div class="span-3${hasErrors(bean: adquisicionesInstance, field: 'estadoCheque', 'error')} ">
                <label for="estadoCheque" id="estadoChequeLabel" style="display: none">
                    Estado Cheque
                </label>
            </div>

            <div class="span-6">
                <g:select class="field  ui-corner-all required" name="estadoCheque" id="estadoCheque"
                          value="${adquisicionesInstance?.estadoCheque}"
                          title="${Adquisiciones.constraints.estadoCheque.attributes.title}" style="display: none" from="${['1': 'Cobrado', '2': 'No Cobrado']}"
                          optionKey="key" optionValue="value"/>
            </div>
        </div>

        <div class="fila span-20">
            <div class="span-3 ${hasErrors(bean: adquisicionesInstance, field: 'descripcion', 'error')}">
                <label for="descripcion">
                    Descripcion
                </label>
            </div>

            <div class="span-6">
                <g:textField class="field required ui-corner-all" name="descripcion" id="descripcion" maxlength="127" style="width: 350px" title="${Adquisiciones.constraints.descripcion.attributes.title}" value="${adquisicionesInstance?.descripcion}"/>
            </div>
        </div>

        <div class="fila span-20">
            <div class="span-3 ${hasErrors(bean: adquisicionesInstance, field: 'observaciones', 'error')}">
                <label for="observaciones">
                    Observaciones
                </label>
            </div>

            <div class="span-6">
                <g:textField class="field  ui-corner-all" name="observaciones" id="observaciones" maxlength="127" style="width: 350px" title="${Adquisiciones.constraints.observaciones.attributes.title}" value="${adquisicionesInstance?.observaciones}"/>
            </div>
        </div>
    </fieldset>

    <g:if test="${!adquisicionesInstance.id}">
        <script type="text/javascript">

            $("#tipoPago").val('null');
            $("#estadoCheque").val('null');
            $("#proveedor").val('null');

            $("#bodega").val('null');

        </script>
    </g:if>
</div>