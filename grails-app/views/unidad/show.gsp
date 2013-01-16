

<ol class="property-list unidad">
    
    <g:if test="${unidadInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="unidad.codigo.label" default="Código" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${unidadInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${unidadInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="unidad.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${unidadInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
