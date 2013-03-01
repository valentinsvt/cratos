<ol class="property-list proveedor">

<g:if test="${proveedorInstance?.empresa}">
    <li class="fieldcontain">
        <span id="empresa-label" class="property-label"><g:message code="proveedor.empresa.label"
                                                                   default="Empresa"/></span>

        <span class="property-value" aria-labelledby="empresa-label">

            ${proveedorInstance?.empresa?.nombre?.encodeAsHTML()}

        </span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.nombre}">
    <li class="fieldcontain">
        <span id="nombre-label" class="property-label"><g:message code="proveedor.nombre.label"
                                                                  default="Nombre del Proveedor"/></span>

        <span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${proveedorInstance}"
                                                                                  field="nombre"/></span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.ruc}">
    <li class="fieldcontain">
        <span id="ruc-label" class="property-label"><g:message code="proveedor.ruc.label" default="Ruc"/></span>

        <span class="property-value" aria-labelledby="ruc-label"><g:fieldValue bean="${proveedorInstance}"
                                                                               field="ruc"/></span>

    </li>
</g:if>



<g:if test="${proveedorInstance?.nombreContacto}">
    <li class="fieldcontain">
        <span id="nombreContacto-label" class="property-label"><g:message code="proveedor.nombreContacto.label"
                                                                          default="Nombre Contacto"/></span>

        <span class="property-value" aria-labelledby="nombreContacto-label"><g:fieldValue
                bean="${proveedorInstance}" field="nombreContacto"/></span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.apellidoContacto}">
    <li class="fieldcontain">
        <span id="apellidoContacto-label" class="property-label"><g:message code="proveedor.apellidoContacto.label"
                                                                            default="Apellido Contacto"/></span>

        <span class="property-value" aria-labelledby="apellidoContacto-label"><g:fieldValue
                bean="${proveedorInstance}" field="apellidoContacto"/></span>

    </li>
</g:if>


<g:if test="${proveedorInstance?.tipoProveedor}">
    <li class="fieldcontain">
        <span id="tipoProveedor-label" class="property-label"><g:message code="proveedor.tipoProveedor.label"
                                                                         default="Tipo Proveedor"/></span>

        <span class="property-value" aria-labelledby="tipoProveedor-label">

            ${proveedorInstance?.tipoProveedor?.descripcion?.encodeAsHTML()}

        </span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.tipoPersona}">
    <li class="fieldcontain">
        <span id="tipoPersona-label" class="property-label"><g:message code="proveedor.tipoPersona.label"
                                                                       default="Tipo Persona"/></span>

        <span class="property-value" aria-labelledby="tipoPersona-label">

            ${proveedorInstance?.tipoPersona?.descripcion?.encodeAsHTML()}

        </span>

    </li>
</g:if>



<g:if test="${proveedorInstance?.tipoIdentificacion}">
    <li class="fieldcontain">
        <span id="tipoIdentificacion-label" class="property-label"><g:message
                code="proveedor.tipoIdentificacion.label" default="Tipo Identificación"/></span>

        <span class="property-value" aria-labelledby="tipoIdentificacion-label">

            ${proveedorInstance?.tipoIdentificacion?.descripcion?.encodeAsHTML()}

        </span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.actividad}">
    <li class="fieldcontain">

        <span id="actividad-label" class="property-label">

            <g:message code="proveedor.actividad.label" default="Actividad"/>

        </span>

        <span class="property-value" aria-labelledby="actividad-label">

            ${proveedorInstance?.actividad?.encodeAsHTML()}

        </span>

    </li>

</g:if>

<g:if test="${proveedorInstance?.nombreCheque}">
    <li class="fieldcontain">

        <span id="nombreCheque-label" class="property-label">

            <g:message code="proveedor.nombreCheque.label" default="Cheque a Nombre de"/>

        </span>

        <span class="property-value" aria-labelledby="nombreCheque">

            ${proveedorInstance?.nombreCheque?.encodeAsHTML()}

        </span>

    </li>

</g:if>

