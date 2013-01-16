

<ol class="property-list tipoTarjeta">
    
    <g:if test="${tipoTarjetaInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoTarjeta.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoTarjetaInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
