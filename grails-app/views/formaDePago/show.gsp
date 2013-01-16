

<ol class="property-list formaDePago">
    
    <g:if test="${formaDePagoInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="formaDePago.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${formaDePagoInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${formaDePagoInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="formaDePago.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${formaDePagoInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
