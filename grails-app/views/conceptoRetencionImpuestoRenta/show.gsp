

<ol class="property-list conceptoRetencionImpuestoRenta">
    
    <g:if test="${conceptoRetencionImpuestoRentaInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="conceptoRetencionImpuestoRenta.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${conceptoRetencionImpuestoRentaInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${conceptoRetencionImpuestoRentaInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="conceptoRetencionImpuestoRenta.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${conceptoRetencionImpuestoRentaInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
