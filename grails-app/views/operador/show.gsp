

<ol class="property-list operador">
    
    <g:if test="${operadorInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="operador.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${operadorInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${operadorInstance?.signo}">
        <li class="fieldcontain">
            <span id="signo-label" class="property-label"><g:message code="operador.signo.label" default="Signo" /></span>
            
            <span class="property-value" aria-labelledby="signo-label"><g:fieldValue bean="${operadorInstance}" field="signo"/></span>
            
        </li>
    </g:if>
    
</ol>
