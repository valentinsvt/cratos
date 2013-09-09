<%@ page import="cratos.Persona" %>
<%@ page import="cratos.Empleado" %>

<style type="text/css">
.empleado {
    background-color : #e6e6fa !important;
}

.persona {
    background-color : #E8F8F9 !important;
}

#divLock {
    cursor : pointer;
}
</style>
<g:form name="frm-empleado" action="save" method="post">
<g:hiddenField name="empleado.id" id="empleadoId" value="${empleadoInstance?.id}"/>
<g:hiddenField name="persona.id" id="personaId" value="${personaInstanceInstance?.id}"/>
<g:hiddenField name="version" value="${empleadoInstance?.version}"/>
<div class=" fila span-30">
    <div class="required ">
        <div class="span-2">
            <label for="persona.cedula">
                Cédula
            </label>
        </div>

        <div class="span-3">
            <g:textField style="width: 80px;" class="field persona required  ui-corner-all" name="persona.cedula" id="cedula" maxlength="10" required="" value="${personaInstance?.cedula}" title="${Persona.constraints.cedula.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="required ">
        <div class="span-3">
            <label for="persona.nombre">
                Nombres
            </label>
        </div>

        <div class="span-7">
            <g:textField style="width: 230px;" class="field  required persona ui-corner-all" name="persona.nombre" id="nombre" maxlength="31" required="" value="${personaInstance?.nombre}" title="${Persona.constraints.nombre.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="required ">
        <div class="span-2">
            <label for="persona.apellido">
                Apellidos
            </label>
        </div>

        <div class="span-7">
            <g:textField style="width: 230px;" class="field persona required  ui-corner-all" name="persona.apellido" id="apellido" maxlength="31" required="" value="${personaInstance?.apellido}" title="${Persona.constraints.apellido.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="required ">
        <div class="span-2">
            <label for="empleado.estado">
                Estado
            </label>
        </div>

        <div class="span-1" style="width: 35px;">
            <g:textField style="width: 10px;" name="empleado.estado" id="estado" maxlength="1" class="field empleado ui-corner-all" value="${empleadoInstance?.estado ?: 'A'}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-1 ui-helper-hidden" id="divLock" title="Desbloquear">
        <img src="${resource(dir: 'images', file: 'Lock.png')}"/>
    </div>
</div>

<div class=" fila span-30">
    <div class="required ">
        <div class="span-2">
            <label for="empleado.cargo.id">
                Cargo
            </label>
        </div>

        <div class="span-5">
            <g:select id="cargo" name="empleado.cargo.id" from="${cratos.Cargo.list()}" optionKey="id" class="many-to-one empleado field ui-corner-all" value="${empleadoInstance?.cargo?.id}" noSelection="['null': '']"/>
        </div>
    </div>
    <div class="required ">
        <div class="span-2">
            <label for="empleado.cargo.id">
                Contrato
            </label>
        </div>

        <div class="span-5">
            <g:select id="cargo" name="empleado.tipoContrato.id" from="${cratos.TipoContrato.list()}" optionKey="id" class="many-to-one empleado field ui-corner-all" optionValue="descripcion" value="${empleadoInstance?.tipoContrato?.id}" noSelection="['null': '']"/>
        </div>
    </div>
</div>
<div class=" fila span-30">
    <div class="required ">
        <div class="span-2">
            <label for="persona.direccion">
                Dirección
            </label>
        </div>

        <div class="span-18">
            <g:textField class="field persona ui-corner-all span-18" name="persona.direccion" id="direccion" maxlength="127" value="${personaInstance?.direccion}" title="${Persona.constraints.direccion.attributes.title}"/>
        </div>
    </div>
</div>

<div class=" fila span-30">
    <div class="required ">
        <div class="span-2">
            <label for="persona.telefono">
                Teléfono(s)
            </label>
        </div>

        <div class="span-11">
            <g:textField class="field persona ui-corner-all span-11" name="persona.telefono" id="telefono" maxlength="63" value="${personaInstance?.telefono}" title="${Persona.constraints.telefono.attributes.title}"/>
        </div>
    </div>

    <div class="required ">
        <div class="span-2">
            <label for="persona.email">
                E-mail
            </label>
        </div>

        <div class="span-12">
            <g:textField class="field persona ui-corner-all span-12" name="persona.email" id="email" maxlength="63" value="${personaInstance?.email}" title="${Persona.constraints.email.attributes.title}"/>
        </div>
    </div>
</div>