<g:if test="${proveedorInstance?.direccion}">
    <li class="fieldcontain">
        <span id="direccion-label" class="property-label"><g:message code="proveedor.direccion.label"
                                                                     default="Dirección"/></span>

        <span class="property-value" aria-labelledby="direccion-label"><g:fieldValue bean="${proveedorInstance}"
                                                                                     field="direccion"/></span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.telefono}">
    <li class="fieldcontain">
        <span id="telefono-label" class="property-label"><g:message code="proveedor.telefono.label"
                                                                    default="Teléfono"/></span>

        <span class="property-value" aria-labelledby="telefono-label"><g:fieldValue bean="${proveedorInstance}"
                                                                                    field="telefono"/></span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.email}">
    <li class="fieldcontain">
        <span id="email-label" class="property-label">

            <g:message code="proveedor.email.label" default="Email"/>

        </span>

        <span class="property-value" aria-labelledby="email-label">
            <g:fieldValue bean="${proveedorInstance}" field="email"/>

        </span>

    </li>

</g:if>

<g:if test="${proveedorInstance?.pais}">
    <li class="fieldcontain">
        <span id="pais-label" class="property-label"><g:message code="proveedor.pais.label" default="País"/></span>
        <span class="property-value" aria-labelledby="pais-label">

            ${country(code: fieldValue(bean: proveedorInstance, field: "pais"))}

        </span>

    </li>

</g:if>

<g:if test="${proveedorInstance?.canton}">
    <li class="fieldcontain">
        <span id="canton-label" class="property-label"><g:message code="proveedor.canton.label"
                                                                  default="Cantón"/></span>

        <span class="property-value" aria-labelledby="canton-label">

            ${proveedorInstance?.canton?.nombre?.encodeAsHTML()}

        </span>

    </li>
</g:if>


<g:if test="${proveedorInstance?.fecha}">
    <li class="fieldcontain">
        <span id="fecha-label" class="property-label"><g:message code="proveedor.fecha.label"
                                                                 default="Fecha"/></span>

        <span class="property-value" aria-labelledby="fecha-label"><g:formatDate date="${proveedorInstance?.fecha}"
                                                                                 format="yyyy-MM-dd"/></span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.descuento}">
    <li class="fieldcontain">
        <span id="descuento-label" class="property-label"><g:message code="proveedor.descuento.label"
                                                                     default="Descuento"/></span>

        <span class="property-value" aria-labelledby="descuento-label"><g:fieldValue bean="${proveedorInstance}"
                                                                                     field="descuento"/></span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.estado}">
    <li class="fieldcontain">
        <span id="estado-label" class="property-label"><g:message code="proveedor.estado.label"
                                                                  default="Estado"/></span>

        <span class="property-value" aria-labelledby="estado-label"><g:fieldValue bean="${proveedorInstance}"
                                                                                  field="estado"/></span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.observaciones}">
    <li class="fieldcontain">
        <span id="observaciones-label" class="property-label"><g:message code="proveedor.observaciones.label"
                                                                         default="Observaciones"/></span>

        <span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${proveedorInstance}"
                                                                                         field="observaciones"/></span>

    </li>
</g:if>

<g:if test="${proveedorInstance?.autorizacionSri}">
    <li class="fieldcontain">
        <span id="observaciones-label" class="property-label"># Autorización Sri</span>

        <span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${proveedorInstance}"
                                                                                         field="autorizacionSri"/></span>

    </li>
</g:if>
<g:if test="${proveedorInstance?.fechaCaducidad}">
    <li class="fieldcontain">
        <span id="observaciones-label" class="property-label">Fecha caducidad</span>

        <span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${proveedorInstance}"
                                                                                         field="fechaCaducidad"/></span>

    </li>
</g:if>
<g:if test="${proveedorInstance?.observaciones}">
    <li class="fieldcontain">
        <span id="observaciones-label" class="property-label"><g:message code="proveedor.observaciones.label"
                                                                         default="Observaciones"/></span>

        <span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${proveedorInstance}"
                                                                                         field="observaciones"/></span>

    </li>
</g:if>

</ol>

