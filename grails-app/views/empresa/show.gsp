

<ol class="property-list empresa">

    <g:if test="${empresaInstance?.nombre}">
        <li class="fieldcontain">
            <span id="nombre-label" class="property-label"><g:message code="empresa.nombre.label" default="Nombre" /></span>

            <span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${empresaInstance}" field="nombre"/></span>

        </li>
    </g:if>

    <g:if test="${empresaInstance?.ruc}">
        <li class="fieldcontain">
            <span id="ruc-label" class="property-label"><g:message code="empresa.ruc.label" default="Ruc" /></span>

            <span class="property-value" aria-labelledby="ruc-label"><g:fieldValue bean="${empresaInstance}" field="ruc"/></span>

        </li>
    </g:if>

    <g:if test="${empresaInstance?.tipoEmpresa}">
        <li class="fieldcontain">
            <span id="tipoEmpresa-label" class="property-label"><g:message code="empresa.tipoEmpresa.label" default="Tipo Empresa" /></span>

            <span class="property-value" aria-labelledby="tipoEmpresa-label">

                ${empresaInstance?.tipoEmpresa?.encodeAsHTML()}

            </span>

        </li>
    </g:if>

    <g:if test="${empresaInstance?.direccion}">
        <li class="fieldcontain">
            <span id="direccion-label" class="property-label"><g:message code="empresa.direccion.label" default="Direccion" /></span>

            <span class="property-value" aria-labelledby="direccion-label"><g:fieldValue bean="${empresaInstance}" field="direccion"/></span>

        </li>
    </g:if>


    <g:if test="${empresaInstance?.telefono}">
        <li class="fieldcontain">
            <span id="telefono-label" class="property-label"><g:message code="empresa.telefono.label" default="Telefono" /></span>

            <span class="property-value" aria-labelledby="telefono-label"><g:fieldValue bean="${empresaInstance}" field="telefono"/></span>

        </li>
    </g:if>



    <g:if test="${empresaInstance?.email}">
        <li class="fieldcontain">
            <span id="email-label" class="property-label"><g:message code="empresa.email.label" default="Email" /></span>
            
            <span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${empresaInstance}" field="email"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empresaInstance?.fechaFin}">
        <li class="fieldcontain">
            <span id="fechaFin-label" class="property-label"><g:message code="empresa.fechaFin.label" default="Fecha Fin" /></span>
            
            <span class="property-value" aria-labelledby="fechaFin-label"><g:formatDate date="${empresaInstance?.fechaFin}" format="yyyy-MM-dd"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empresaInstance?.fechaInicio}">
        <li class="fieldcontain">
            <span id="fechaInicio-label" class="property-label"><g:message code="empresa.fechaInicio.label" default="Fecha Inicio" /></span>
            
            <span class="property-value" aria-labelledby="fechaInicio-label"><g:formatDate date="${empresaInstance?.fechaInicio}" format="yyyy-MM-dd"/></span>
            
        </li>
    </g:if>

    <g:if test="${empresaInstance?.canton}">
        <li class="fieldcontain">
            <span id="canton-label" class="property-label"><g:message code="empresa.canton.label" default="Canton" /></span>
            
            <span class="property-value" aria-labelledby="canton-label">
               ${empresaInstance?.canton?.nombre?.encodeAsHTML()}

            </span>
            
        </li>
    </g:if>
    

    
    <g:if test="${empresaInstance?.sigla}">
        <li class="fieldcontain">
            <span id="sigla-label" class="property-label"><g:message code="empresa.sigla.label" default="Sigla" /></span>
            
            <span class="property-value" aria-labelledby="sigla-label"><g:fieldValue bean="${empresaInstance}" field="sigla"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${empresaInstance?.periodosContables}">
        <li class="fieldcontain">
            <span id="periodosContables-label" class="property-label"><g:message code="empresa.periodosContables.label" default="Periodos Contables" /></span>
            
            <g:each in="${empresaInstance.periodosContables}" var="p">
                <span class="property-value" aria-labelledby="periodosContables-label">
                    %{--<g:link controller="contabilidad" action="show" id="${p.id}">--}%
                        ${p?.encodeAsHTML()}
                    %{--</g:link>--}%
                </span>
            </g:each>
            
        </li>
    </g:if>
    
</ol>
