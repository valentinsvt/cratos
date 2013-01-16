<%@ page import="cratos.TipoPago" %>



<div class="fieldcontain ${hasErrors(bean: tipoPagoInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoPago.codigo.label" default="Codigo" />

	</label>
	<g:textField name="codigo" maxlength="1" style="width: 30px" class="field ui-widget-content ui-corner-all required" value="${tipoPagoInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoPagoInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoPago.descripcion.label" default="Descripcion" />
		
	</label>
	<g:textField name="descripcion" maxlength="40" style="width: 290px" class="field ui-widget-content ui-corner-all required" value="${tipoPagoInstance?.descripcion}"/>
</div>

