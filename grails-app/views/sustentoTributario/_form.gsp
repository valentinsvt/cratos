<%@ page import="cratos.SustentoTributario" %>



<div class="fieldcontain ${hasErrors(bean: sustentoTributarioInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="sustentoTributario.descripcion.label" default="Descripcion" />
		
	</label>
	<g:textField name="descripcion" maxlength="127" class="field ui-widget-content ui-corner-all" value="${sustentoTributarioInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: sustentoTributarioInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="sustentoTributario.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="codigo" class="field ui-widget-content ui-corner-all required" value="${fieldValue(bean: sustentoTributarioInstance, field: 'codigo')}"/>
</div>

