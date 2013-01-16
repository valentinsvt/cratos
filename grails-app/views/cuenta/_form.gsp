<%@ page import="cratos.Nivel; cratos.Cuenta" %>


<g:hiddenField name="id" value="${cuentaInstance?.id}"/>
<div class="container" style="width: 350px;">

    <div class="span-9 ${hasErrors(bean: cuentaInstance, field: 'empresa', 'error')} ">
        <div class="span-3 ">
            <label for="empresa">
                Empresa
            </label>
        </div>

        <div class="span-5">
            ${session.empresa.nombre}
            <g:hiddenField id="empresa" name="empresa.id" value="${session.empresa.id}"/>
        </div>
    </div>

    <div class="span-9 ${hasErrors(bean: cuentaInstance, field: 'padre', 'error')} ">
        <div class="span-3 ">
            <label for="padre">
                Padre
            </label>
        </div>

        <div class="span-5">
            ${cuentaInstance?.padre}
            <g:hiddenField id="padre" name="padre.id" value="${cuentaInstance?.padre?.id}"/>
        </div>
    </div>

    <div class="span-9 ${hasErrors(bean: cuentaInstance, field: 'nivel', 'error')} required">
        <div class="span-3 ">
            <label for="nivel">
                Nivel
            </label>
        </div>

        <div class="span-5">
            %{--<g:set var="nivel" value="${(Nivel.get(cuentaInstance?.padre?.nivel?.id))}"/>--}%
            %{--<g:if test="${nivel}">--}%
                %{--<g:set var="nivel" value="${Nivel.get(1)}"/>--}%
            %{--</g:if>--}%
            %{--${nivel.id} - ${nivel.descripcion}--}%
            %{--<g:hiddenField id="nivel" name="nivel.id" value="${nivel?.id}"/>--}%
        </div>
    </div>

    <div class="span-9 ${hasErrors(bean: cuentaInstance, field: 'auxiliar', 'error')} ">
        <div class="span-3 ">
            <label for="auxiliar">
                Auxiliares
            </label>
        </div>

        <div class="span-5">
            <g:select class="field ui-corner-all" name="auxiliar" from="${Cuenta.constraints.auxiliar.inList}" value="${cuentaInstance?.auxiliar}"
                      valueMessagePrefix="puede" title="${Cuenta.constraints.auxiliar.attributes.title}"/>

        </div>
    </div>

    <div class="span-9 ${hasErrors(bean: cuentaInstance, field: 'movimiento', 'error')} ">
        <div class="span-3 ">
            <label for="movimiento">
                Movimiento
            </label>
        </div>

        <div class="span-5">
            <g:select class="field ui-corner-all" name="movimiento" from="${Cuenta.constraints.movimiento.inList}" value="${cuentaInstance?.movimiento}"
                      valueMessagePrefix="puede" title="${Cuenta.constraints.movimiento.attributes.title}"/>

        </div>
    </div>

    <div class="span-9 ${hasErrors(bean: cuentaInstance, field: 'descripcion', 'error')} required">
        <div class="span-3 ">
            <label for="descripcion">
                Descripción
            </label>
        </div>

        <div class="span-5">
            <g:textField class="field  required  ui-corner-all" name="descripcion" maxlength="127" required="" value="${cuentaInstance?.descripcion}" title="${Cuenta.constraints.descripcion.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-9 ${hasErrors(bean: cuentaInstance, field: 'numero', 'error')} required">
        <div class="span-3 ">
            <label for="numero">
                Número
            </label>
        </div>

        <div class="span-5">
            <g:textField class="field  required  ui-corner-all" name="numero" maxlength="20" required="" value="${cuentaInstance?.numero}" title="${Cuenta.constraints.numero.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-9 ${hasErrors(bean: cuentaInstance, field: 'cuentaBanco', 'error')} ">
        <div class="span-3 ">
            <label for="cuentaBanco">
                Cuenta Banco
            </label>
        </div>

        <div class="span-5">
            <g:select id="cuentaBanco" name="cuentaBanco.id" from="${cratos.CuentaBanco.list()}" optionKey="id" value="${cuentaInstance?.cuentaBanco?.id}" class="field  many-to-one ui-corner-all" title="${Cuenta.constraints.cuentaBanco.attributes.title}" noSelection="['null': '']"/>

        </div>
    </div>

    <div class="span-9 ${hasErrors(bean: cuentaInstance, field: 'presupuesto', 'error')} ">
        <div class="span-3 ">
            <label for="presupuesto">
                Presupuesto
            </label>
        </div>

        <div class="span-5">
            <g:select id="presupuesto" name="presupuesto.id" from="${cratos.Presupuesto.list()}" optionKey="id" value="${cuentaInstance?.presupuesto?.id}" class="field  many-to-one ui-corner-all" title="${Cuenta.constraints.presupuesto.attributes.title}" noSelection="['null': '']"/>

        </div>
    </div>

</div>