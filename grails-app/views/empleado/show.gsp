

<ol class="property-list empleado">
    
    <g:if test="${empleadoInstance?.porcentajeComision}">
        <li class="fieldcontain">
            <span id="porcentajeComision-label" class="property-label"><g:message code="empleado.porcentajeComision.label" default="Porcentaje Comision" /></span>
            
            <span class="property-value" aria-labelledby="porcentajeComision-label"><g:fieldValue bean="${empleadoInstance}" field="porcentajeComision"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.foto}">
        <li class="fieldcontain">
            <span id="foto-label" class="property-label"><g:message code="empleado.foto.label" default="Foto" /></span>
            
            <span class="property-value" aria-labelledby="foto-label"><g:fieldValue bean="${empleadoInstance}" field="foto"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.estado}">
        <li class="fieldcontain">
            <span id="estado-label" class="property-label"><g:message code="empleado.estado.label" default="Estado" /></span>
            
            <span class="property-value" aria-labelledby="estado-label"><g:fieldValue bean="${empleadoInstance}" field="estado"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.fechaFin}">
        <li class="fieldcontain">
            <span id="fechaFin-label" class="property-label"><g:message code="empleado.fechaFin.label" default="Fecha Fin" /></span>
            
            <span class="property-value" aria-labelledby="fechaFin-label"><g:formatDate date="${empleadoInstance?.fechaFin}" /></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.fechaInicio}">
        <li class="fieldcontain">
            <span id="fechaInicio-label" class="property-label"><g:message code="empleado.fechaInicio.label" default="Fecha Inicio" /></span>
            
            <span class="property-value" aria-labelledby="fechaInicio-label"><g:formatDate date="${empleadoInstance?.fechaInicio}" /></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.sueldo}">
        <li class="fieldcontain">
            <span id="sueldo-label" class="property-label"><g:message code="empleado.sueldo.label" default="Sueldo" /></span>
            
            <span class="property-value" aria-labelledby="sueldo-label"><g:fieldValue bean="${empleadoInstance}" field="sueldo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.cuenta}">
        <li class="fieldcontain">
            <span id="cuenta-label" class="property-label"><g:message code="empleado.cuenta.label" default="Cuenta" /></span>
            
            <span class="property-value" aria-labelledby="cuenta-label"><g:fieldValue bean="${empleadoInstance}" field="cuenta"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.email}">
        <li class="fieldcontain">
            <span id="email-label" class="property-label"><g:message code="empleado.email.label" default="Email" /></span>
            
            <span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${empleadoInstance}" field="email"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.telefono}">
        <li class="fieldcontain">
            <span id="telefono-label" class="property-label"><g:message code="empleado.telefono.label" default="Telefono" /></span>
            
            <span class="property-value" aria-labelledby="telefono-label"><g:fieldValue bean="${empleadoInstance}" field="telefono"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.hijo}">
        <li class="fieldcontain">
            <span id="hijo-label" class="property-label"><g:message code="empleado.hijo.label" default="Hijo" /></span>
            
            <span class="property-value" aria-labelledby="hijo-label"><g:fieldValue bean="${empleadoInstance}" field="hijo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.iess}">
        <li class="fieldcontain">
            <span id="iess-label" class="property-label"><g:message code="empleado.iess.label" default="Iess" /></span>
            
            <span class="property-value" aria-labelledby="iess-label"><g:fieldValue bean="${empleadoInstance}" field="iess"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.numero}">
        <li class="fieldcontain">
            <span id="numero-label" class="property-label"><g:message code="empleado.numero.label" default="Numero" /></span>
            
            <span class="property-value" aria-labelledby="numero-label"><g:fieldValue bean="${empleadoInstance}" field="numero"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.tipoContrato}">
        <li class="fieldcontain">
            <span id="tipoContrato-label" class="property-label"><g:message code="empleado.tipoContrato.label" default="Tipo Contrato" /></span>
            
            <span class="property-value" aria-labelledby="tipoContrato-label">
                %{--<g:link controller="tipoContrato" action="show" id="${empleadoInstance?.tipoContrato?.id}">--}%
                    ${empleadoInstance?.tipoContrato?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.cargo}">
        <li class="fieldcontain">
            <span id="cargo-label" class="property-label"><g:message code="empleado.cargo.label" default="Cargo" /></span>
            
            <span class="property-value" aria-labelledby="cargo-label">
                %{--<g:link controller="cargo" action="show" id="${empleadoInstance?.cargo?.id}">--}%
                    ${empleadoInstance?.cargo?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.persona}">
        <li class="fieldcontain">
            <span id="persona-label" class="property-label"><g:message code="empleado.persona.label" default="Persona" /></span>
            
            <span class="property-value" aria-labelledby="persona-label">
                %{--<g:link controller="persona" action="show" id="${empleadoInstance?.persona?.id}">--}%
                    ${empleadoInstance?.persona?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.canton}">
        <li class="fieldcontain">
            <span id="canton-label" class="property-label"><g:message code="empleado.canton.label" default="Canton" /></span>
            
            <span class="property-value" aria-labelledby="canton-label">
                %{--<g:link controller="canton" action="show" id="${empleadoInstance?.canton?.id}">--}%
                    ${empleadoInstance?.canton?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.crgo}">
        <li class="fieldcontain">
            <span id="crgo-label" class="property-label"><g:message code="empleado.crgo.label" default="Crgo" /></span>
            
            <span class="property-value" aria-labelledby="crgo-label"><g:fieldValue bean="${empleadoInstance}" field="crgo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empleadoInstance?.observaciones}">
        <li class="fieldcontain">
            <span id="observaciones-label" class="property-label"><g:message code="empleado.observaciones.label" default="Observaciones" /></span>
            
            <span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${empleadoInstance}" field="observaciones"/></span>
            
        </li>
    </g:if>
    
</ol>
