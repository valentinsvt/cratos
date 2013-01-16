

<ol class="property-list tipoPersona">
    
    <g:if test="${tipoPersonaInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoPersona.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoPersonaInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoPersonaInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoPersona.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoPersonaInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
