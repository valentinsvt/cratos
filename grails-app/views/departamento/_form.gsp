<%@ page import="cratos.Departamento" %>



%{--<div class="fieldcontain ${hasErrors(bean: departamentoInstance, field: 'empresa', 'error')} ">--}%
	%{--<label for="empresa">--}%
		%{--<g:message code="departamento.empresa.label" default="Empresa" />--}%
		%{----}%
	%{--</label>--}%
	%{--<g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all" value="${departamentoInstance?.empresa?.id}" noSelection="['null': '']"/>--}%
%{--</div>--}%

<div class="fieldcontain ${hasErrors(bean: departamentoInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="departamento.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" class="field ui-widget-content ui-corner-all" value="${departamentoInstance?.descripcion}" style="width: 300px"/>
</div>

