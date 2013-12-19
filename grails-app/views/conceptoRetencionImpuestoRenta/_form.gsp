<%@ page import="cratos.ConceptoRetencionImpuestoRenta" %>



<div class="fieldcontain ${hasErrors(bean: conceptoRetencionImpuestoRentaInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="conceptoRetencionImpuestoRenta.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" class="field ui-widget-content ui-corner-all required" value="${conceptoRetencionImpuestoRentaInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: conceptoRetencionImpuestoRentaInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="conceptoRetencionImpuestoRenta.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="63" class="field ui-widget-content ui-corner-all required" value="${conceptoRetencionImpuestoRentaInstance?.descripcion}"/>
</div>

