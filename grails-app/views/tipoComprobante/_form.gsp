<%@ page import="cratos.TipoComprobante" %>



<div class="fieldcontain ${hasErrors(bean: tipoComprobanteInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoComprobante.codigo.label" default="Código" />
		
	</label>
	<g:textField name="codigo" maxlength="1" style="width: 30px" class="field ui-widget-content ui-corner-all required" value="${tipoComprobanteInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoComprobanteInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoComprobante.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" style="width: 270px" class="field ui-widget-content ui-corner-all required" value="${tipoComprobanteInstance?.descripcion}"/>
</div>

