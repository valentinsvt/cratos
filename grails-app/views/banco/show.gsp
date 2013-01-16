

<ol class="property-list banco">
    
    <g:if test="${bancoInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="banco.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${bancoInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${bancoInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="banco.codigo.label" default="Código" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${bancoInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${bancoInstance?.empresa}">
        <li class="fieldcontain">
            <span id="empresa-label" class="property-label"><g:message code="banco.empresa.label" default="Empresa" /></span>
            
            <span class="property-value" aria-labelledby="empresa-label">
                %{--<g:link controller="empresa" action="show" id="${bancoInstance?.empresa?.id}">--}%
                    ${bancoInstance?.empresa?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
</ol>
