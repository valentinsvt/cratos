

<ol class="property-list activoFijo">



    <g:if test="${activoFijoInstance?.item}">
        <li class="fieldcontain">
            <span id="item-label" class="property-label"><g:message code="activoFijo.item.label" default="Item" /></span>

            <span class="property-value" aria-labelledby="item-label">

                ${activoFijoInstance?.item?.nombre?.encodeAsHTML()}

            </span>

        </li>
    </g:if>

    <g:if test="${activoFijoInstance?.modelo}">
        <li class="fieldcontain">
            <span id="modelo-label" class="property-label"><g:message code="activoFijo.modelo.label" default="Modelo" /></span>

            <span class="property-value" aria-labelledby="modelo-label"><g:fieldValue bean="${activoFijoInstance}" field="modelo"/></span>

        </li>
    </g:if>

    <g:if test="${activoFijoInstance?.serie}">
        <li class="fieldcontain">
            <span id="serie-label" class="property-label"><g:message code="activoFijo.serie.label" default="Serie" /></span>

            <span class="property-value" aria-labelledby="serie-label"><g:fieldValue bean="${activoFijoInstance}" field="serie"/></span>

        </li>
    </g:if>

    <g:if test="${activoFijoInstance?.color}">
        <li class="fieldcontain">
            <span id="color-label" class="property-label"><g:message code="activoFijo.color.label" default="Color" /></span>

            <span class="property-value" aria-labelledby="color-label">

                ${activoFijoInstance?.color?.descripcion?.encodeAsHTML()}

            </span>

        </li>
    </g:if>



    <g:if test="${activoFijoInstance?.periodoDepreciacion}">
        <li class="fieldcontain">
            <span id="periodoDepreciacion-label" class="property-label"><g:message code="activoFijo.periodoDepreciacion.label" default="Periodo Depreciacion" /></span>

            <span class="property-value" aria-labelledby="periodoDepreciacion-label"><g:fieldValue bean="${activoFijoInstance}" field="periodoDepreciacion"/></span>

        </li>
    </g:if>


    <g:if test="${activoFijoInstance?.fechaInicio}">
        <li class="fieldcontain">
            <span id="fechaInicio-label" class="property-label"><g:message code="activoFijo.fechaInicio.label" default="Fecha Inicio" /></span>
            
            <span class="property-value" aria-labelledby="fechaInicio-label"><g:formatDate date="${activoFijoInstance?.fechaInicio}" format="yyyy-MM-dd"/></span>
            
        </li>
    </g:if>
    

    


    <g:if test="${activoFijoInstance?.fechaAdquisicion}">
        <li class="fieldcontain">
            <span id="fechaAdquisicion-label" class="property-label"><g:message code="activoFijo.fechaAdquisicion.label" default="Fecha Adquisicion" /></span>
            
            <span class="property-value" aria-labelledby="fechaAdquisicion-label"><g:formatDate date="${activoFijoInstance?.fechaAdquisicion}" format="yyyy-MM-dd" /></span>
            
        </li>
    </g:if>
    

    
    <g:if test="${activoFijoInstance?.observaciones}">
        <li class="fieldcontain">
            <span id="observaciones-label" class="property-label"><g:message code="activoFijo.observaciones.label" default="Observaciones" /></span>
            
            <span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${activoFijoInstance}" field="observaciones"/></span>
            
        </li>
    </g:if>
    
</ol>
