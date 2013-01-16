<%@ page import="cratos.TipoFactura" %>



<div class="fieldcontain ${hasErrors(bean: tipoFacturaInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoFactura.codigo.label" default="Código" />
		
	</label>
	<g:textField name="codigo" maxlength="1" style="width: 30px" class="field ui-widget-content ui-corner-all required" value="${tipoFacturaInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoFacturaInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoFactura.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="15" style="width: 150px" class="field ui-widget-content ui-corner-all required" value="${tipoFacturaInstance?.descripcion}"/>
</div>

