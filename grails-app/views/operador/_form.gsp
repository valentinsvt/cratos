<%@ page import="cratos.Operador" %>



<div class="fieldcontain ${hasErrors(bean: operadorInstance, field: 'descripcion', 'error')} required ">
	<label for="descripcion">
		<g:message code="operador.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="15" style="width: 150px" class="field ui-widget-content ui-corner-all required"
                 value="${operadorInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: operadorInstance, field: 'signo', 'error')} required">
	<label for="signo">
		<g:message code="operador.signo.label" default="Signo" />

	</label>
	<g:textField name="signo" maxlength="7" style="width: 70px" class="field ui-widget-content ui-corner-all required"
                 value="${operadorInstance?.signo}"/>
</div>

