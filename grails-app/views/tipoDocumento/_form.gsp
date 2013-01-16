<%@ page import="cratos.TipoDocumento" %>



<div class="fieldcontain ${hasErrors(bean: tipoDocumentoInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoDocumento.codigo.label" default="Código" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" class="field ui-widget-content ui-corner-all required" value="${tipoDocumentoInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoDocumentoInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoDocumento.descripcion.label" default="Descripción" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" class="field ui-widget-content ui-corner-all required" value="${tipoDocumentoInstance?.descripcion}"/>
</div>

