<%@ page import="cratos.Proveedor" %>


    <div class="fila span-20">

        <div class="${hasErrors(bean: pacienteInstance, field: 'nombreContacto', 'error')} required">
            <div class="span-3">
                <label for="nombreContacto">
                    Nombre
                </label>
            </div>

            <div class="span-6">
                <g:textField class="field  required  ui-corner-all" id="nombreContacto" name="nombreContacto" maxlength="63"
                             style="width: 300px" value="${pacienteInstance?.nombreContacto}"
                />

            </div>
        </div>

    </div>
     <div class="fila span-20">
        <div class="${hasErrors(bean: pacienteInstance, field: 'apellidoContacto', 'error')} required">
            <div class="span-3">
                <label for="apellidoContacto">
                    Apellido
                </label>
            </div>

            <div class="span-6">
                <g:textField class="field  required  ui-corner-all" id="apellidoContacto" name="apellidoContacto"
                             style="width: 300px" maxlength="63" value="${pacienteInstance?.apellidoContacto}"
                />

            </div>
        </div>

     </div>



    <div class="fila span-20">
        <div class="${hasErrors(bean: pacienteInstance, field: 'ruc', 'error')} required">
            <div class="span-3">
                <label for="ruc">
                    Ruc
                </label>
            </div>

            <div class="span-6">
                <g:textField class="field  required number ui-corner-all" id="ruc" name="ruc" maxlength="13" style="width: 100px" required=""
                             value="${pacienteInstance?.ruc}" />

            </div>
        </div>

    </div>


<div class="fila span-20">

    <div class="${hasErrors(bean: pacienteInstance, field: 'direccion', 'error')} ">
        <div class="span-3">
            <label for="direccion">
                Dirección
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  ui-corner-all" id="direccion" name="direccion" maxlength="127"
                         style="width: 300px" value="${pacienteInstance?.direccion}"
                         title="${Proveedor.constraints.direccion.attributes.title}"/>

        </div>
    </div>

</div>


<div class="fila span-20">

    <div class="${hasErrors(bean: pacienteInstance, field: 'telefono', 'error')}">

        <div class="span-3">
            <label for="telefono">
                Teléfono
            </label>

        </div>
        <div class="span-6">
            <g:textField class="field ui-corner-all number" id="telefono" name="telefono" style="width: 300px"
                         value="${pacienteInstance?.telefono}"/>

        </div>

    </div>

</div>


<div class="fila span-20">

    <div class="${hasErrors(bean: pacienteInstance, field: 'canton', 'error')}">
        <div class="span-3">
            <label for="canton">
                Cantón
            </label>
        </div>

        <div class="span-6">
            <g:select id="canton" name="canton.id" from="${cratos.Canton.list()}" optionKey="id" optionValue="nombre" value="${pacienteInstance?.canton?.id}"
                      class="field many-to-one ui-corner-all"
                      title="${Proveedor.constraints.canton.attributes.title}"
                      noSelection="${['null': '']}"/>

        </div>
    </div>

</div>


<div class="fila span-20">

    <div class="${hasErrors(bean: pacienteInstance, field: 'fecha', 'error')} ">
        <div class="span-3">
            <label for="fecha">
                Fecha
            </label>
        </div>

        <div class="span-6">
            <elm:datePicker format="yyyy-MM-dd" class="field ui-corner-all" id="fecha" style="width: 80px"
                            title="${Proveedor.constraints.fecha.attributes.title}" name="fecha" title="fecha"/>

        </div>
    </div>
</div>
<div class="fila span-20">
    <div class="${hasErrors(bean: pacienteInstance, field: 'descuento', 'error')}">
        <div class="span-3">
            <label for="descuento">
                Descuento
            </label>
        </div>

        <div class="span-6">
            <g:field class="field ui-corner-all" type="number" name="descuento" id="descuento"
                     title='${Proveedor.constraints.descuento.attributes.title}'
                     value="${fieldValue(bean: pacienteInstance, field: 'descuento')}" style="width: 100px" maxlength="12"/>

        </div>
    </div>
</div>



<div class="fila span-20">

    <div class="${hasErrors(bean: pacienteInstance, field: 'observaciones', 'error')} ">
        <div class="span-3">
            <label for="observaciones">
                Observaciones
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  ui-corner-all" name="observaciones" maxlength="127" id="observaciones" style="width: 300px"
                         value="${pacienteInstance?.observaciones}"
                         title="${Proveedor.constraints.observaciones.attributes.title}" />

        </div>
    </div>

</div>

<div class="fila span-20">

    <div class="${hasErrors(bean: proveedorInstance, field: 'tipoProveedor', 'error')} ">

        <div class="span-6">
            <g:hiddenField id="tipoProveedor" name="tipoProveedor.id" from="${cratos.TipoProveedor.list()}"
                      optionKey="id" optionValue="descripcion"
                      value="1"
                      class="field  many-to-one ui-corner-all"
                      title="${Proveedor.constraints.tipoProveedor.attributes.title}"
                      />

        </div>
    </div>
 </div>

<div class="fila span-20">
    <div class="${hasErrors(bean: proveedorInstance, field: 'tipoPersona', 'error')}">

        <div class="span-6">
            <g:hiddenField id="tipoPersona" name="tipoPersona.id" from="${cratos.TipoPersona.list()}" optionKey="id"
                      required="" optionValue="descripcion"
                      value="1"
                      class="field  many-to-one ui-corner-all"
                      title="${Proveedor.constraints.tipoPersona.attributes.title}"
                      />

        </div>
    </div>

</div>

<div class="fila span-20">
    <div class=" ${hasErrors(bean: proveedorInstance, field: 'tipoIdentificacion', 'error')}">

        <div class="span-6">
            <g:hiddenField id="tipoIdentificacion" name="tipoIdentificacion.id"
                      from="${cratos.TipoIdentificacion.list()}" optionKey="id" optionValue="descripcion"
                      value="2"
                      class="field many-to-one ui-corner-all"
                      />

        </div>
    </div>
 </div>






