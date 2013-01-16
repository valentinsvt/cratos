<%@ page import="cratos.Factura" %>


<g:hiddenField name="id" value="${facturaInstance?.id}"/>
<g:hiddenField name="version" value="${facturaInstance?.version}"/>
<div class="container">
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'registro', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="registro">
                Registro
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="registro" maxlength="1" value="${facturaInstance?.registro}" title="${Factura.constraints.registro.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'pagado', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="pagado">
                Pagado
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="pagado" required="" title='${Factura.constraints.pagado.attributes.title}' value="${fieldValue(bean: facturaInstance, field: 'pagado')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'iva1', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="iva1">
                Iva1
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="iva1" required="" title='${Factura.constraints.iva1.attributes.title}' value="${fieldValue(bean: facturaInstance, field: 'iva1')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'iva0', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="iva0">
                Iva0
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="iva0" required="" title='${Factura.constraints.iva0.attributes.title}' value="${fieldValue(bean: facturaInstance, field: 'iva0')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'subtotal', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="subtotal">
                Subtotal
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="subtotal" required="" title='${Factura.constraints.subtotal.attributes.title}' value="${fieldValue(bean: facturaInstance, field: 'subtotal')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'fecha', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="fecha">
                Fecha
            </label>
        </div>

        <div class="span-19">
            <elm:datePicker class="field ui-corner-all"  title="${Factura.constraints.fecha.attributes.title}" name="fecha" title="fecha" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'direccion', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="direccion">
                Direccion
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="direccion" maxlength="127" value="${facturaInstance?.direccion}" title="${Factura.constraints.direccion.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'telefono', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="telefono">
                Telefono
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="telefono" maxlength="15" value="${facturaInstance?.telefono}" title="${Factura.constraints.telefono.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'persona', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="persona">
                Persona
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="persona" maxlength="63" value="${facturaInstance?.persona}" title="${Factura.constraints.persona.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'numero', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="numero">
                Numero
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="numero" maxlength="15" value="${facturaInstance?.numero}" title="${Factura.constraints.numero.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'empresa', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="empresa">
                Empresa
            </label>
        </div>

        <div class="span-19">
            <g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id" value="${facturaInstance?.empresa?.id}" class="field  many-to-one ui-corner-all" title="${Factura.constraints.empresa.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'tipoPago', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="tipoPago">
                Tipo Pago
            </label>
        </div>

        <div class="span-19">
            <g:select id="tipoPago" name="tipoPago.id" from="${cratos.TipoPago.list()}" optionKey="id" value="${facturaInstance?.tipoPago?.id}" class="field  many-to-one ui-corner-all" title="${Factura.constraints.tipoPago.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'proveedor', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="proveedor">
                Proveedor
            </label>
        </div>

        <div class="span-19">
            <g:select id="proveedor" name="proveedor.id" from="${cratos.Proveedor.list()}" optionKey="id" value="${facturaInstance?.proveedor?.id}" class="field  many-to-one ui-corner-all" title="${Factura.constraints.proveedor.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'estado', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="estado">
                Estado
            </label>
        </div>

        <div class="span-19">
            <g:select id="estado" name="estado.id" from="${cratos.Estado.list()}" optionKey="id" value="${facturaInstance?.estado?.id}" class="field  many-to-one ui-corner-all" title="${Factura.constraints.estado.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'tipoFactura', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="tipoFactura">
                Tipo Factura
            </label>
        </div>

        <div class="span-19">
            <g:select id="tipoFactura" name="tipoFactura.id" from="${cratos.TipoFactura.list()}" optionKey="id" value="${facturaInstance?.tipoFactura?.id}" class="field  many-to-one ui-corner-all" title="${Factura.constraints.tipoFactura.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'tipoTarjeta', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="tipoTarjeta">
                Tipo Tarjeta
            </label>
        </div>

        <div class="span-19">
            <g:select id="tipoTarjeta" name="tipoTarjeta.id" from="${cratos.TipoTarjeta.list()}" optionKey="id" value="${facturaInstance?.tipoTarjeta?.id}" class="field  many-to-one ui-corner-all" title="${Factura.constraints.tipoTarjeta.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: facturaInstance, field: 'observaciones', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="observaciones">
                Observaciones
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="observaciones" maxlength="127" value="${facturaInstance?.observaciones}" title="${Factura.constraints.observaciones.attributes.title}" />
            
        </div>
    </div>
    
</div>