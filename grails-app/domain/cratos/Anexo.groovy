package cratos
class Anexo implements Serializable {

    TipoComprobanteId tipoComprobantePorId
    Proveedor proveedor
    TipoSoporte tipoSoporte
    TipoComprobanteId tipoComprobantePorIdModificacion

    Date fechaRegistro
    Date fechaEmision

    String comprobanteSerie1
    String comprobanteSerie2
    String comprobanteSecuencial
    Integer comprobanteNumero

    String comprobanteModificacionSerie1
    String comprobanteModificacionSerie2
    Integer comprobanteModificacionSecuencial

    String autorizacionSri

    Double baseImponible0
    Double baseImponibleNo0
    Double iva
    Double noIva
    Double ice

    Double retencionBienes
    Double retencionServicios
    Double retencionIva

    String retencion1Serie1
    String retencion1Serie2
    Integer rentencion1Secuencial
    Date retencion1Fecha

    String retencion2Serie1
    String retencion2Serie2
    Integer rentencion2Secuencial
    Date retencion2Fecha


    static mapping = {
        table 'anxo'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'anxo__id'
        id generator: 'identity'
        version false
        columns {
            tipoComprobantePorId column: 'tcti__id'
            proveedor column: 'prve__id'
            tipoSoporte column: 'tpst__id'
            tipoComprobantePorIdModificacion column: 'tctimdfc'

            fechaRegistro column: 'anxofcrg'
            fechaEmision column: 'anxofcem'

            comprobanteSerie1 column: 'anxosr01'
            comprobanteSerie2 column: 'anxosr02'
            comprobanteSecuencial column: 'anxoscnc'
            comprobanteNumero column: 'anxonmcp'

            comprobanteModificacionSerie1 column: 'anxomds1'
            comprobanteModificacionSerie2 column: 'anxomds2'
            comprobanteModificacionSecuencial column: 'anxomdsc'

            autorizacionSri column: 'anxoatrz'

            baseImponible0 column: 'anxobszr'
            baseImponibleNo0 column: 'anxobsnz'
            iva column: 'anxo_iva'
            noIva column: 'anxonoiv'
            ice column: 'anxo_ice'

            retencionBienes column: 'anxortbn'
            retencionServicios column: 'anxortsr'
            retencionIva column: 'anxortiv'

            retencion1Serie1 column: 'anxos101'
            retencion1Serie2 column: 'anxos102'
            rentencion1Secuencial column: 'anxosc01'
            retencion1Fecha column: 'anxofc01'

            retencion2Serie1 column: 'anxos201'
            retencion2Serie2 column: 'anxos202'
            rentencion2Secuencial column: 'anxosc02'
            retencion2Fecha column: 'anxofc02'
        }
    }
    static constraints = {
        tipoComprobantePorId(blank: false, nullable: false, attributes: [title: 'tipoComprobantePorId'])
        proveedor(blank: false, nullable: false, attributes: [title: 'proveedor'])
        tipoSoporte(blank: false, nullable: false, attributes: [title: 'tipoSoporte'])
        tipoComprobantePorIdModificacion(blank: false, nullable: false, attributes: [title: 'tipoComprobantePorIdModificacion'])

        fechaRegistro(blank: true, nullable: true, attributes: [title: 'fechaRegistro'])
        fechaEmision(blank: true, nullable: true, attributes: [title: 'fechaEmision'])

        comprobanteSerie1(maxSize: 3, blank: true, nullable: true, attributes: [title: 'comprobanteSerie1'])
        comprobanteSerie2(maxSize: 3, blank: true, nullable: true, attributes: [title: 'comprobanteSerie2'])
        comprobanteSecuencial(blank: true, nullable: true, attributes: [title: 'comprobanteSecuencial'])
        comprobanteNumero(blank: true, nullable: true, attributes: [title: 'comprobanteNumero'])

        comprobanteModificacionSerie1(blank: true, nullable: true, attributes: [title: 'comprobanteModificacionSerie1'])
        comprobanteModificacionSerie2(blank: true, nullable: true, attributes: [title: 'comprobanteModificacionSerie2'])
        comprobanteModificacionSecuencial(blank: true, nullable: true, attributes: [title: 'comprobanteModificacionSecuencial'])

        autorizacionSri(maxSize: 10, blank: true, nullable: true, attributes: [title: 'autorizacionSri'])

        baseImponible0(blank: true, nullable: true, attributes: [title: 'baseImponible0'])
        baseImponibleNo0(blank: true, nullable: true, attributes: [title: 'baseImponibleNo0'])
        iva(blank: true, nullable: true, attributes: [title: 'iva'])
        noIva(blank: true, nullable: true, attributes: [title: 'noIva'])
        ice(blank: true, nullable: true, attributes: [title: 'ice'])

        retencionBienes(blank: true, nullable: true, attributes: [title: 'retencionBienes'])
        retencionServicios(blank: true, nullable: true, attributes: [title: 'retencionServicios'])
        retencionIva(blank: true, nullable: true, attributes: [title: 'retencionIva'])

        retencion1Serie1(maxSize: 3, blank: true, nullable: true, attributes: [title: 'retencion1Serie1'])
        retencion1Serie2(maxSize: 3, blank: true, nullable: true, attributes: [title: 'retencion1Serie2'])
        rentencion1Secuencial(blank: true, nullable: true, attributes: [title: 'rentencion1Secuencial'])
        retencion1Fecha(blank: true, nullable: true, attributes: [title: 'retencion1Fecha'])

        retencion2Serie1(maxSize: 3, blank: true, nullable: true, attributes: [title: 'retencion2Serie1'])
        retencion2Serie2(maxSize: 3, blank: true, nullable: true, attributes: [title: 'retencion2Serie2'])
        rentencion2Secuencial(blank: true, nullable: true, attributes: [title: 'rentencion2Secuencial'])
        retencion2Fecha(blank: true, nullable: true, attributes: [title: 'retencion2Fecha'])
    }
}