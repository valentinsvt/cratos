<%@ page import="cratos.TipoSoporte" %>



<div class="fieldcontain ${hasErrors(bean: tipoSoporteInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoSoporte.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="2" class="field ui-widget-content ui-corner-all required"
                 value="${tipoSoporteInstance?.codigo}" style="width: 40px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoSoporteInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoSoporte.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
%{--
	<g:textField name="descripcion" maxlength="127" class="field ui-widget-content ui-corner-all required"
                 value="${tipoSoporteInstance?.descripcion}" style="width: 400px;"/>
--}%
    <g:textArea class="field ui-widget-content ui-corner-all" minLenght="1" maxLenght="127" name="descripcion"
                id="descripcion" title="Descripcion" cols="80" rows="2" value="${tipoSoporteInstance?.descripcion}"
    style="width: 400px; height: 60px;"/>

</div>

