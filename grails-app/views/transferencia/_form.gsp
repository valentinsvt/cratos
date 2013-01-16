<%@ page import="cratos.Transferencia" %>


<g:hiddenField name="id" value="${transferenciaInstance?.id}"/>
<g:hiddenField name="version" value="${transferenciaInstance?.version}"/>
<div class="container span-20">

    <fieldset style="margin: 20px">

        <div class="fila span-20">
            <div class="${hasErrors(bean: transferenciaInstance, field: 'fecha', 'error')} ">
                <div class="span-3">
                    <label for="fecha">
                        Fecha
                    </label>
                </div>

                <div class="span-6">
                    <elm:datePicker class="field ui-corner-all required" style="width: 80px" value="${transferenciaInstance.fecha}"
                                    title="${Transferencia.constraints.fecha.attributes.title}"
                                    name="fecha" format="yyyy-MM-dd"/>

                </div>

                <div class="span-3 prepend-1">
                    <label for="gestor">
                        Gestor contable
                    </label>
                </div>

                <div class="span-6">
                    <g:select name="gestor" from="${cratos.Gestor.findAllByEmpresa(session.empresa)}" class="field ui-corner-all required"
                              optionKey="id" optionValue="nombre"/>
                </div>
            </div>

        </div>

        <div class="fila span-20">
            <div class="${hasErrors(bean: transferenciaInstance, field: 'bodegaSale', 'error')} ">
                <div class="span-3">
                    <label for="centroCostosSale">
                        Centro de costos sale
                    </label>
                </div>

                <div class="span-6">
                    <g:select name="centroCostosSale" from="${cratos.CentroCosto.findAllByEmpresa(session.empresa, [sort: 'nombre'])}"
                              class="centroCostos field ui-corner-all required" value="${transferenciaInstance?.bodegaSale?.centroCostoId}"
                              optionKey="id" optionValue="nombre" data-tipo="Sale"/>
                    %{--<g:select id="bodegaRecibe" name="bodegaRecibe" from="${cratos.Bodega.findAllByEmpresa(session.empresa)}" optionKey="id" optionValue="descripcion" value="${transferenciaInstance?.bodegaRecibe?.id}"--}%
                    %{--class="field  many-to-one ui-corner-all required" title="${Transferencia.constraints.bodegaRecibe.attributes.title}" noSelection="['': '']"/>--}%

                </div>
            </div>

            <div class="${hasErrors(bean: transferenciaInstance, field: 'bodegaRecibe', 'error')} ">
                <div class="span-3 prepend-1">
                    <label for="centroCostosRecibe">
                        Centro de costos recibe
                    </label>
                </div>

                <div class="span-6">
                    <g:select name="centroCostosRecibe" from="${cratos.CentroCosto.findAllByEmpresa(session.empresa, [sort: 'nombre'])}"
                              class="centroCostos field ui-corner-all required" value="${transferenciaInstance?.bodegaRecibe?.centroCostoId}"
                              optionKey="id" optionValue="nombre" data-tipo="Recibe"/>
                    %{--<g:select id="bodegaSale" name="bodegaSale" from="${cratos.Bodega.findAllByEmpresa(session.empresa)}" optionKey="id" optionValue="descripcion"--}%
                    %{--value="${transferenciaInstance?.bodegaSale?.id}" class="field  many-to-one ui-corner-all required" title="${Transferencia.constraints.bodegaSale.attributes.title}" noSelection="['': '']"/>--}%

                </div>
            </div>
        </div>

        <div class="fila span-20">
            <div class="${hasErrors(bean: transferenciaInstance, field: 'bodegaSale', 'error')} ">
                <div class="span-3">
                    <label for="bodegaSale">
                        Bodega Sale
                    </label>
                </div>

                <div class="span-6" id="spBodegaSale">
                    %{--<g:select id="bodegaRecibe" name="bodegaRecibe" from="${cratos.Bodega.findAllByEmpresa(session.empresa)}" optionKey="id" optionValue="descripcion" value="${transferenciaInstance?.bodegaRecibe?.id}"--}%
                    %{--class="field  many-to-one ui-corner-all required" title="${Transferencia.constraints.bodegaRecibe.attributes.title}" noSelection="['': '']"/>--}%

                </div>
            </div>

            <div class="${hasErrors(bean: transferenciaInstance, field: 'bodegaRecibe', 'error')} ">
                <div class="span-3 prepend-1">
                    <label for="bodegaRecibe">
                        Bodega Recibe
                    </label>
                </div>

                <div class="span-6" id="spBodegaRecibe">
                    %{--<g:select id="bodegaSale" name="bodegaSale" from="${cratos.Bodega.findAllByEmpresa(session.empresa)}" optionKey="id" optionValue="descripcion"--}%
                    %{--value="${transferenciaInstance?.bodegaSale?.id}" class="field  many-to-one ui-corner-all required" title="${Transferencia.constraints.bodegaSale.attributes.title}" noSelection="['': '']"/>--}%

                </div>
            </div>
        </div>

        <div class="fila span-20">
            <div class="${hasErrors(bean: transferenciaInstance, field: 'observaciones', 'error')} ">
                <div class="span-3">
                    <label for="observaciones">
                        Observaciones
                    </label>
                </div>

                <div class="span-6">
                    <g:textField class="field  ui-corner-all" name="observaciones" maxlength="127" style="width: 350px" value="${transferenciaInstance?.observaciones}" title="${Transferencia.constraints.observaciones.attributes.title}"/>

                </div>
            </div>

        </div>
    </fieldset>
</div>