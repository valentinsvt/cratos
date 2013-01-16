<%@ page import="cratos.Bodega" %>



<div class="fieldcontain ${hasErrors(bean: bodegaInstance, field: 'centroCosto', 'error')} ">
	<label for="centroCosto">
		<g:message code="bodega.centroCosto.label" default="Centro de Costo" />
		
	</label>
	<g:select id="centroCosto" name="centroCosto.id" from="${cratos.CentroCosto.list()}" optionKey="id"
              class="many-to-one ui-widget-content ui-corner-all" value="${bodegaInstance?.centroCosto?.id}"
              noSelection="['null': '']" style="width: 400px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bodegaInstance, field: 'codigo', 'error')} ">
	<label for="codigo">
		<g:message code="bodega.codigo.label" default="Código" />
		
	</label>
	<g:textField name="codigo" maxlength="8" class="field ui-widget-content ui-corner-all"
                 value="${bodegaInstance?.codigo}" style="width: 80px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bodegaInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="bodega.descripcion.label" default="Descripcion" />
		
	</label>
	<g:textField name="descripcion" maxlength="40" class="field ui-widget-content ui-corner-all"
                 value="${bodegaInstance?.descripcion}" style="width: 400px;"/>
</div>

