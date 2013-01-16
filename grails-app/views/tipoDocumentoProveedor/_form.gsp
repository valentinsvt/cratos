<%@ page import="cratos.TipoDocumentoProveedor" %>



<div class="fieldcontain ${hasErrors(bean: tipoDocumentoProveedorInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoDocumentoProveedor.codigo.label" default="Código" />

	</label>
	<g:textField name="codigo" maxlength="1" style="width: 30px" class="field ui-widget-content ui-corner-all required" value="${tipoDocumentoProveedorInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoDocumentoProveedorInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoDocumentoProveedor.descripcion.label" default="Descripción" />

	</label>
	<g:textField name="descripcion" class="field ui-widget-content ui-corner-all required" style="width: 170px" value="${tipoDocumentoProveedorInstance?.descripcion}"/>
</div>

