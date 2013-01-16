<%@ page import="cratos.Base" %>



<div class="fieldcontain ${hasErrors(bean: baseInstance, field: 'periodo', 'error')} required">
	<label for="periodo">
		<g:message code="base.periodo.label" default="Periodo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="periodo" name="periodo.id" from="${cratos.Contabilidad.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required" value="${baseInstance?.periodo?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: baseInstance, field: 'fraccionBasica', 'error')} required">
	<label for="fraccionBasica">
		<g:message code="base.fraccionBasica.label" default="Fraccion Basica" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="fraccionBasica" class="field ui-widget-content ui-corner-all required" value="${fieldValue(bean: baseInstance, field: 'fraccionBasica')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: baseInstance, field: 'excesoHasta', 'error')} required">
	<label for="excesoHasta">
		<g:message code="base.excesoHasta.label" default="Exceso Hasta" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="excesoHasta" class="field ui-widget-content ui-corner-all required" value="${fieldValue(bean: baseInstance, field: 'excesoHasta')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: baseInstance, field: 'impuestosFraccion', 'error')} required">
	<label for="impuestosFraccion">
		<g:message code="base.impuestosFraccion.label" default="Impuestos Fraccion" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="impuestosFraccion" class="field ui-widget-content ui-corner-all required" value="${fieldValue(bean: baseInstance, field: 'impuestosFraccion')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: baseInstance, field: 'porcentaje', 'error')} required">
	<label for="porcentaje">
		<g:message code="base.porcentaje.label" default="Porcentaje" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="porcentaje" class="field ui-widget-content ui-corner-all required" value="${fieldValue(bean: baseInstance, field: 'porcentaje')}"/>
</div>

