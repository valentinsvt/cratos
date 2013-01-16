<%@ page import="cratos.DocumentosProveedor" %>



<div class="fieldcontain ${hasErrors(bean: documentosProveedorInstance, field: 'proveedor', 'error')} required">
	<label for="proveedor">
		<g:message code="documentosProveedor.proveedor.label" default="Proveedor" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="proveedor" name="proveedor.id" from="${cratos.Proveedor.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required" value="${documentosProveedorInstance?.proveedor?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProveedorInstance, field: 'tipoDocumentoProveedor', 'error')} required">
	<label for="tipoDocumentoProveedor">
		<g:message code="documentosProveedor.tipoDocumentoProveedor.label" default="Tipo Documento Proveedor" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tipoDocumentoProveedor" name="tipoDocumentoProveedor.id" from="${cratos.TipoDocumentoProveedor.list()}" optionKey="id" optionValue="descripcion" class="many-to-one field ui-widget-content ui-corner-all required" value="${documentosProveedorInstance?.tipoDocumentoProveedor?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProveedorInstance, field: 'documentosProveedorSerie01', 'error')} ">
	<label for="documentosProveedorSerie01">
		<g:message code="documentosProveedor.documentosProveedorSerie01.label" default="Documentos Proveedor Serie01" />
		
	</label>
	<g:textField name="documentosProveedorSerie01" maxlength="3" class="field ui-widget-content ui-corner-all" value="${documentosProveedorInstance?.documentosProveedorSerie01}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProveedorInstance, field: 'documentosProveedorSerie02', 'error')} ">
	<label for="documentosProveedorSerie02">
		<g:message code="documentosProveedor.documentosProveedorSerie02.label" default="Documentos Proveedor Serie02" />
		
	</label>
	<g:textField name="documentosProveedorSerie02" maxlength="3" class="field ui-widget-content ui-corner-all" value="${documentosProveedorInstance?.documentosProveedorSerie02}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProveedorInstance, field: 'fechaAutorizacionSRI', 'error')} required">
	<label for="fechaAutorizacionSRI">
		<g:message code="documentosProveedor.fechaAutorizacionSRI.label" default="Fecha Autorizacion SRI" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fechaAutorizacionSRI" class="field datepicker ui-widget-content ui-corner-all required" value="${documentosProveedorInstance?.fechaAutorizacionSRI}"/>
<script type="text/javascript">
$("#fechaAutorizacionSRI").datepicker({
changeMonth: true,
changeYear: true,
showOn: "both",
buttonImage: "${resource(dir:'images', file:'calendar.png')}",
buttonImageOnly: true
});
</script>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProveedorInstance, field: 'fechaValidoHasta', 'error')} required">
	<label for="fechaValidoHasta">
		<g:message code="documentosProveedor.fechaValidoHasta.label" default="Fecha Valido Hasta" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fechaValidoHasta" class="field datepicker ui-widget-content ui-corner-all required" value="${documentosProveedorInstance?.fechaValidoHasta}"/>
<script type="text/javascript">
$("#fechaValidoHasta").datepicker({
changeMonth: true,
changeYear: true,
showOn: "both",
buttonImage: "${resource(dir:'images', file:'calendar.png')}",
buttonImageOnly: true
});
</script>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProveedorInstance, field: 'autorizacionSRI', 'error')} ">
	<label for="autorizacionSRI">
		<g:message code="documentosProveedor.autorizacionSRI.label" default="Autorizacion SRI" />
		
	</label>
	<g:textField name="autorizacionSRI" class="field ui-widget-content ui-corner-all" value="${documentosProveedorInstance?.autorizacionSRI}"/>
</div>

