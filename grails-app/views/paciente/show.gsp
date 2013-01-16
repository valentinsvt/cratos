<ol class="property-list proveedor">

    <g:if test="${pacienteInstance?.nombreContacto}">
        <li class="fieldcontain">
            <span id="nombreContacto-label" class="property-label"><g:message code="proveedor.nombreContacto.label"
                                                                              default="Nombre Contacto"/></span>

            <span class="property-value" aria-labelledby="nombreContacto-label"><g:fieldValue bean="${pacienteInstance}"
                                                                                              field="nombreContacto"/></span>

        </li>
    </g:if>

    <g:if test="${pacienteInstance?.apellidoContacto}">
        <li class="fieldcontain">
            <span id="apellidoContacto-label" class="property-label"><g:message code="proveedor.apellidoContacto.label"
                                                                                default="Apellido Contacto"/></span>

            <span class="property-value" aria-labelledby="apellidoContacto-label"><g:fieldValue
                    bean="${pacienteInstance}" field="apellidoContacto"/></span>

        </li>
    </g:if>

    <g:if test="${pacienteInstance?.ruc}">
        <li class="fieldcontain">
            <span id="ruc-label" class="property-label"><g:message code="proveedor.ruc.label" default="Ruc"/></span>

            <span class="property-value" aria-labelledby="ruc-label"><g:fieldValue bean="${pacienteInstance}"
                                                                                   field="ruc"/></span>

        </li>
    </g:if>


    <g:if test="${pacienteInstance?.tipoProveedor}">
        <li class="fieldcontain">
            <span id="tipoProveedor-label" class="property-label"><g:message code="proveedor.tipoProveedor.label"
                                                                             default="Tipo Proveedor"/></span>

            <span class="property-value" aria-labelledby="tipoProveedor-label">

                ${pacienteInstance?.tipoProveedor?.descripcion?.encodeAsHTML()}

            </span>

        </li>
    </g:if>

    <g:if test="${pacienteInstance?.tipoPersona}">
        <li class="fieldcontain">
            <span id="tipoPersona-label" class="property-label"><g:message code="proveedor.tipoPersona.label"
                                                                           default="Tipo Persona"/></span>

            <span class="property-value" aria-labelledby="tipoPersona-label">

                ${pacienteInstance?.tipoPersona?.descripcion?.encodeAsHTML()}

            </span>

        </li>
    </g:if>



    <g:if test="${pacienteInstance?.tipoIdentificacion}">
        <li class="fieldcontain">
            <span id="tipoIdentificacion-label" class="property-label"><g:message
                    code="proveedor.tipoIdentificacion.label" default="Tipo Identificacion"/></span>

            <span class="property-value" aria-labelledby="tipoIdentificacion-label">

                ${pacienteInstance?.tipoIdentificacion?.descripcion?.encodeAsHTML()}

            </span>

        </li>
    </g:if>

    <g:if test="${pacienteInstance?.canton}">
        <li class="fieldcontain">
            <span id="canton-label" class="property-label"><g:message code="proveedor.canton.label"
                                                                      default="Canton"/></span>

            <span class="property-value" aria-labelledby="canton-label">

                ${pacienteInstance?.canton?.nombre?.encodeAsHTML()}

            </span>

        </li>
    </g:if>


    <g:if test="${pacienteInstance?.direccion}">
        <li class="fieldcontain">
            <span id="direccion-label" class="property-label"><g:message code="proveedor.direccion.label"
                                                                         default="Direccion"/></span>

            <span class="property-value" aria-labelledby="direccion-label"><g:fieldValue bean="${pacienteInstance}"
                                                                                         field="direccion"/></span>

        </li>
    </g:if>

    <g:if test="${pacienteInstance?.telefono}">
        <li class="fieldcontain">
            <span id="telefono-label" class="property-label"><g:message code="proveedor.telefono.label"
                                                                        default="Telefono"/></span>

            <span class="property-value" aria-labelledby="telefono-label"><g:fieldValue bean="${pacienteInstance}"
                                                                                        field="telefono"/></span>

        </li>
    </g:if>

    <g:if test="${pacienteInstance?.fecha}">
        <li class="fieldcontain">
            <span id="fecha-label" class="property-label"><g:message code="proveedor.fecha.label"
                                                                     default="Fecha"/></span>

            <span class="property-value" aria-labelledby="fecha-label"><g:formatDate date="${pacienteInstance?.fecha}"
                                                                                     format="yyyy-MM-dd"/></span>

        </li>
    </g:if>

    <g:if test="${pacienteInstance?.descuento}">
        <li class="fieldcontain">
            <span id="descuento-label" class="property-label"><g:message code="proveedor.descuento.label"
                                                                         default="Descuento"/></span>

            <span class="property-value" aria-labelledby="descuento-label"><g:fieldValue bean="${pacienteInstance}"
                                                                                         field="descuento"/></span>

        </li>
    </g:if>

    <g:if test="${pacienteInstance?.observaciones}">
        <li class="fieldcontain">
            <span id="observaciones-label" class="property-label"><g:message code="proveedor.observaciones.label"
                                                                             default="Observaciones"/></span>

            <span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${pacienteInstance}"
                                                                                             field="observaciones"/></span>

        </li>
    </g:if>



</ol>
