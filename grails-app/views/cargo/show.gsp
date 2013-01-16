

<ol class="property-list cargo">
    
    <g:if test="${cargoInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="cargo.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${cargoInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${cargoInstance?.empresa}">
        <li class="fieldcontain">
            <span id="empresa-label" class="property-label"><g:message code="cargo.empresa.label" default="Empresa" /></span>
            
            <span class="property-value" aria-labelledby="empresa-label">
                %{--<g:link controller="empresa" action="show" id="${cargoInstance?.empresa?.id}">--}%
                    ${cargoInstance?.empresa?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${cargoInstance?.departamento}">
        <li class="fieldcontain">
            <span id="departamento-label" class="property-label"><g:message code="cargo.departamento.label" default="Departamento" /></span>
            
            <span class="property-value" aria-labelledby="departamento-label">
                %{--<g:link controller="departamento" action="show" id="${cargoInstance?.departamento?.id}">--}%
                    ${cargoInstance?.departamento?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${cargoInstance?.sueldo}">
        <li class="fieldcontain">
            <span id="sueldo-label" class="property-label"><g:message code="cargo.sueldo.label" default="Sueldo" /></span>
            
            <span class="property-value" aria-labelledby="sueldo-label"><g:fieldValue bean="${cargoInstance}" field="sueldo"/></span>
            
        </li>
    </g:if>
    
</ol>
