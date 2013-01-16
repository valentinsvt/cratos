<%@ page import="cratos.Consumo" %>


<g:hiddenField name="id" value="${consumoInstance?.id}"/>
<g:hiddenField name="version" value="${consumoInstance?.version}"/>
<div class="container">
    
    <div class="span-24 ${hasErrors(bean: consumoInstance, field: 'estado', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="estado">
                Estado
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="estado" maxlength="1" value="${consumoInstance?.estado}" title="${Consumo.constraints.estado.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: consumoInstance, field: 'precioUnitario', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="precioUnitario">
                Precio Unitario
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="precioUnitario" required="" title='${Consumo.constraints.precioUnitario.attributes.title}' value="${fieldValue(bean: consumoInstance, field: 'precioUnitario')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: consumoInstance, field: 'descuento', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="descuento">
                Descuento
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="descuento" required="" title='${Consumo.constraints.descuento.attributes.title}' value="${fieldValue(bean: consumoInstance, field: 'descuento')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: consumoInstance, field: 'cantidad', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="cantidad">
                Cantidad
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="cantidad" required="" title='${Consumo.constraints.cantidad.attributes.title}' value="${fieldValue(bean: consumoInstance, field: 'cantidad')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: consumoInstance, field: 'item', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="item">
                Item
            </label>
        </div>

        <div class="span-19">
            <g:select id="item" name="item.id" from="${cratos.Item.list()}" optionKey="id" value="${consumoInstance?.item?.id}" class="field  many-to-one ui-corner-all" title="${Consumo.constraints.item.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: consumoInstance, field: 'factura', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="factura">
                Factura
            </label>
        </div>

        <div class="span-19">
            <g:select id="factura" name="factura.id" from="${cratos.Factura.list()}" optionKey="id" value="${consumoInstance?.factura?.id}" class="field  many-to-one ui-corner-all" title="${Consumo.constraints.factura.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: consumoInstance, field: 'observaciones', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="observaciones">
                Observaciones
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="observaciones" maxlength="63" value="${consumoInstance?.observaciones}" title="${Consumo.constraints.observaciones.attributes.title}" />
            
        </div>
    </div>
    
</div>