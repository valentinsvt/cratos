<%@ page import="cratos.TipoComprobanteId" %>



<div class="fieldcontain ${hasErrors(bean: tipoComprobanteIdInstance, field: 'tipoIdentificacion', 'error')} required">
	<label for="tipoIdentificacion">
		<g:message code="tipoComprobanteId.tipoIdentificacion.label" default="Tipo Identificación" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tipoIdentificacion" name="tipoIdentificacion.id" from="${cratos.TipoIdentificacion.list()}"
              optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required"
              value="${tipoComprobanteIdInstance?.tipoIdentificacion?.id}" style="width: 400px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoComprobanteIdInstance, field: 'tipoComprobanteSri', 'error')} required">
	<label for="tipoComprobanteSri" style="width: 28%">
		<g:message code="tipoComprobanteId.tipoComprobanteSri.label" default="Tipo Comprobante Sri" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tipoComprobanteSri" name="tipoComprobanteSri.id" from="${cratos.TipoComprobanteSri.list()}"
              optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required"
              value="${tipoComprobanteIdInstance?.tipoComprobanteSri?.id}" style="width: 400px;"/>
</div>

