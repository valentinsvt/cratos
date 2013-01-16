

<ol class="property-list documentoProveedor">
    
    <g:if test="${documentoProveedorInstance?.proceso}">
        <li class="fieldcontain">
            <span id="proceso-label" class="property-label"><g:message code="documentoProveedor.proceso.label" default="Proceso" /></span>
            
            <span class="property-value" aria-labelledby="proceso-label">
                %{--<g:link controller="proceso" action="show" id="${documentoProveedorInstance?.proceso?.id}">--}%
                    ${documentoProveedorInstance?.proceso?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${documentoProveedorInstance?.tipoDepartamento}">
        <li class="fieldcontain">
            <span id="tipoDepartamento-label" class="property-label"><g:message code="documentoProveedor.tipoDepartamento.label" default="Tipo Departamento" /></span>
            
            <span class="property-value" aria-labelledby="tipoDepartamento-label">
                %{--<g:link controller="tipoDocumentoProveedor" action="show" id="${documentoProveedorInstance?.tipoDepartamento?.id}">--}%
                    ${documentoProveedorInstance?.tipoDepartamento?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${documentoProveedorInstance?.numero}">
        <li class="fieldcontain">
            <span id="numero-label" class="property-label"><g:message code="documentoProveedor.numero.label" default="Numero" /></span>
            
            <span class="property-value" aria-labelledby="numero-label"><g:fieldValue bean="${documentoProveedorInstance}" field="numero"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${documentoProveedorInstance?.autorizacionSRI}">
        <li class="fieldcontain">
            <span id="autorizacionSRI-label" class="property-label"><g:message code="documentoProveedor.autorizacionSRI.label" default="Autorizacion SRI" /></span>
            
            <span class="property-value" aria-labelledby="autorizacionSRI-label"><g:fieldValue bean="${documentoProveedorInstance}" field="autorizacionSRI"/></span>
            
        </li>
    </g:if>
    
</ol>
