<%@ page import="cratos.Cargo" %>



<div class="fieldcontain ${hasErrors(bean: cargoInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="cargo.descripcion.label" default="Descripción" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="127" class="field ui-widget-content ui-corner-all required"
                 value="${cargoInstance?.descripcion}" style="width: 400px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cargoInstance, field: 'empresa', 'error')} required">
	<label for="empresa">
		<g:message code="cargo.empresa.label" default="Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id"
              class="many-to-one field ui-widget-content ui-corner-all required" value="${cargoInstance?.empresa?.id}"
              style="width: 400px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cargoInstance, field: 'departamento', 'error')} ">
	<label for="departamento">
		<g:message code="cargo.departamento.label" default="Departamento" />
		
	</label>
	<g:select id="departamento" name="departamento.id" from="${cratos.Departamento.list()}" optionKey="id"
              class="many-to-one field ui-widget-content ui-corner-all"
              value="${cargoInstance?.departamento?.id}" noSelection="['null': '']" style="width: 400px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cargoInstance, field: 'sueldo', 'error')} required">
	<label for="sueldo">
		<g:message code="cargo.sueldo.label" default="Sueldo" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sueldo" class="field ui-widget-content ui-corner-all required"
             value="${fieldValue(bean: cargoInstance, field: 'sueldo')}" style="width: 80px;"/>
</div>

