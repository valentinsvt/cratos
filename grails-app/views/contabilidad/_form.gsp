<%@ page import="cratos.Contabilidad" %>


<g:hiddenField name="id" value="${contabilidadInstance?.id}"/>
<g:hiddenField name="version" value="${contabilidadInstance?.version}"/>
<div class="container">

    <div class="span-24 ${hasErrors(bean: contabilidadInstance, field: 'fechaInicio', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="fechaInicio">
                Fecha Inicio                                                                                                   .
            </label>
        </div>

        <div class="span-19">
            <elm:datePicker title="${Contabilidad.constraints.fechaInicio.attributes.title}" name="fechaInicio" title="fechaInicio"
                            value="${contabilidadInstance?.fechaInicio}" class="field ui-corner-all" style="width: 80px"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: contabilidadInstance, field: 'fechaCierre', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="fechaCierre">
                Fecha Cierre
            </label>
        </div>

        <div class="span-19">
            <elm:datePicker title="${Contabilidad.constraints.fechaCierre.attributes.title}" name="fechaCierre" title="fechaCierre"
                            value="${contabilidadInstance?.fechaCierre}" class="field ui-corner-all" style="width: 80px"/>

        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: contabilidadInstance, field: 'prefijo', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="pref">
                Prefijo
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="pref" maxlength="8" value="${contabilidadInstance?.prefijo}" style="width: 80px" title="${Contabilidad.constraints.prefijo.attributes.title}"/>

        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: contabilidadInstance, field: 'descripcion', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="descripcion">
                Descripción
            </label>
        </div>

        <div class="span-19">
            %{--<g:textField class="field  required  ui-corner-all" name="descripcion" style="width: 200px" maxlength="63" required="" value="${contabilidadInstance?.descripcion}" title="${Contabilidad.constraints.descripcion.attributes.title}"/>--}%
            <g:textArea name="descripcion" rows="4" cols="4" class="field required ui-corner-all" style="width: 210px; height:50px; resize: none;"  maxlength="63"
            value="${contabilidadInstance?.descripcion}" title="${Contabilidad.constraints.descripcion.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: contabilidadInstance, field: 'institucion', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="institucion">
                Institución
            </label>
        </div>

        <div class="span-19">
            <g:select id="institucion" name="institucion.id" from="${cratos.Empresa.list()}" optionKey="id" value="${contabilidadInstance?.institucion?.id}" class="field  many-to-one ui-corner-all" title="${Contabilidad.constraints.institucion.attributes.title}" noSelection="['null': '']"/>

        </div>
    </div>

    <div class="span-24 ${hasErrors(bean: contabilidadInstance, field: 'presupuesto', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="presupuesto">
                Fecha aprobación Presupuesto
            </label>
        </div>

        <div class="span-19">
            <elm:datePicker title="${Contabilidad.constraints.presupuesto.attributes.title}" name="presupuesto" title="fecha de aprobacion del presupuesto"
                            value="${contabilidadInstance?.presupuesto}" class="field ui-corner-all" style="width: 80px"/>
            <span class="required-indicator">*</span>
        </div>
    </div>

</div>