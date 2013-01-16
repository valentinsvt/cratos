<%@ page import="cratos.OrdenCompra" %>

<div class="fieldcontain ${hasErrors(bean: ordenCompraInstance, field: 'centroCosto', 'error')} required">
    <label for="centroCosto">
        <g:message code="ordenCompra.centroCosto.label" default="Centro Costo"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="centroCosto" name="centroCosto.id" from="${cratos.CentroCosto.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required" value="${ordenCompraInstance?.centroCosto?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: ordenCompraInstance, field: 'descripcion', 'error')} required">
    <label for="descripcion">
        <g:message code="ordenCompra.descripcion.label" default="Descripcion"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="descripcion" maxlength="127" class="field ui-widget-content ui-corner-all required" value="${ordenCompraInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: ordenCompraInstance, field: 'valor', 'error')} required">
    <label for="valor">
        <g:message code="ordenCompra.valor.label" default="Valor"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field type="number" name="valor" class="field ui-widget-content ui-corner-all required" value="${fieldValue(bean: ordenCompraInstance, field: 'valor')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: ordenCompraInstance, field: 'fecha', 'error')} required">
    <label for="fecha">
        <g:message code="ordenCompra.fecha.label" default="Fecha"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="fecha" class="field datepicker ui-widget-content ui-corner-all required" value="${ordenCompraInstance?.fecha}"/>
    <script type="text/javascript">
        $("#fecha").datepicker({
            changeMonth     : true,
            changeYear      : true,
            showOn          : "both",
            buttonImage     : "${resource(dir:'images', file:'calendar.png')}",
            buttonImageOnly : true
        });
    </script>
</div>

<div class="fieldcontain ${hasErrors(bean: ordenCompraInstance, field: 'estado', 'error')} ">
    <label for="estado">
        <g:message code="ordenCompra.estado.label" default="Estado"/>

    </label>
    <g:textField name="estado" class="field ui-widget-content ui-corner-all" value="${ordenCompraInstance?.estado}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: ordenCompraInstance, field: 'observaciones', 'error')} ">
    <label for="observaciones">
        <g:message code="ordenCompra.observaciones.label" default="Observaciones"/>

    </label>
    <g:textField name="observaciones" class="field ui-widget-content ui-corner-all" value="${ordenCompraInstance?.observaciones}"/>
</div>

