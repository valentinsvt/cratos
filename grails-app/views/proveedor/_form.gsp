<%@ page import="cratos.Proveedor" %>

<div class=" fila span-20">
    <div class="fila span-20">
        <div class="${hasErrors(bean: proveedorInstance, field: 'nombre', 'error')} required ">
            <div class="span-3">
                <label for="nombre">
                    Nombre
                </label>
            </div>

            <div class="span-6">
                <g:textField class="field  required ui-corner-all" id="nombre" name="nombre" maxlength="63"
                             style="width:250px"
                             value="${proveedorInstance?.nombre}"/>

            </div>
        </div>
    </div>

    <div class="fila span-20">
        <div class="${hasErrors(bean: proveedorInstance, field: 'ruc', 'error')} required">
            <div class="span-3">
                <label for="ruc">
                    Ruc
                </label>
            </div>

            <div class="span-6">
                <g:textField class="field  required  ui-corner-all number" id="ruc" name="ruc" maxlength="13"
                             minlength="10" style="width: 100px" required=""
                             value="${proveedorInstance?.ruc}"/>

            </div>
        </div>

    </div>

    <div class="fila span-20">
        <div class="${hasErrors(bean: proveedorInstance, field: 'tipoProveedor', 'error')} ">

            <div class="span-3">
                <label for="tipoProveedor">
                    Tipo Proveedor
                </label>
            </div>

            <div class="span-6">
                <g:select id="tipoProveedor" name="tipoProveedor.id" from="${cratos.TipoProveedor.list()}"
                          optionKey="id" optionValue="descripcion"
                          value="${proveedorInstance?.tipoProveedor?.id}" class="field  many-to-one ui-corner-all"
                          title="${Proveedor.constraints.tipoProveedor.attributes.title}"
                          noSelection="['null': '']"/>

            </div>
        </div>

        <div class="${hasErrors(bean: proveedorInstance, field: 'tipoPersona', 'error')} required">
            <div class="span-3 prepend-1">
                <label for="tipoPersona">
                    Tipo Persona
                </label>
            </div>

            <div class="span-6">
                <g:select id="tipoPersona" name="tipoPersona.id" from="${cratos.TipoPersona.list()}" optionKey="id"
                          optionValue="descripcion"
                          value="${proveedorInstance?.tipoPersona?.id}"
                          class="field  many-to-one ui-corner-all required"

                          noSelection="${['': '']}"/>

            </div>
        </div>

    </div>

    <div class="fila span-20">

        <div class=" ${hasErrors(bean: proveedorInstance, field: 'tipoIdentificacion', 'error')} required">
            <div class="span-3">
                <label for="tipoIdentificacion">
                    Tipo Identificación
                </label>
            </div>

            <div class="span-6">
                <g:select id="tipoIdentificacion" name="tipoIdentificacion.id"
                          from="${cratos.TipoIdentificacion.list()}" optionKey="id" optionValue="descripcion"
                          value="${proveedorInstance?.tipoIdentificacion?.id}"
                          class="field many-to-one ui-corner-all required"
                          noSelection="${['': '']}"/>

            </div>
        </div>

    </div>


    <div class="fila span-20">

        <div class="${hasErrors(bean: proveedorInstance, field: 'tipoRelacion', 'error')}">
            <div class="span-3">

                <label for="tipoRelacion">

                    Tipo Relación

                </label>

            </div>

            <div class="span-6">

                <g:select id="tipoRelacion" name="tipoRelacion.id" from="${cratos.TipoRelacion.list()}"
                          optionKey="id" optionValue="descripcion"
                          value="${proveedorInstance?.tipoRelacion?.id}"
                          class="field many-to-one ui-corner-all required"
                          noSelection="${['': '']}"/>

            </div>

        </div>

    </div>

    <div class="fila span-20">

        <div class="${hasErrors(bean: proveedorInstance, field: 'actividad', 'error')}">
            <div class="span-3">

                <label for="actividad">
                    Actividad

                </label>

            </div>

            <div class="span-6">

                <g:textField name="actividad" id="actividad" class="field ui-corner-all"
                             value="${proveedorInstance?.actividad}" title="Actividad Principal del Proveedor" maxlength="127" style="width: 600px"/>

            </div>

        </div>

    </div>

</div>

<div class="fila span-20">

    <div class="${hasErrors(bean: proveedorInstance, field: 'nombreContacto', 'error')} required">
        <div class="span-3">
            <label for="nombreContacto">
                Nombre Contacto
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  required  ui-corner-all" id="nombreContacto" name="nombreContacto" maxlength="63"
                         style="width: 250px" value="${proveedorInstance?.nombreContacto}"/>

        </div>
    </div>

</div>

<div class="fila span-20">
    <div class="${hasErrors(bean: proveedorInstance, field: 'apellidoContacto', 'error')} required">
        <div class="span-3">
            <label for="apellidoContacto">
                Apellido Contacto
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  required  ui-corner-all" id="apellidoContacto" name="apellidoContacto"
                         style="width: 250px" maxlength="63" value="${proveedorInstance?.apellidoContacto}"/>

        </div>
    </div>
</div>

<div class="fila span-20">

    <div class="${hasErrors(bean: proveedorInstance, field: 'nombreCheque', 'error')}">
        <div class="span-3">
            <label for="nombreCheque">

                Cheque a Nombre de

            </label>

        </div>

        <div class="span-6">

            <g:textField name="nombreCheque" id="nombreCheque" class="field ui-corner-all" style="width: 250px"
                         title="Cheque a nombre de" maxlength="40" value="${proveedorInstance?.nombreCheque}"/>

        </div>

    </div>

