<%@ page import="cratos.Cuenta" %>

<g:form action="save" class="form-cuenta" method="post">
    <g:hiddenField name="id" value="${cuentaInstance?.id}"/>

    <g:hiddenField name="padre.id" value="${cuentaPadre?.id}"/>
    <g:hiddenField name="nivel.id" value="${lvl}"/>

    <table class="show ui-widget-content ui-corner-all">
        <tbody>
            <tr class="prop ${hasErrors(bean: cuentaInstance, field: 'padre', 'error')}">
                <td class="label " valign="middle">
                    Padre:
                </td>

                <td class="" valign="middle">
                    ${cuentaPadre}
                </td>

                <td width="150"></td>
            </tr>

            <tr>
                <td class="label  mandatory" valign="middle">
                    Nivel:
                </td>

                <td class=" mandatory" valign="middle">
                    ${lvl}
                </td>

                <td></td>
            </tr>

            <tr>
                <td class="label " valign="middle">
                    Número:
                </td>

                <td class="" valign="middle">

                    <g:if test="${!cuentaInstance.id}">
                        <g:textField name="numero" id="numero"
                                     title="${Cuenta.constraints.numero.attributes.title}"
                                     class="field required ui-widget-content ui-corner-all" minlenght="1" maxlenght="15"
                                     value="${cuentaInstance?.numero}"/>
                    </g:if>
                    <g:else>
                        ${cuentaInstance?.numero}
                    </g:else>
                </td>

                <td></td>
            </tr>

            <tr class="prop ${hasErrors(bean: cuentaInstance, field: 'descripcion', 'error')}">
                <td class="label " valign="middle">
                    Descripción:
                </td>

                <td class="" valign="middle">
                    <g:textArea name="descripcion" id="descripcion" cols="5" rows="5"
                                title="${Cuenta.constraints.descripcion.attributes.title}"
                                class="field required ui-widget-content ui-corner-all" minlength="1" maxlength="255"
                                style="width: 320px; height: 100px;" value="${cuentaInstance?.descripcion}"/>
                </td>

                <td></td>
            </tr>

            <tr class="prop ${hasErrors(bean: cuentaInstance, field: 'movimiento', 'error')}">
                <td class="label " valign="middle">
                    Auxiliar:
                </td>

                <td class="" valign="middle">
                    <g:if test="${hijos == 0}">
                        <select name='auxiliar' class="required ui-widget-content ui-corner-all">
                            <option value="N" ${(cuentaInstance?.auxiliar == "N") ? 'selected' : ''}>No</option>
                            <option value="S" ${(cuentaInstance?.auxiliar == "S") ? 'selected' : ''}>Si</option>
                        </select>
                    </g:if>
                    <g:else>
                        ${(cuentaInstance?.auxiliar == 'N') ? 'NO' : 'SI'}
                    </g:else>
                </td>

                <td></td>
            </tr>

            <tr class="prop ${hasErrors(bean: cuentaInstance, field: 'movimiento', 'error')}">
                <td class="label " valign="middle">
                    Movimiento:
                </td>

                <td class="" valign="middle">
                    <g:if test="${hijos == 0}">
                        <select name='movimiento' class="required ui-widget-content ui-corner-all">
                            <option value="0" ${(cuentaInstance?.movimiento == "0") ? 'selected' : ''}>No</option>
                            <option value="1" ${(cuentaInstance?.movimiento == "1") ? 'selected' : ''}>Si</option>
                        </select>
                    </g:if>
                    <g:else>
                        ${(cuentaInstance?.movimiento == '0') ? 'NO' : 'SI'}
                    </g:else>
                </td>

                <td></td>
            </tr>

            <tr>
                <td class="label " valign="middle">
                    Impuesto:
                </td>
                <td>
                    <g:if test="${hijos == 0}">
                        <g:select name="impuesto.id" from="${cratos.Impuesto.list([sort: 'codigo'])}" optionKey="id"
                                  optionValue="${{
                                      it.nombre + ' (' + it.porcentaje + '%, ret. ' + it.retencion + '%' + (it.sri == 'BNS' ? ', bienes' : it.sri == 'SRV' ? ', servicios' : '') + ')'
                                  }}" value="${cuentaInstance?.impuestoId}"/>
                    </g:if>
                    <g:else></g:else>
                </td>
            </tr>
        </tbody>
    </table>
</g:form>

<script type="text/javascript">
    $(function () {
        $(".form-cuenta").validate({
            errorPlacement : function (error, element) {
                error.appendTo(element.parent("td").next("td"));
            },
            messages       : {
                numero      : {
                    required : "Obligatorio"
                },
                descripcion : {
                    required : "Obligatorio"
                }
            }
        });
    });
</script>