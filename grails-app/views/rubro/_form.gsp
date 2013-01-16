<%@ page import="cratos.Rubro" %>



<div class="fieldcontain ${hasErrors(bean: rubroInstance, field: 'tipoRubro', 'error')} required">
	<label for="tipoRubro">
		<g:message code="rubro.tipoRubro.label" default="Tipo de Rubro" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tipoRubro" name="tipoRubro.id" from="${cratos.TipoRubro.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all required" value="${rubroInstance?.tipoRubro?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="rubro.descripcion.label" default="Descripción" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="63" class="field ui-widget-content ui-corner-all required"
                 value="${rubroInstance?.descripcion}" style="width: 400px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroInstance, field: 'porcentaje', 'error')} required">
	<label for="porcentaje">
		<g:message code="rubro.porcentaje.label" default="Porcentaje" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="porcentaje" class="field ui-widget-content ui-corner-all required"
             value="${fieldValue(bean: rubroInstance, field: 'porcentaje')}" style="width: 40px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroInstance, field: 'editable', 'error')} required">
	<label for="editable">
		<g:message code="rubro.editable.label" default="Editable" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="editable" maxlength="1" class="field ui-widget-content ui-corner-all required"
                 value="${rubroInstance?.editable}" style="width: 30px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroInstance, field: 'decimo', 'error')} required">
	<label for="decimo">
		<g:message code="rubro.decimo.label" default="Decimo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="decimo" maxlength="1" class="field ui-widget-content ui-corner-all required" value="${rubroInstance?.decimo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroInstance, field: 'iess', 'error')} required">
	<label for="iess">
		<g:message code="rubro.iess.label" default="Iess" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="iess" maxlength="1" class="field ui-widget-content ui-corner-all required"
                 value="${rubroInstance?.iess}" style="width: 30px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroInstance, field: 'gravable', 'error')} required">
	<label for="gravable">
		<g:message code="rubro.gravable.label" default="Gravable" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="gravable" maxlength="1" class="field ui-widget-content ui-corner-all required"
                 value="${rubroInstance?.gravable}" style="width: 30px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: rubroInstance, field: 'valor', 'error')} required">
	<label for="valor">
		<g:message code="rubro.valor.label" default="Valor" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="valor" class="field ui-widget-content ui-corner-all required"
             value="${fieldValue(bean: rubroInstance, field: 'valor')}" style="width: 80px;"/>
</div>

