package cratos

class Proceso implements Serializable {
    int padre
    double impuesto
    double valor
    Date fecha
    String descripcion
    Gestor gestor
    cratos.seguridad.Usro usuario
    Contabilidad contabilidad
    Proveedor proveedor
    TipoPago tipoPago
    String estado
    Adquisiciones adquisicion
    Factura fact
    String documento
    CentroCosto centroCosto
    OrdenCompra ordenCompra
    Transferencia transferencia
    RolPagos rolPagos
    TipoComprobanteId tipoComprobanteId
    TipoSoporte tipoSoporte
    Date fechaRegistro
    Date fechaEmision
    String procesoSerie01
    String procesoSerie02
    String secuencial = 0
    String autorizacionSRI
    double baseImponibleIva0 = 0
    double baseImponibleIva = 0
    double ivaGenerado = 0
    double baseImponibleNoIva = 0
    double iceGenerado = 0
    double retencionIvaBienes = 0
    double retencionIvaServicios = 0
    double retencionIva = 0

    String tipoRetencion

    String retencionSerie1
    String retencionSerie2
    String retencionSecuencial
    String retencionAutorizacion

    PagoAux pagoAux

    SustentoTributario sustentoTributario
    TipoComprobanteSri tipoComprobanteSri

    Date fechaIngresoSistema

    String facturaEstablecimiento
    String facturaPuntoEmision
    String facturaSecuencial

    static auditable = true
    static mapping = {
        table 'prcs'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prcs__id'
        id generator: 'identity'
        version false
        columns {
            padre column: 'prcspdre'
            impuesto column: 'prcsimpt'
            valor column: 'prcsvlor'
            fecha column: 'prcsfcha'
            descripcion column: 'prcsdscr'
            gestor column: 'gstr__id'
            usuario column: 'usro__id'
            contabilidad column: 'cont__id'
            proveedor column: 'prve__id'
            tipoPago column: 'tppg__id'
            estado column: 'prcsetdo'
            adquisicion column: 'adqc__id'
            fact column: 'fctr__id'
            documento column: 'prcsdcmt'
            centroCosto column: 'cncs__id'
            ordenCompra column: 'odcp__id'
            transferencia column: 'trnf__id'
            rolPagos column: 'rlpg__id'
            tipoComprobanteId column: 'tcti__id'
            tipoSoporte column: 'tpst__id'
            fechaRegistro column: 'prcsfcrg'
            fechaEmision column: 'prcsfcem'
            procesoSerie01 column: 'prcssr01'
            procesoSerie02 column: 'prcssr02'
            secuencial column: 'prcsscnc'
            autorizacionSRI column: 'prcsatrz'
            baseImponibleIva0 column: 'prcsbszr'
            baseImponibleIva column: 'prcsbsnz'
            ivaGenerado column: 'prcs_iva'
            baseImponibleNoIva column: 'prcsnoiv'
            iceGenerado column: 'prcs_ice'
            retencionIvaBienes column: 'prcsrtbn'
            retencionIvaServicios column: 'prcsrtsr'
            retencionIva column: 'prcsrtiv'

            tipoRetencion column: 'prcstprt'

            retencionSerie1 column: 'prcsrts1'
            retencionSerie2 column: 'prcsrts2'
            retencionSecuencial column: 'prcsrtsc'
            retencionAutorizacion column: 'prcsrtat'

            pagoAux column: 'pgax__id'

            sustentoTributario column: 'sstr__id'
            tipoComprobanteSri column: 'tpcp__id'

            fechaIngresoSistema column: 'prcsfcis'

            facturaEstablecimiento column: 'prcsfces'
            facturaPuntoEmision column: 'prcsfcpe'
            facturaSecuencial column: 'prcsfcsc'
        }
    }
    static constraints = {
        padre(blank: true, nullable: true, attributes: [title: 'padre'])
        impuesto(blank: true, nullable: true, attributes: [title: 'impuesto'])
        valor(blank: true, nullable: true, attributes: [title: 'valor'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        descripcion(size: 1..255, blank: true, nullable: true, attributes: [title: 'descripcion'])
        gestor(blank: true, nullable: true, attributes: [title: 'gestor'])
        usuario(blank: true, nullable: true, attributes: [title: 'usuario'])
        contabilidad(blank: true, nullable: true, attributes: [title: 'contabilidad'])
        proveedor(blank: true, nullable: true, attributes: [title: 'proveedor'])
        tipoPago(blank: true, nullable: true, attributes: [title: 'tipoPago'])
        estado(blank: true, maxSize: 1, attributes: [title: 'estado'])
        adquisicion(blank: true, nullable: true, attributes: [title: 'adquisicion'])
        fact(blank: true, nullable: true, attributes: [title: 'factura'])
        documento(blank: true, nullable: true, size: 1..40)
        centroCosto(blank: true, nullable: true, attributes: [title: 'centroCosto'])
        ordenCompra(blank: true, nullable: true, attributes: [title: 'ordenCompra'])
        transferencia(blank: true, nullable: true, attributes: [title: 'transferencia'])
        rolPagos(blank: true, nullable: true, attributes: [title: 'rolPagos'])
        tipoComprobanteId(blank: true, nullable: true, attributes: [title: 'tipoComprobanteId'])
        tipoSoporte(blank: true, nullable: true, attributes: [title: 'tipoSoporte'])
        fechaRegistro(blank: true, nullable: true, attributes: [title: 'fechaRegistro'])
        fechaEmision(blank: true, nullable: true, attributes: [title: 'fechaEmision'])
        procesoSerie01(blank: true, nullable: true, maxSize: 3, attributes: [title: 'procesoSerie01'])
        procesoSerie02(blank: true, nullable: true, maxSize: 3, attributes: [title: 'procesoSerie02'])
        secuencial(blank: true, nullable: true, attributes: [title: 'secuencial'], size: 1..14)
        autorizacionSRI(blank: true, nullable: true, maxSize: 10, attributes: [title: 'autorizacionSRI'])
        baseImponibleIva0(blank: true, nullable: true, attributes: [title: 'baseImponibleIva0'])
        baseImponibleIva(blank: true, nullable: true, attributes: [title: 'baseImponibleIva'])
        ivaGenerado(blank: true, nullable: true, attributes: [title: 'ivaGenerado'])
        baseImponibleNoIva(blank: true, nullable: true, attributes: [title: 'baseImponibleNoIva'])
        iceGenerado(blank: true, nullable: true, attributes: [title: 'iceGenerado'])
        retencionIvaBienes(blank: true, nullable: true, attributes: [title: 'retencionIvaBienes'])
        retencionIvaServicios(blank: true, nullable: true, attributes: [title: 'retencionIvaServicios'])
        retencionIva(blank: true, nullable: true, attributes: [title: 'retencionIva'])

        tipoRetencion(blank: true, nullable: true, attributes: [title: 'tipo de rentencion: bienes o servicios'])

        retencionSerie1(blank: true, nullable: true)
        retencionSerie2(blank: true, nullable: true)
        retencionSecuencial(blank: true, nullable: true)
        retencionAutorizacion(blank: true, nullable: true)

        pagoAux(blank: true, nullable: true)

        sustentoTributario(blank: true, nullable: true)
        tipoComprobanteSri(blank: true, nullable: true)

        fechaIngresoSistema(blank: true, nullable: true)

        facturaEstablecimiento(blank: true, nullable: true)
        facturaPuntoEmision(blank: true, nullable: true)
        facturaSecuencial(blank: true, nullable: true)
    }
}