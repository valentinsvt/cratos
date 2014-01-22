package cratos

import cratos.sri.Pais

class Retencion implements Serializable {

    Proceso proceso
    Contabilidad contabilidad
    Date fecha
    String ruc
    String direccion
    String telefono
    String persona
    String numero
    Empresa empresa
    Proveedor proveedor
    String numeroComprobante

//    ConceptoRetencionImpuestoRenta conceptoRetencionImpuestoRenta
    String numeroEstablecimiento
    String numeroPuntoEmision
    String numeroSecuencial
    String numeroAutorizacionComprobante
    String creditoTributario
    String tipoPago
    Date fechaEmision

    Pais pais
    String convenio
    String normaLegal

    static mapping = {
        table 'rtcn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rtcn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'rtcn__id'
            proceso column: 'prcs__id'
            contabilidad column: 'cont'
            fecha column: 'rtcnfcha'
            ruc column: 'rtcn_ruc'
            direccion column: 'rtcndrcn'
            telefono column: 'rtcntlef'
            persona column: 'rtcnprsn'
            numero column: 'rtcnnmro'
            empresa column: 'empr__id'
            proveedor column: 'prve__id'
            numeroComprobante column: 'rtcnnmcp'

//            conceptoRetencionImpuestoRenta column: 'crir__id'
            numeroEstablecimiento column: 'rtcnnmes'
            numeroPuntoEmision column: 'rtcnnmpe'
            numeroSecuencial column: 'rtcnnmsc'
            numeroAutorizacionComprobante column: 'rtcnnmac'
            creditoTributario column: 'rtcncrtr'
            tipoPago column: 'rtcnpago'
            fechaEmision column: 'rtcnfcem'
            pais column: 'pais__id'
            convenio column: 'rtcncnvn'
            normaLegal column: 'rtcnnmlg'

        }
    }
    static constraints = {
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        ruc(blank: false, nullable: false, size: 10..13)
        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        telefono(size: 1..15, blank: true, nullable: true, attributes: [title: 'telefono'])
        persona(size: 1..63, blank: true, nullable: true, attributes: [title: 'persona'])
        numero(size: 1..15, blank: true, nullable: true, attributes: [title: 'numero'])
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        proveedor(blank: true, nullable: true, attributes: [title: 'proveedor'])
        numeroComprobante(size: 1..20, blank: true, nullable: true, attributes: [title: 'Número de comprobante'])

//        conceptoRetencionImpuestoRenta(blank: true, nullable: true)
        numeroEstablecimiento(blank: true, nullable: true)
        numeroPuntoEmision(blank: true, nullable: true)
        numeroSecuencial (blank: true, nullable: true)
        numeroAutorizacionComprobante (blank: true, nullable: true)
        creditoTributario (size: 1..2, blank: true, nullable: true)
        tipoPago (blank: true, nullable: true)
        fechaEmision (blank: true, nullable: true)
        convenio (blank: true, nullable: true)
        normaLegal(blank: true, nullable: true)

        pais(blank: true, nullable: true)

    }
}