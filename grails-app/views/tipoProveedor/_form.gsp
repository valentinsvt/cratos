<%@ page import="cratos.TipoProveedor" %>



<div class="fieldcontain ${hasErrors(bean: tipoProveedorInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoProveedor.codigo.label" default="Código" />

	</label>
	<g:textField name="codigo" maxlength="2" style="width: 30px" class="field ui-widget-content ui-corner-all required" value="${tipoProveedorInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoProveedorInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoProveedor.descripcion.label" default="Descripción" />

	</label>
	<g:textField name="descripcion" maxlength="40" style="width: 300px" class="field ui-widget-content ui-corner-all required" value="${tipoProveedorInstance?.descripcion}"/>
</div>