<div class=" fila span-30">
    <div class="required ">
        <div class="span-2">
            <label for="persona.fechaNacimiento">
                Fecha Nac.
            </label>
        </div>

        <div class="span-3">
            <g:textField style="width: 70px;" name="persona.fechaNacimiento" id="fechaNacimiento" class="field datepicker persona ui-corner-all" value="${personaInstance?.fechaNacimiento?.format('dd-MM-yyyy')}"/>
        </div>
    </div>

    <div class="required ">
        <div class="span-1">
            <label for="persona.sexo">
                Sexo
            </label>
        </div>

        <div class="span-2" style="width: 55px;">
            <g:select style="width: 45px;" class="field persona required  ui-corner-all" name="persona.sexo" id="sexo" maxlength="1" required="" value="${personaInstance?.sexo}" title="${Persona.constraints.sexo.attributes.title}" from="${Persona.constraints.sexo.inList}"/>
        </div>
    </div>

    <div class="required ">
        <div class="span-1">
            <label for="empleado.hijo">
                Hijos
            </label>
        </div>

        <div class="span-2" style="width: 55px;">
            <g:field style="width: 25px;" type="number" name="empleado.hijo" id="hijo" class="field empleado ui-corner-all required" value="${fieldValue(bean: empleadoInstance, field: 'hijo')}"/>
        </div>
    </div>

    <div class="required ">
        <div class="span-1">
            <label for="empleado.iess">
                IESS
            </label>
        </div>

        <div class="span-4" style="width: 120px;">
            <g:textField style="width: 100px;" name="empleado.iess" id="iess" maxlength="13" class="field empleado ui-corner-all" value="${empleadoInstance?.iess}"/>
        </div>
    </div>

    <div class="required ">
        <div class="span-2" style="width: 47px;">
            <label for="empleado.iess">
                Sueldo
            </label>
        </div>

        <div class="span-2">
            <g:field type="number" style="width: 50px;" name="empleado.sueldo" id="sueldo" class="field empleado ui-corner-all required" value="${fieldValue(bean: empleadoInstance, field: 'sueldo')}"/>
        </div>
    </div>

    <div class="required ">
        <div class="span-2" style="width: 63px;">
            <label for="empleado.fechaInicio">
                F. Ingreso
            </label>
        </div>

        <div class="span-3">
            <g:textField style="width: 70px;" name="empleado.fechaInicio" id="fechaInicio" class="field empleado datepicker ui-corner-all" value="${empleadoInstance?.fechaInicio?.format('dd-MM-yyyy')}"/>
        </div>
    </div>

    <div class="required ">
        <div class="span-2" style="width: 53px;">
            <label for="empleado.fechaFin">
                F. Salida
            </label>
        </div>

        <div class="span-3">
            <g:textField style="width: 70px;" name="empleado.fechaFin" id="fechaFin" class="field datepicker empleado ui-corner-all" value="${empleadoInstance?.fechaFin?.format('dd-MM-yyyy')}"/>
        </div>
    </div>
</div>

<div class=" fila span-30">
    <div class="required ">
        <div class="span-3">
            <label for="empleado.observaciones">
                Observaciones
            </label>
        </div>

        <div class="span-24">
            <g:textField name="empleado.observaciones" id="observaciones" class="field empleado ui-corner-all span-24" value="${empleadoInstance.observaciones}"/>
        </div>
    </div>
</div>
</g:form>
<script type="text/javascript">

    var imgs = {
        locked   : "${resource(dir:'images', file:'Lock.png')}",
        unlocked : "${resource(dir:'images', file:'Unlock.png')}"
    };
    var $lock = $("#divLock");

    function bloquearPersona() {
        var locked = $lock.data("locked");
        if (locked) {
            $lock.html("<img src='" + imgs.unlocked + "' />").attr("title", "Bloquear").data("locked", false);
            $(".persona").removeClass("ui-state-disabled").removeAttr("readonly");
        } else {
            $lock.html("<img src='" + imgs.locked + "' />").attr("title", "Desbloquear").data("locked", true);
            $(".persona").addClass("ui-state-disabled").attr("readonly", "true");
        }
        if (!$lock.is(":visible")) {
            $lock.show();
        }
    }

    $(function () {
        <g:if test="${personaInstance.id}">
        $lock.show().html("<img src='" + imgs.unlocked + "' />").data("locked", false);
        </g:if>
        <g:else>
        $lock.hide().data("locked", null);
        </g:else>

        $lock.click(function () {
            bloquearPersona();
        });

        $(".datepicker").datepicker({
            changeMonth     : true,
            changeYear      : true,
            dateFormat      : "dd-mm-yy",
            buttonImage     : "${resource(dir:'images', file:'calendar.png')}",
            buttonImageOnly : true
        });
        $("#fechaNacimiento").datepicker("option", "yearRange", "-75:-15");
        $("#fechaInicio, #fechaFin").datepicker("option", "yearRange", "-25:+0");

        $("#cedula").blur(function () {
            var ci = $.trim($(this).val());
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'findPersona_ajax')}",
                data    : {
                    ci : ci
                },
                success : function (msg) {
                    var obj = jQuery.parseJSON(msg);
                    var ok = false;
                    $.each(obj, function (key, value) {
                        $("#" + key).val(value);
                        ok = true;
                    });
                    if (ok) {
                        bloquearPersona();
                    }
                }
            });
        });
    });
</script>

