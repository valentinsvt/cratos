<%@ page import="cratos.ActivoFijo" %>
<div class="fieldcontain ${hasErrors(bean: activoFijoInstance, field: 'item', 'error')} required ">
    <label for="item">
        <g:message code="activoFijo.item.label" default="Item" />

    </label>
    <g:select id="item" name="item.id" from="${cratos.Item.list()}" optionKey="id" optionValue="nombre" class="many-to-one field ui-widget-content ui-corner-all required"
              style="width: 300px" value="${activoFijoInstance?.item?.id}" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: activoFijoInstance, field: 'modelo', 'error')} ">
    <label for="modelo">
        <g:message code="activoFijo.modelo.label" default="Modelo" />

    </label>
    <g:textField name="modelo" maxlength="63" class="field ui-widget-content ui-corner-all"  style="width: 300px" value="${activoFijoInstance?.modelo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: activoFijoInstance, field: 'serie', 'error')} ">
    <label for="serie">
        <g:message code="activoFijo.serie.label" default="Serie" />

    </label>
    <g:textField name="serie" maxlength="31" class="field ui-widget-content ui-corner-all" style="width: 300px" value="${activoFijoInstance?.serie}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: activoFijoInstance, field: 'color', 'error')} ">
    <label for="color">
        <g:message code="activoFijo.color.label" default="Color" />

    </label>
    <g:select id="color" name="color.id" from="${cratos.Color.list()}" optionKey="id"  style="width: 100px" optionValue="descripcion" class="many-to-one field ui-widget-content ui-corner-all" value="${activoFijoInstance?.color?.id}" noSelection="['null': '']"/>
</div>


<div class="fieldcontain ${hasErrors(bean: activoFijoInstance, field: 'periodoDepreciacion', 'error')} required">
    <label for="periodoDepreciacion">
        <g:message code="activoFijo.periodoDepreciacion.label" default="Periodo Depreciacion" />

    </label>
    <g:field type="number" name="periodoDepreciacion" class="field ui-widget-content ui-corner-all required" style="width: 100px"
             value="${fieldValue(bean: activoFijoInstance, field: 'periodoDepreciacion')}"/>
</div>



<div class="fieldcontain ${hasErrors(bean: activoFijoInstance, field: 'fechaInicio', 'error')} ">
	<label for="fechaInicio">
		<g:message code="activoFijo.fechaInicio.label" default="Fecha Inicio" />
		
	</label>

    <elm:datePicker class="field ui-corner-all" id="fechaInicio" format="yyyy-MM-dd" name="fechaInicion" style="width: 80px" value="${activoFijoInstance?.fechaInicio}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: activoFijoInstance, field: 'fechaAdquisicion', 'error')}">
	<label for="fechaAdquisicion">
		<g:message code="activoFijo.fechaAdquisicion.label" default="Fecha Adquisicion" />
		
	</label>

   <elm:datePicker class="field ui-corner-all" id="fechaAdquisicion" format="yyyy-MM-dd" name="fechaAdquisicion"
                   style="width: 80px" value="${activoFijoInstance?.fechaAdquisicion}"/>
</div>




<div class="fieldcontain ${hasErrors(bean: activoFijoInstance, field: 'observaciones', 'error')} ">
	<label for="observaciones">
		<g:message code="activoFijo.observaciones.label" default="Observaciones" />
		
	</label>
	<g:textField name="observaciones" maxlength="127" class="field ui-widget-content ui-corner-all" style="width: 300px" value="${activoFijoInstance?.observaciones}"/>
</div>

