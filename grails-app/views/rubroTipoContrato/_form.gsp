<%@ page import="cratos.RubroTipoContrato" %>



<div class="fieldcontain ${hasErrors(bean: rubroTipoContratoInstance, field: 'tipoContrato', 'error')} required">
	<label for="tipoContrato">
		<g:message code="rubroTipoContrato.tipoContrato.label" default="Tipo Contrato" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tipoContrato" name="tipoContrato.id" from="${cratos.TipoContrato.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required" value="${rubroTipoContratoInstance?.tipoContrato?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroTipoContratoInstance, field: 'rubro', 'error')} required">
	<label for="rubro">
		<g:message code="rubroTipoContrato.rubro.label" default="Rubro" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="rubro" name="rubro.id" from="${cratos.Rubro.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required" value="${rubroTipoContratoInstance?.rubro?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroTipoContratoInstance, field: 'porcentaje', 'error')} required">
	<label for="porcentaje">
		<g:message code="rubroTipoContrato.porcentaje.label" default="Porcentaje" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="porcentaje" class="field ui-widget-content ui-corner-all required" value="${fieldValue(bean: rubroTipoContratoInstance, field: 'porcentaje')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroTipoContratoInstance, field: 'editable', 'error')} required">
	<label for="editable">
		<g:message code="rubroTipoContrato.editable.label" default="Editable" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="editable" maxlength="1" class="field ui-widget-content ui-corner-all required" value="${rubroTipoContratoInstance?.editable}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroTipoContratoInstance, field: 'decimo', 'error')} required">
	<label for="decimo">
		<g:message code="rubroTipoContrato.decimo.label" default="Decimo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="decimo" maxlength="1" class="field ui-widget-content ui-corner-all required" value="${rubroTipoContratoInstance?.decimo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroTipoContratoInstance, field: 'iess', 'error')} required">
	<label for="iess">
		<g:message code="rubroTipoContrato.iess.label" default="Iess" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="iess" maxlength="1" class="field ui-widget-content ui-corner-all required" value="${rubroTipoContratoInstance?.iess}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroTipoContratoInstance, field: 'gravable', 'error')} required">
	<label for="gravable">
		<g:message code="rubroTipoContrato.gravable.label" default="Gravable" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="gravable" maxlength="1" class="field ui-widget-content ui-corner-all required" value="${rubroTipoContratoInstance?.gravable}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroTipoContratoInstance, field: 'valor', 'error')} required">
	<label for="valor">
		<g:message code="rubroTipoContrato.valor.label" default="Valor" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="valor" class="field ui-widget-content ui-corner-all required" value="${fieldValue(bean: rubroTipoContratoInstance, field: 'valor')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroTipoContratoInstance, field: 'observaciones', 'error')} ">
	<label for="observaciones">
		<g:message code="rubroTipoContrato.observaciones.label" default="Observaciones" />
		
	</label>
	<g:textField name="observaciones" maxlength="127" class="field ui-widget-content ui-corner-all" value="${rubroTipoContratoInstance?.observaciones}"/>
</div>

