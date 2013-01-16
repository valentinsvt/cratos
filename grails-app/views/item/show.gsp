<ol class="property-list item">

    <g:if test="${itemInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="item.codigo.label" default="Código"/></span>

            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${itemInstance}"
                                                                                      field="codigo"/></span>

        </li>
    </g:if>

    <g:if test="${itemInstance?.nombre}">
        <li class="fieldcontain">
            <span id="nombre-label" class="property-label"><g:message code="item.nombre.label" default="Nombre"/></span>

            <span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${itemInstance}"
                                                                                      field="nombre"/></span>

        </li>
    </g:if>

    <g:if test="${itemInstance?.marca}">
        <li class="fieldcontain">
            <span id="marca-label" class="property-label"><g:message code="item.marca.label" default="Marca"/></span>

            <span class="property-value" aria-labelledby="marca-label">
                %{--<g:link controller="marca" action="show" id="${itemInstance?.marca?.id}">--}%
                ${itemInstance?.marca?.descripcion?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>

        </li>
    </g:if>

    <g:if test="${itemInstance?.precioVenta}">
        <li class="fieldcontain">
            <span id="precioVenta-label" class="property-label"><g:message code="item.precioVenta.label"
                                                                           default="Precio Venta"/></span>

            <span class="property-value" aria-labelledby="precioVenta-label"><g:fieldValue bean="${itemInstance}"
                                                                                           field="precioVenta"/></span>

        </li>
    </g:if>

    <g:if test="${itemInstance?.precioCosto}">
        <li class="fieldcontain">
            <span id="precioCosto-label" class="property-label"><g:message code="item.precioCosto.label"
                                                                           default="Precio Costo"/></span>

            <span class="property-value" aria-labelledby="precioCosto-label"><g:fieldValue bean="${itemInstance}"
                                                                                           field="precioCosto"/></span>

        </li>


        <g:if test="${itemInstance?.precioUnitario}">
            <li class="fieldcontain">
                <span id="precioUnitario-label" class="property-label"><g:message code="item.precioUnitario.label"
                                                                                  default="Precio Unitario"/></span>

                <span class="property-value" aria-labelledby="precioUnitario-label"><g:fieldValue bean="${itemInstance}"
                                                                                                  field="precioUnitario"/></span>

            </li>
        </g:if>

    </g:if>
    <g:if test="${itemInstance?.iva}">
        <li class="fieldcontain">
            <span id="iva-label" class="property-label"><g:message code="item.iva.label" default="Iva"/></span>

            <span class="property-value" aria-labelledby="iva-label"><g:fieldValue bean="${itemInstance}"
                                                                                   field="iva"/></span>

        </li>
    </g:if>

    <g:if test="${itemInstance?.ice}">
        <li class="fieldcontain">
            <span id="ice-label" class="property-label"><g:message code="item.ice.label" default="Ice"/></span>
                <span class="property-value" aria-labelledby="ice-label"><g:fieldValue field="ice" bean="${itemInstance}"/></span>

        </li>



    </g:if>

    <g:if test="${itemInstance?.peso}">
        <li class="fieldcontain">
            <span id="peso-label" class="property-label"><g:message code="item.peso.label" default="Peso"/></span>

            <span class="property-value" aria-labelledby="peso-label"><g:fieldValue bean="${itemInstance}"
                                                                                    field="peso"/></span>

        </li>
    </g:if>

    <g:if test="${itemInstance?.stockMaximo}">
        <li class="fieldcontain">
            <span id="stockMaximo-label" class="property-label"><g:message code="item.stockMaximo.label"
                                                                           default="Stock Máximo"/></span>

            <span class="property-value" aria-labelledby="stockMaximo-label"><g:fieldValue bean="${itemInstance}"
                                                                                           field="stockMaximo"/></span>

        </li>
    </g:if>

    <g:if test="${itemInstance?.stock}">
        <li class="fieldcontain">
            <span id="stock-label" class="property-label"><g:message code="item.stock.label" default="Stock Mínimo"/></span>

            <span class="property-value" aria-labelledby="stock-label"><g:fieldValue bean="${itemInstance}"
                                                                                     field="stock"/></span>

        </li>
    </g:if>

%{--<g:if test="${itemInstance?.estado}">--}%
%{--<li class="fieldcontain">--}%
%{--<span id="estado-label" class="property-label"><g:message code="item.estado.label" default="Estado"/></span>--}%

%{--<span class="property-value" aria-labelledby="estado-label"><g:fieldValue bean="${itemInstance}"--}%
%{--field="estado"/></span>--}%

%{--</li>--}%
%{--</g:if>--}%


    <g:if test="${itemInstance?.unidad}">
        <li class="fieldcontain">
            <span id="unidad-label" class="property-label"><g:message code="item.unidad.label" default="Unidad"/></span>

            <span class="property-value" aria-labelledby="unidad-label">
                %{--<g:link controller="unidad" action="show" id="${itemInstance?.unidad?.id}">--}%
                ${itemInstance?.unidad?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>

        </li>
    </g:if>



    <g:if test="${itemInstance?.grupo}">
        <li class="fieldcontain">
            <span id="grupo-label" class="property-label"><g:message code="item.grupo.label" default="Grupo"/></span>

            <span class="property-value" aria-labelledby="grupo-label">
                %{--<g:link controller="grupo" action="show" id="${itemInstance?.grupo?.id}">--}%
                ${itemInstance?.grupo?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>

        </li>
    </g:if>

    <g:if test="${itemInstance?.observaciones}">
        <li class="fieldcontain">
            <span id="observaciones-label" class="property-label"><g:message code="item.observaciones.label"
                                                                             default="Observaciones"/></span>

            <span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${itemInstance}"
                                                                                             field="observaciones"/></span>

        </li>
    </g:if>

    <g:if test="${itemInstance?.fecha}">
        <li class="fieldcontain">
            <span id="fecha-label" class="property-label"><g:message code="item.fecha.label" default="Fecha"/></span>

            <span class="property-value" aria-labelledby="fecha-label"><g:formatDate
                    date="${itemInstance?.fecha}" format="dd-MM-yyyy"/></span>

        </li>
    </g:if>

</ol>
