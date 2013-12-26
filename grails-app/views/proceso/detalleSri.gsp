<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/19/13
  Time: 12:56 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>SRI</title>
    </head>

    <body>
        <g:form name="sriForm">
            <div class="container entero ui-widget-content ui-corner-all">
                <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 5px; margin-left: 8px;height: 30px;line-height: 30px;padding-left: 30px;margin-bottom: 20px;">Detalle SRI</h1>

                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
                    <label>Período</label> <g:select name="periodo" from="${periodos}"/>
                    <label>Fecha de Registro Contable</label>
                    <g:set var="anio" value="${new Date().format('yyyy')}"/>
                    <g:set var="mes" value="${new Date().format('MM').toInteger()}"/>
                    <elm:datePicker class="field ui-corner-all" name="fechaIngresoSistema" title="fecha"
                                    minDate="'-1m'" maxDate="new Date()"
                                    style="width: 80px; margin-left: 5px" format="yyyy-MM-dd" value="${proceso?.fechaIngresoSistema}"/>
                    <label>Sustento Tributario</label> <g:select name="sustento" from="${sustento}" style="width: 250px"/>
                </div>

                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
                    <label>Tipo de ID del Proveedor</label><g:select name="tipoIdentificacion" from="${cratos.TipoIdentificacion.list()}" optionKey="id" optionValue="descripcion" value="${proceso?.proveedor?.tipoIdentificacion?.descripcion}"/>

                </div>

                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
                    <label>Aplica Crédito Tributario</label><g:select name="credito" from="${['SI', 'NO']}"/>
                    <label style="margin-left: 360px">Base Retención</label>
                    <label style="margin-left: 15px">% Ret</label>
                    <label style="margin-left: 25px">Valor Retenido</label>
                </div>


                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 3px">
                    <label>Base Imponible no Objeto de IVA</label><g:textField name="noObjetoIva" style="margin-left: 5px; margin-right: 150px" value="${proceso?.baseImponibleNoIva}"/>
                    <label>ICE</label><g:textField name="ice"  value="${proceso?.iceGenerado}"/><g:select name="porcentajeIce" from="" style="width: 60px"/><g:textField name="valorRetenidoIce"/>
                </div>

                <div class="span-28" style="margin-left: 40px; margin-top: 3px; margin-bottom: 3px">
                    <label>Base Imponible IVA 0%</label><g:textField name="biIva0" style="margin-left: 70px; margin-right: 85px" value="${proceso?.baseImponibleIva0}"/>
                    <label>IVA(1) Bienes</label><g:textField name="bienes" value="${proceso?.retencionIvaBienes}"/><g:select name="porcentajeIvaBienes" from="" style="width: 60px"/><g:textField name="valorRetenidoBienes"/>
                </div>

                <div class="span-28" style="margin-left: 40px; margin-top: 3px; margin-bottom: 3px">
                    <label>Base Imponible IVA 12%</label><g:textField name="biIva12" style="margin-left: 60px; margin-right: 25px" value="${proceso?.baseImponibleIva}"/>
                    <label>IVA(2) Servicios y 100%</label><g:textField name="servicios" value="${proceso?.retencionIvaServicios}"/><g:select name="porcentajeServicios" from="" style="width: 60px"/><g:textField name="valorRetenidoServicios"/>
                </div>

                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
                    <label>IVA</label><g:textField name="iva12" style="margin-left: 195px" value="${proceso?.ivaGenerado}"/>
                </div>


                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: -5px">
                    <label>N° Establecimiento</label>
                    <label style="margin-left: 15px">N° Emisión</label>
                    <label style="margin-left: 35px">N° Autorización del Comprobante</label>
                </div>

                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
                    <g:textField name="numEsta" value="${proceso?.facturaEstablecimiento}" style="width: 100px"/>
                    <g:textField name="numEmis" value="${proceso?.facturaPuntoEmision}" style="width: 100px"/>
                    <g:textField name="numSerial" value="${proceso?.autorizacionSRI}" style="width: 250px"/>
                </div>

                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">

                </div>

                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
                    <label>Pago Local o Exterior</label><g:select name="pago" from="${['LOCAL', 'EXTERIOR']}"/>
                    <label style="margin-left: 300px">Base Imponible</label>
                    <label style="margin-left: 25px">%RBI</label>
                    <label style="margin-left: 15px">Valor Retenido IR</label>
                </div>

                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px">
                    <label>Concepto de la Retención del IR</label><g:select name="retencionIR" from="${cratos.ConceptoRetencionImpuestoRenta?.list()}" optionKey="id" optionValue="descripcion" style="width: 300px"/>
                <g:textField name="baseImpo"/>
                <g:select name="porcentajeRBI" from="" style="width: 50px"/>
                <g:textField name="valorRetenido" readonly="true"/>

                </div>

                <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px; margin-right: 25px">
                    <fieldset>

                        <legend>Datos del Comprobante de Retención</legend>

                        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px; margin-right: 25px">
                            <label style="margin-left: 10px">Fecha Emisión</label>
                            <label style="margin-left: 10px">N° Esta.</label>
                            <label style="margin-left: 10px">N° Emisión</label>
                            <label style="margin-left: 10px">N° Secuencial</label>
                            <label style="margin-left: 10px">N° Autorización del Comprobante</label>
                        </div>

                        <div class="span-28" style="margin-left: 40px; margin-top: 10px; margin-bottom: 15px; margin-right: 25px">

                            <elm:datePicker class="field ui-corner-all" name="fechaEmision" title="fecha"
                                            minDate="'-1m'" maxDate="new Date()"
                                            style="width: 80px; margin-left: 5px" format="yyyy-MM-dd"/>
                            <g:textField name="retEsta" style="width: 60px" value="${proceso?.retencionSerie1}"/>
                            <g:textField name="retEmision" style="width: 60px" value="${proceso?.retencionSerie2}"/>
                            <g:textField name="retSecu"  style="width: 100px" value="${proceso?.retencionSecuencial}"/>
                            <g:textField name="retAutorizacion" value="${proceso?.retencionAutorizacion}"/>
                        </div>




                    </fieldset>

                </div>

            </div>
        </g:form>
        <script type="text/javascript">

        </script>

    </body>
</html>