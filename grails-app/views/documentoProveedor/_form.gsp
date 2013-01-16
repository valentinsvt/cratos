<%@ page import="cratos.DocumentoProveedor" %>



<div class="fieldcontain ${hasErrors(bean: documentoProveedorInstance, field: 'proceso', 'error')} required">
	<label for="proceso">
		<g:message code="documentoProveedor.proceso.label" default="Proceso" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="proceso" name="proceso.id" from="${cratos.Proceso.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required" value="${documentoProveedorInstance?.proceso?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentoProveedorInstance, field: 'tipoDepartamento', 'error')} required">
	<label for="tipoDepartamento">
		<g:message code="documentoProveedor.tipoDepartamento.label"  default="Tipo Departamento" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tipoDepartamento" name="tipoDepartamento.id" from="${cratos.TipoDocumentoProveedor.list()}" optionKey="id" optionValue="descripcion" class="many-to-one field ui-widget-content ui-corner-all required" value="${documentoProveedorInstance?.tipoDepartamento?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentoProveedorInstance, field: 'numero', 'error')} required">
	<label for="numero">
		<g:message code="documentoProveedor.numero.label" default="Numero" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numero" maxlength="15" class="field ui-widget-content ui-corner-all required" value="${documentoProveedorInstance?.numero}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentoProveedorInstance, field: 'autorizacionSRI', 'error')} required">
	<label for="autorizacionSRI">
		<g:message code="documentoProveedor.autorizacionSRI.label" default="Autorizacion SRI" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="autorizacionSRI" maxlength="10" class="field ui-widget-content ui-corner-all required" value="${documentoProveedorInstance?.autorizacionSRI}"/>
</div>

