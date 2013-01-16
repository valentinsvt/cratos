<%@ page import="cratos.Empresa" %>
<style type="text/css">
label {
    padding-top : 6px;
}
</style>

<div class="container span-15 prepend-1">

    <div class="fila span-15">
        <div class="span-15 ${hasErrors(bean: empresaInstance, field: 'nombre', 'error')} required">
            <div class="span-3">
                <label for="nombre">
                    Nombre
                </label>

            </div>

            <div class="span-9">
                <g:textField class="field  ui-corner-all required" name="nombre" id="nombre"
                             maxlength="63" style="width: 300px" value="${empresaInstance?.nombre}"/>

            </div>

        </div>

    </div>

    <div class="fila span-15">
        <div class="span-15 ${hasErrors(bean: empresaInstance, field: 'ruc', 'error')} required ">
            <div class="span-3">
                <label for="ruc">
                    RUC
                </label>
            </div>

            <div class="span-6">
                <g:textField class="field  ui-corner-all required" name="ruc" id="ruc" maxlength="13"
                             style="width: 100px"
                             value="${empresaInstance?.ruc}"/>

            </div>
        </div>
    </div>

    <div class="fila span-15">
        <div class="span-15 ${hasErrors(bean: empresaInstance, field: 'direccion', 'error')}required">
            <div class="span-3">
                <label for="direccion">
                    Dirección
                </label>
            </div>

            <div class="span-6">

                <g:textField class="field  ui-corner-all" name="direccion" id="direccion" maxlength="127"
                             style="width: 450px"
                             value="${empresaInstance?.direccion}"
                             title="${Empresa.constraints.direccion.attributes.title}"/>

            </div>
        </div>
    </div>

    <div class="span-15 ${hasErrors(bean: empresaInstance, field: 'telefono', 'error')}">
        <div class="span-3">
            <label for="telefono">
                Teléfono
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  ui-corner-all" name="telefono" maxlength="63" style="width: 450px"
                         value="${empresaInstance?.telefono}" title="${Empresa.constraints.telefono.attributes.title}"/>

        </div>
    </div>

    <div class="span-15 ${hasErrors(bean: empresaInstance, field: 'email', 'error')} ">
        <div class="span-3">
            <label for="email">
                E-mail
            </label>
        </div>

        <div class="span-6">
            <g:field class="field email  ui-corner-all" type="email" name="email" maxlength="63" style="width: 300px"
                     value="${empresaInstance?.email}" title="${Empresa.constraints.email.attributes.title}"/>

        </div>
    </div>

    <div class="span-15 ${hasErrors(bean: empresaInstance, field: 'tipoEmpresa', 'error')} required">
        <div class="span-3">
            <label for="tipoEmpresa">
                Tipo de Empresa
            </label>
        </div>

        <div class="span-6">
            <g:select id="tipoEmpresa" name="tipoEmpresa.id" from="${cratos.TipoEmpresa.list()}"
                      optionKey="id" value="${empresaInstance?.tipoEmpresa?.id}"
                      class="field  many-to-one ui-corner-all required"
                      noSelection="['': '']"/>

        </div>
    </div>

    <div class="span-15 ${hasErrors(bean: empresaInstance, field: 'canton', 'error')} ">
        <div class="span-3">
            <label for="canton">
                Cantón
            </label>
        </div>

        <div class="span-6">
            <g:select id="canton" name="canton.id" from="${cratos.Canton.list()}" optionKey="id" optionValue="nombre"
                      value="${empresaInstance?.canton?.id}" class="field  many-to-one ui-corner-all"
                      title="${Empresa.constraints.canton.attributes.title}" noSelection="['null': '']"/>

        </div>
    </div>

    <div class="span-15 ${hasErrors(bean: empresaInstance, field: 'sigla', 'error')} ">
        <div class="span-3">
            <label for="sigla">
                Sigla
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  ui-corner-all" name="sigla" style="width: 60px" maxlength="8"
                         value="${empresaInstance?.sigla}" title="${Empresa.constraints.sigla.attributes.title}"/>

        </div>
    </div>

    <div class="span-15 ">
        <div class="span-5">
            <label for="sigla">
                Prefijo comprobante de diario
            </label>
        </div>

        <div class="span-8">
            <g:textField class="field  ui-corner-all" name="prefijoDiario" style="width: 60px" maxlength="8"
                         value="${empresaInstance?.prefijoDiario}" title="Prefijo de la númeracion de los comprobantes"/>
            Incio Secuencial:
            <g:textField class="field  ui-corner-all digits required" name="numeroComprobanteDiario" style="width: 60px" maxlength="8"
                         value="${empresaInstance?.numeroComprobanteDiario}"/>

        </div>
    </div>

    <div class="span-15  ">
        <div class="span-5">
            <label for="sigla">
                Prefijo comprobante de egreso
            </label>
        </div>

        <div class="span-8">
            <g:textField class="field  ui-corner-all" name="prefijoEgreso" style="width: 60px" maxlength="8"
                         value="${empresaInstance?.prefijoEgreso}" title="Prefijo de la númeracion de los comprobantes"/>
            Incio Secuencial:
            <g:textField class="field  ui-corner-all digits required" name="numeroComprobanteEgreso" style="width: 60px" maxlength="8"
                         value="${empresaInstance?.numeroComprobanteEgreso}"/>

        </div>
    </div>

    <div class="span-15 ">
        <div class="span-5">
            <label for="sigla">
                Prefijo comprobante de ingreso
            </label>
        </div>

        <div class="span-8">
            <g:textField class="field  ui-corner-all" name="prefijoIngreso" style="width: 60px" maxlength="8"
                         value="${empresaInstance?.prefijoIngreso}" title="Prefijo de la númeracion de los comprobantes"/>
            Incio Secuencial:
            <g:textField class="field  ui-corner-all digits required" name="numeroComprobanteIngreso" style="width: 60px" maxlength="8"
                         value="${empresaInstance?.numeroComprobanteIngreso}"/>

        </div>
    </div>

    <div class="span-15 ">
        <div class="span-5">
            <label for="sigla">
                Utiliza ordenes de compra
            </label>
        </div>

        <div class="span-8">
            <g:radioGroup name="ordenCompra" values="[0, 1]" value="1" labels="['No', 'Sí']">
                ${it.label} ${it.radio}
            </g:radioGroup>
        </div>
    </div>

    <div class="span-15 ${hasErrors(bean: empresaInstance, field: 'fechaInicio', 'error')} ">
        <div class="span-3">
            <label for="fechaInicio">
                Fecha Inicio
            </label>
        </div>

        <div class="span-6">
            <elm:datePicker title="${Empresa.constraints.fechaInicio.attributes.title}" name="fechaInicio"
                            style="width: 80px" title="fechaInicio" class="field ui-corner-all"
                            value="${empresaInstance?.fechaInicio}"/>

        </div>
    </div>

    <div class="span-15 ${hasErrors(bean: empresaInstance, field: 'fechaFin', 'error')} ">
        <div class="span-3">
            <label for="fechaFin">
                Fecha Fin
            </label>
        </div>

        <div class="span-6">
            <elm:datePicker title="${Empresa.constraints.fechaFin.attributes.title}" name="fechaFin" title="fechaFin"
                            precision="day" style="width: 80px" class="field ui-corner-all"
                            value="${empresaInstance?.fechaFin}"/>

        </div>
    </div>

</div>