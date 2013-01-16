

<ol class="property-list tipoEmpresa">
    
    <g:if test="${tipoEmpresaInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoEmpresa.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoEmpresaInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
