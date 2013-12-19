

<ol class="property-list sustentoTributario">
    
    <g:if test="${sustentoTributarioInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="sustentoTributario.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${sustentoTributarioInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${sustentoTributarioInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="sustentoTributario.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${sustentoTributarioInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
</ol>
