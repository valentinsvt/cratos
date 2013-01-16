<%@ page import="cratos.DocumentosProceso" %>



<div class="fieldcontain ${hasErrors(bean: documentosProcesoInstance, field: 'proceso', 'error')} required">
	<label for="proceso">
		<g:message code="documentosProceso.proceso.label" default="Proceso" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="proceso" name="proceso.id" from="${cratos.Proceso.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required" value="${documentosProcesoInstance?.proceso?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProcesoInstance, field: 'tipoDocumentoProveedor', 'error')} required">
	<label for="tipoDocumentoProveedor">
		<g:message code="documentosProceso.tipoDocumentoProveedor.label" default="Tipo Documento Proveedor" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tipoDocumentoProveedor" name="tipoDocumentoProveedor.id" from="${cratos.TipoDocumentoProveedor.list()}" optionKey="id" optionValue="descripcion" class="many-to-one field ui-widget-content ui-corner-all required" value="${documentosProcesoInstance?.tipoDocumentoProveedor?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProcesoInstance, field: 'tipoComprobanteId', 'error')} required">
	<label for="tipoComprobanteId">
		<g:message code="documentosProceso.tipoComprobanteId.label" default="Tipo Comprobante Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tipoComprobanteId" name="tipoComprobanteId.id" from="${cratos.TipoComprobanteId.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required" value="${documentosProcesoInstance?.tipoComprobanteId?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProcesoInstance, field: 'documentosProcesoSerie01', 'error')} ">
	<label for="documentosProcesoSerie01">
		<g:message code="documentosProceso.documentosProcesoSerie01.label" default="Documentos Proceso Serie01" />
		
	</label>
	<g:textField name="documentosProcesoSerie01" maxlength="3" class="field ui-widget-content ui-corner-all" value="${documentosProcesoInstance?.documentosProcesoSerie01}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProcesoInstance, field: 'documentosProcesoSerie02', 'error')} ">
	<label for="documentosProcesoSerie02">
		<g:message code="documentosProceso.documentosProcesoSerie02.label" default="Documentos Proceso Serie02" />
		
	</label>
	<g:textField name="documentosProcesoSerie02" maxlength="3" class="field ui-widget-content ui-corner-all" value="${documentosProcesoInstance?.documentosProcesoSerie02}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProcesoInstance, field: 'secuencial', 'error')} required">
	<label for="secuencial">
		<g:message code="documentosProceso.secuencial.label" default="Secuencial" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="secuencial" class="field ui-widget-content ui-corner-all required" value="${fieldValue(bean: documentosProcesoInstance, field: 'secuencial')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProcesoInstance, field: 'autorizacionSRI', 'error')} ">
	<label for="autorizacionSRI">
		<g:message code="documentosProceso.autorizacionSRI.label" default="Autorizacion SRI" />
		
	</label>
	<g:textField name="autorizacionSRI" class="field ui-widget-content ui-corner-all" value="${documentosProcesoInstance?.autorizacionSRI}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentosProcesoInstance, field: 'fecha', 'error')} required">
	<label for="fecha">
		<g:message code="documentosProceso.fecha.label" default="Fecha" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fecha" class="field datepicker ui-widget-content ui-corner-all required" value="${documentosProcesoInstance?.fecha}"/>
<script type="text/javascript">
$("#fecha").datepicker({
changeMonth: true,
changeYear: true,
showOn: "both",
buttonImage: "${resource(dir:'images', file:'calendar.png')}",
buttonImageOnly: true
});
</script>
</div>

