<%@ page import="cratos.TipoRelacion" %>



<div class="fieldcontain ${hasErrors(bean: tipoRelacionInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoRelacion.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="1" class="field ui-widget-content ui-corner-all required" value="${tipoRelacionInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoRelacionInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoRelacion.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="31" class="field ui-widget-content ui-corner-all required" value="${tipoRelacionInstance?.descripcion}"/>
</div>

