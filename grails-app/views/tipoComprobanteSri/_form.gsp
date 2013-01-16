<%@ page import="cratos.TipoComprobanteSri" %>



<div class="fieldcontain ${hasErrors(bean: tipoComprobanteSriInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoComprobanteSri.codigo.label" default="Código" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" class="field ui-widget-content ui-corner-all required"
                 value="${tipoComprobanteSriInstance?.codigo}" style="width: 40px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoComprobanteSriInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoComprobanteSri.descripcion.label" default="Descripción" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="63" class="field ui-widget-content ui-corner-all required"
                 value="${tipoComprobanteSriInstance?.descripcion}" style="width: 400px;"/>
</div>

