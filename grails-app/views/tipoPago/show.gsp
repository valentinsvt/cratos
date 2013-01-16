

<ol class="property-list tipoPago">
    
    <g:if test="${tipoPagoInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoPago.codigo.label" default="Código" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoPagoInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoPagoInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoPago.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoPagoInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
