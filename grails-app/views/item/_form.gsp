<%@ page import="cratos.Item" %>


%{--<g:hiddenField name="id" value="${itemInstance?.id}"/>--}%
%{--<g:hiddenField name="version" value="${itemInstance?.version}"/>--}%
<div class="container span-20 prepend-1">



<div class="fila span-20">

    <div class="${hasErrors(bean: itemInstance, field: 'estado', 'error')}">
        <div class="span-3">
            <label for="estado">
                Estado
            </label>
        </div>

        <div class="span-6">

            <g:select class="field  required  ui-corner-all" name="estado" maxlength="1" required=""
                      value="${itemInstance?.estado}" title="${Item.constraints.estado.attributes.title}" from="${[1:'Activo',2:'No Activo']}" optionKey="key" optionValue="value"/>
            <span class="required-indicator">*</span>
        </div>
    </div>


    <div class="${hasErrors(bean: itemInstance, field: 'fecha', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="fecha">
                Fecha
            </label>
        </div>

        <div class="span-6">
            <elm:datePicker class="field ui-corner-all" title="${Item.constraints.fecha.attributes.title}"
                            name="fecha" format="yyyy-MM-dd" value="${itemInstance?.fecha}"/>
        </div>

    </div>




</div>

<div class="fila span-20">

    <div class="${hasErrors(bean: itemInstance, field: 'codigo', 'error')} required">

        <div class="span-3">

            <label for="codigo">
                Codigo
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  required  ui-corner-all" name="codigo" id="codigo" maxlength="15" required=""
                         value="${itemInstance?.codigo}" title="${Item.constraints.codigo.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>



</div>


<div class="fila span-20">

    <div class="${hasErrors(bean: itemInstance, field: 'nombre', 'error')} required">

        <div class="span-3">

            <label for="nombre">
                Nombre
            </label>

        </div>

        <div class="span-12">
            <g:textField class="field  required  ui-corner-all" name="nombre" maxlength="127" required=""
                         style="width: 350px"
                         value="${itemInstance?.nombre}" title="${Item.constraints.nombre.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>



    </div>

</div>
<div class="fila span-20 ">


    <div class="${hasErrors(bean: itemInstance, field: 'marca', 'error')} ">
        <div class="span-3">
            <label for="marca">
                Marca
            </label>
        </div>

        <div class="span-6">
            <g:select id="marca" name="marca.id" from="${cratos.Marca.list()}" optionKey="id" optionValue="descripcion"
                      value="${itemInstance?.marca?.id}" class="field  many-to-one ui-corner-all"
                      title="${Item.constraints.marca.attributes.title}" noSelection="['null': '']"/>

        </div>
    </div>





    <div class="${hasErrors(bean: itemInstance, field: 'unidad', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="unidad">
                Unidad
            </label>
        </div>

        <div class="span-6">
            <g:select id="unidad" name="unidad.id" from="${cratos.Unidad.list()}" optionKey="id"
                      value="${itemInstance?.unidad?.id}" class="field  many-to-one ui-corner-all"
                      title="${Item.constraints.unidad.attributes.title}" noSelection="['null': '']"/>

        </div>
    </div>

</div>


<div class="fila span-20">



    <div class="${hasErrors(bean: itemInstance, field: 'stock', 'error')} required">
        <div class="span-3">
            <label for="stock">
                Stock Mínimo
            </label>
        </div>

        <div class="span-6">
            <g:field class="field  required number  ui-corner-all" type="number" name="stock" required="" optionValue="value" optionKey="id"
                     title='${Item.constraints.stock.attributes.title}'
                     value="${fieldValue(bean: itemInstance, field: 'stock')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="${hasErrors(bean: itemInstance, field: 'stockMaximo', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="stockMaximo">
                Stock Maximo
            </label>
        </div>

        <div class="span-6">
            <g:field class="field  required number  ui-corner-all" type="number" name="stockMaximo" id="stockMaximo" optionValue="value" optionKey="id"
                     required=""
                     title='${Item.constraints.stockMaximo.attributes.title}'
                     value="${fieldValue(bean: itemInstance, field: 'stockMaximo')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>



</div>

<div class="fila span-20">

    <div class="${hasErrors(bean: itemInstance, field: 'precioVenta', 'error')} required">
        <div class="span-3">
            <label for="precioVenta">
                Precio Venta
            </label>
        </div>

        <div class="span-6">
            <g:field class="field  required number  ui-corner-all" type="number" name="precioVenta" required=""
                     title='${Item.constraints.precioVenta.attributes.title}'
                     value="${fieldValue(bean: itemInstance, field: 'precioVenta')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>


    <div class="${hasErrors(bean: itemInstance, field: 'precioUnitario', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="precioUnitario">
                Precio Unitario
            </label>
        </div>

        <div class="span-6">
            <g:field class="field  required number  ui-corner-all" type="number" name="precioUnitario"
                     required=""
                     title='${Item.constraints.precioUnitario.attributes.title}'
                     value="${fieldValue(bean: itemInstance, field: 'precioUnitario')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

</div>



<div class="fila span-20">



    <div class="${hasErrors(bean: itemInstance, field: 'precioCosto', 'error')} required">
        <div class="span-3">
            <label for="precioCosto">
                Precio Costo
            </label>
        </div>

        <div class="span-6">
            <g:field class="field  required number  ui-corner-all" type="number" name="precioCosto" required=""
                     title='${Item.constraints.precioCosto.attributes.title}'
                     value="${fieldValue(bean: itemInstance, field: 'precioCosto')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    </div>
   <div class="fila span-20">

    <div class="${hasErrors(bean: itemInstance, field: 'iva', 'error')} required">
        <div class="span-3">
            <label for="iva">
                Iva
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  required  ui-corner-all" name="iva" id="iva" required=""
                         value="${itemInstance?.iva}"
                         title="${Item.constraints.iva.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
       <div class="${hasErrors(bean: itemInstance, field: 'ice', 'error')}">
           <div class="span-3 prepend-1">
               <label for="ice">

                   Ice

               </label>

           </div>
           <div class="span-6">

               <g:textField class="field ui-corner-all" name="ice" value="${fieldValue(bean: itemInstance, field: 'ice')}"
                            title="${Item.constraints.ice.attributes.title}"/>
           </div>

       </div>



   </div>


<div class="fila span-20">

    <div class="${hasErrors(bean: itemInstance, field: 'peso', 'error')} required">
        <div class="span-3">
            <label for="peso">
                Peso
            </label>
        </div>

        <div class="span-6">
            <g:field class="field  required number  ui-corner-all" type="number" name="peso" required=""
                     title='${Item.constraints.peso.attributes.title}'
                     value="${fieldValue(bean: itemInstance, field: 'peso')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    <div class="${hasErrors(bean: itemInstance, field: 'grupo', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="grupo">
                Grupo
            </label>
        </div>

        <div class="span-6">
            <g:select id="grupo" name="grupo.id" from="${cratos.Grupo.list()}" optionKey="id"
                      value="${itemInstance?.grupo?.id}" class="field  many-to-one ui-corner-all"
                      title="${Item.constraints.grupo.attributes.title}" noSelection="['null': '']"/>

        </div>
    </div>

</div>

<div class="fila span-20">

    <div class="${hasErrors(bean: itemInstance, field: 'observaciones', 'error')} ">
        <div class="span-3">
            <label for="observaciones">
                Observaciones
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  ui-corner-all" name="observaciones" maxlength="127" style="width: 350px"
                         value="${fieldValue(bean: itemInstance, field: 'observaciones')}" title='${Item.constraints.observaciones.attributes.title}'/>

        </div>
    </div>

</div>



</div>