

<ol class="property-list centroCosto">
    
    %{--<g:if test="${centroCostoInstance?.empresa}">--}%
        %{--<li class="fieldcontain">--}%
            %{--<span id="empresa-label" class="property-label"><g:message code="centroCosto.empresa.label" default="Empresa" /></span>--}%
            %{----}%
            %{--<span class="property-value" aria-labelledby="empresa-label">--}%
                %{--<g:link controller="empresa" action="show" id="${centroCostoInstance?.empresa?.id}">--}%
                    %{--${centroCostoInstance?.empresa?.encodeAsHTML()}--}%
                %{--</g:link>--}%
            %{--</span>--}%
            %{----}%
        %{--</li>--}%
    %{--</g:if>--}%
    
    <g:if test="${centroCostoInstance?.nombre}">
        <li class="fieldcontain">
            <span id="nombre-label" class="property-label"><g:message code="centroCosto.nombre.label" default="Nombre" /></span>
            
            <span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${centroCostoInstance}" field="nombre"/></span>
            
        </li>
    </g:if>
    
</ol>
