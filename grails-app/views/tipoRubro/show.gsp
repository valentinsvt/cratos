

<ol class="property-list tipoRubro">
    
    <g:if test="${tipoRubroInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoRubro.codigo.label" default="Código" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoRubroInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoRubroInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoRubro.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoRubroInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
