<%@ page import="cratos.FormaDePago" %>



<div class="fieldcontain ${hasErrors(bean: formaDePagoInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="formaDePago.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" class="field ui-widget-content ui-corner-all required" value="${formaDePagoInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: formaDePagoInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="formaDePago.descripcion.label" default="Descripcion" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" class="field ui-widget-content ui-corner-all" value="${formaDePagoInstance?.descripcion}"/>
</div>

