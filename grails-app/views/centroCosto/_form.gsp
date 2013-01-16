<%@ page import="cratos.CentroCosto" %>


<div class="fieldcontain ${hasErrors(bean: centroCostoInstance, field: 'nombre', 'error')} required">
    <label for="nombre">
        <g:message code="centroCosto.nombre.label" default="Nombre"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="nombre" maxlength="127" class="field ui-widget-content ui-corner-all required" value="${centroCostoInstance?.nombre}"/>
</div>