</div>

<div class="fila span-20">

    <div class="${hasErrors(bean: proveedorInstance, field: 'direccion', 'error')} ">
        <div class="span-3">
            <label for="direccion">
                Dirección
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  ui-corner-all" id="direccion" name="direccion" maxlength="127"
                         style="width: 600px" value="${proveedorInstance?.direccion}"
                         title="${Proveedor.constraints.direccion.attributes.title}"/>

        </div>
    </div>

</div>


<div class="fila span-20">

    <div class="${hasErrors(bean: proveedorInstance, field: 'telefono', 'error')}">

        <div class="span-3">
            <label for="telefono">
                Teléfono
            </label>

        </div>

        <div class="span-6">
            <g:textField class="field ui-corner-all number" id="telefono" name="telefono" style="width: 250px"
                         value="${proveedorInstance?.telefono}" title="Teléfono del Proveedor"/>

        </div>

    </div>

</div>

<div class="fila span-20">
    <div class="${hasErrors(bean: proveedorInstance, field: 'email', 'error')}">
        <div class="span-3">
            <label for="email">
                Email

            </label>

        </div>

        <div class="span-6">

            <g:textField name="email" id="email" class="field email ui-corner-all" value="${proveedorInstance?.email}"
                         style="width: 250px" maxlength="40" title="Email del Proveedor" type="email"/>

        </div>

    </div>

</div>

<div class="fila span-20">

    <div class="${hasErrors(bean: proveedorInstance, field: 'pais', 'error')}">
        <div class="span-3">
            <label for="pais">
                País

            </label>

        </div>

        <div class="span-6">

            <g:countrySelect class="field ui-corner-all" name="pais" id="pais"
                             value="${proveedorInstance?.pais}" noSelection="${['': '']}" title="País del Proveedor"/>

        </div>

    </div>

</div>


<div class="fila span-20">

    <div class="${hasErrors(bean: proveedorInstance, field: 'canton', 'error')}">
        <div class="span-3">
            <label for="canton" id="cantonLabel" style="display: none;">
                Cantón
            </label>
        </div>

        <div class="span-6">
            <g:select id="canton" name="canton.id" from="${cratos.Canton.list()}" optionKey="id"
                      optionValue="nombre" value="${proveedorInstance?.canton?.id}"
                      class="field many-to-one ui-corner-all"
                      noSelection="${['': '']}" style="display: none;" title="Cantón del Proveedor"/>

        </div>
    </div>

</div>


<div class="fila span-20">

    <div class="${hasErrors(bean: proveedorInstance, field: 'fecha', 'error')} ">
        <div class="span-3">
            <label for="fecha">
                Fecha
            </label>
        </div>

        <div class="span-6">
            <elm:datePicker format="yyyy-MM-dd" class="field ui-corner-all" id="fecha" style="width: 80px"
                            title="${Proveedor.constraints.fecha.attributes.title}" name="fecha" title="fecha" value="${proveedorInstance?.fecha}"/>

        </div>
    </div>
</div>

<div class="fila span-20">
    <div class="${hasErrors(bean: proveedorInstance, field: 'descuento', 'error')}">
        <div class="span-3">
            <label for="descuento">
                Descuento
            </label>
        </div>

        <div class="span-6">
            <g:field class="field  required number  ui-corner-all" type="number" name="descuento" id="descuento"
                     required="" title='${Proveedor.constraints.descuento.attributes.title}'
                     value="${fieldValue(bean: proveedorInstance, field: 'descuento')}" style="width: 100px"
                     maxlength="12"/>

        </div>
    </div>
</div>
<div class="fila span-20">
    <div class="${hasErrors(bean: proveedorInstance, field: 'autorizacionSri', 'error')} required">
        <div class="span-3">
            <label for="ruc">
                # Autorizacion Sri
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field    ui-corner-all number" id="autorizacionSri" name="autorizacionSri" maxlength="30"
                         minlength="10" style="width: 150px"
                         value="${proveedorInstance?.autorizacionSri}"/>

        </div>
    </div>

</div>


<div class="fila span-20">

    <div class="${hasErrors(bean: proveedorInstance, field: 'fechaCaducidad', 'error')} ">
        <div class="span-3">
            <label for="fecha">
                Fecha caducidad
            </label>
        </div>

        <div class="span-6">
            <elm:datePicker format="yyyy-MM-dd" class="field ui-corner-all" id="fechaCaducidad" style="width: 80px"
                           name="fechaCaducidad" title="fecha" value="${proveedorInstance?.fechaCaducidad}"/>

        </div>
    </div>
</div>

<div class="fila span-20">

    <div class="${hasErrors(bean: proveedorInstance, field: 'observaciones', 'error')} ">
        <div class="span-3">
            <label for="observaciones">
                Observaciones
            </label>
        </div>

        <div class="span-6">
            <g:textField class="field  ui-corner-all" name="observaciones" maxlength="127" id="observaciones"
                         style="width: 600px"
                         value="${proveedorInstance?.observaciones}"
                         title="${Proveedor.constraints.observaciones.attributes.title}"/>

        </div>
    </div>

</div>

<script type="text/javascript">


    $("#pais").change(function () {

        if ($(this).val() == 'ecu') {
            $("#canton").show();
            $("#cantonLabel").show();


        }
        else {
            $("#canton").hide();
            $("#cantonLabel").hide();

        }


    });

</script>

