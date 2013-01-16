<%@ page import="cratos.DetalleAdquisicion" %>


<g:hiddenField name="id" value="${detalleAdquisicionInstance?.id}"/>
<g:hiddenField name="version" value="${detalleAdquisicionInstance?.version}"/>
<div class="container">
    
    <div class="span-24 ${hasErrors(bean: detalleAdquisicionInstance, field: 'subtotal', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="subtotal">
                Subtotal
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="subtotal" required="" title='${DetalleAdquisicion.constraints.subtotal.attributes.title}' value="${fieldValue(bean: detalleAdquisicionInstance, field: 'subtotal')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: detalleAdquisicionInstance, field: 'iva', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="iva">
                Iva
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="iva" required="" title='${DetalleAdquisicion.constraints.iva.attributes.title}' value="${fieldValue(bean: detalleAdquisicionInstance, field: 'iva')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: detalleAdquisicionInstance, field: 'precioUnitario', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="precioUnitario">
                Precio Unitario
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="precioUnitario" required="" title='${DetalleAdquisicion.constraints.precioUnitario.attributes.title}' value="${fieldValue(bean: detalleAdquisicionInstance, field: 'precioUnitario')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: detalleAdquisicionInstance, field: 'cantidad', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="cantidad">
                Cantidad
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="cantidad" required="" title='${DetalleAdquisicion.constraints.cantidad.attributes.title}' value="${fieldValue(bean: detalleAdquisicionInstance, field: 'cantidad')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: detalleAdquisicionInstance, field: 'adquisiciones', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="adquisiciones">
                Adquisiciones
            </label>
        </div>

        <div class="span-19">
            <g:select id="adquisiciones" name="adquisiciones.id" from="${cratos.Adquisiciones.list()}" optionKey="id" value="${detalleAdquisicionInstance?.adquisiciones?.id}" class="field  many-to-one ui-corner-all" title="${DetalleAdquisicion.constraints.adquisiciones.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: detalleAdquisicionInstance, field: 'item', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="item">
                Item
            </label>
        </div>

        <div class="span-19">
            <g:select id="item" name="item.id" from="${cratos.Item.list()}" optionKey="id" value="${detalleAdquisicionInstance?.item?.id}" class="field  many-to-one ui-corner-all" title="${DetalleAdquisicion.constraints.item.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: detalleAdquisicionInstance, field: 'estado', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="estado">
                Estado
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="estado" maxlength="1" value="${detalleAdquisicionInstance?.estado}" title="${DetalleAdquisicion.constraints.estado.attributes.title}" />
            
        </div>
    </div>
    
</div>