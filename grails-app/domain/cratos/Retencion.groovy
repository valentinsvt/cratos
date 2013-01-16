package cratos
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


        }
    }
    static constraints = {
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        ruc(blank: false,nullable: false,size:10..13)
        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        telefono(size: 1..15, blank: true, nullable: true, attributes: [title: 'telefono'])
        persona(size: 1..63, blank: true, nullable: true, attributes: [title: 'persona'])
        numero(size: 1..15, blank: true, nullable: true, attributes: [title: 'numero'])
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        proveedor(blank: true, nullable: true, attributes: [title: 'proveedor'])
        numeroComprobante(size: 1..20,blank: true, nullable: true, attributes: [title: 'Número de comprobante'])
    }
}