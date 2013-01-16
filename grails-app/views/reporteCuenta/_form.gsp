<%@ page import="cratos.ReporteCuenta" %>



%{--<div class="fieldcontain ${hasErrors(bean: reporteCuentaInstance, field: 'empresa', 'error')} ">--}%
	%{--<label for="empresa">--}%
		%{--<g:message code="reporteCuenta.empresa.label" default="Empresa" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all" value="${reporteCuentaInstance?.empresa?.id}" noSelection="['null': '']"/>--}%
%{--</div>--}%

<div class="fieldcontain ${hasErrors(bean: reporteCuentaInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="reporteCuenta.descripcion.label" default="Descripción" />

	</label>
	<g:textField name="descripcion" maxlength="63" style="width: 300px" class="field ui-widget-content ui-corner-all required"
                 value="${reporteCuentaInstance?.descripcion}"/>
</div>

