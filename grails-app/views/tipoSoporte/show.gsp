

<ol class="property-list tipoSoporte">
    
    <g:if test="${tipoSoporteInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoSoporte.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoSoporteInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoSoporteInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoSoporte.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoSoporteInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
