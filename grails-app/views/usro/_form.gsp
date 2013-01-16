<%@ page import="cratos.seguridad.Usro" %>


<g:hiddenField name="id" value="${usroInstance?.id}"/>
<g:hiddenField name="version" value="${usroInstance?.version}"/>
<div class="container">

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'persona', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="persona">
                Persona
            </label>
        </div>

        <div class="span-19">
            <g:select id="persona" name="persona.id" from="${cratos.Persona.list()}" optionKey="id" required="" value="${usroInstance?.persona?.id}"
                      class="field  requiredCmb required  many-to-one ui-corner-all" title="${Usro.constraints.persona?.attributes?.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'login', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="login">
                Login
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  required  ui-corner-all" name="login" maxlength="15" required="" value="${usroInstance?.login}" title="${Usro.constraints.login?.attributes?.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'password', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="password">
                Password
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required  ui-corner-all" type="password" name="password" maxlength="64" required="" value="${usroInstance?.password}" title="${Usro.constraints.password.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'autorizacion', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="autorizacion">
                Autorizacion
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required  ui-corner-all" type="password" name="autorizacion" maxlength="255" required="" value="${usroInstance?.autorizacion}" title="${Usro.constraints.autorizacion.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'sigla', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="sigla">
                Sigla
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  required  ui-corner-all" name="sigla" maxlength="8" required="" value="${usroInstance?.sigla}" title="${Usro.constraints.sigla.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'activo', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="activo">
                Activo
            </label>
        </div>

        <div class="span-19">
            <g:field class="field  required number  ui-corner-all" type="number" name="activo" required="" title='${Usro.constraints.activo.attributes.title}' value="${fieldValue(bean: usroInstance, field: 'activo')}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'fechaPass', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="fechaPass">
                Fecha Pass
            </label>
        </div>

        <div class="span-19">
            <elm:datePicker class="field ui-corner-all" title="${Usro.constraints.fechaPass.attributes.title}" name="fechaPass" mensaje="Fecha de cambio de contraseña"/>

        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'observaciones', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="observaciones">
                Observaciones
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="observaciones" maxlength="255" value="${usroInstance?.observaciones}" title="${Usro.constraints.observaciones.attributes.title}"/>

        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'accesos', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="accesos">
                Accesos
            </label>
        </div>

        <div class="span-19">

            <ul class="one-to-many">
                <g:each in="${usroInstance?.accesos ?}" var="a">
                    <li><g:link controller="accs" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                </g:each>
                <li class="add">
                    <g:link controller="accs" action="create" params="['usro.id': usroInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'accs.label', default: 'Accs')])}</g:link>
                </li>
            </ul>

        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'alertas', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="alertas">
                Alertas
            </label>
        </div>

        <div class="span-19">

            <ul class="one-to-many">
                <g:each in="${usroInstance?.alertas ?}" var="a">
                    <li><g:link controller="alerta" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                </g:each>
                <li class="add">
                    <g:link controller="alerta" action="create" params="['usro.id': usroInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'alerta.label', default: 'Alerta')])}</g:link>
                </li>
            </ul>

        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: usroInstance, field: 'sesiones', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="sesiones">
                Sesiones
            </label>
        </div>

        <div class="span-19">

            <ul class="one-to-many">
                <g:each in="${usroInstance?.sesiones ?}" var="s">
                    <li><g:link controller="sesn" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                </g:each>
                <li class="add">
                    <g:link controller="sesn" action="create" params="['usro.id': usroInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'sesn.label', default: 'Sesn')])}</g:link>
                </li>
            </ul>

        </div>
    </div>

</div>