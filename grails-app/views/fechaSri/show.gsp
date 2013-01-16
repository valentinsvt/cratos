

<ol class="property-list fechaSri">
    
    <g:if test="${fechaSriInstance?.numero}">
        <li class="fieldcontain">
            <span id="numero-label" class="property-label"><g:message code="fechaSri.numero.label" default="Numero" /></span>
            
            <span class="property-value" aria-labelledby="numero-label"><g:fieldValue bean="${fechaSriInstance}" field="numero"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${fechaSriInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="fechaSri.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${fechaSriInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
