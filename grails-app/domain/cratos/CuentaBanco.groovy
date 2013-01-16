package cratos
class CuentaBanco implements Serializable {
    Date fechaFin
    Date fechaInicio
    String numero
    TipoCuenta tipoCuenta
    Banco banco
    String observaciones
    static mapping = {
        table 'cnbn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cnbn__id'
        id generator: 'identity'
        version false
        columns {
            banco column: 'bnco__id'
            fechaFin column: 'cnbnfcfn'
            fechaInicio column: 'cnbnfcin'
            numero column: 'cnbnnmro'
            tipoCuenta column: 'tpcn__id'
            observaciones column: 'cnbnobsr'
        }
    }
    static constraints = {
        fechaFin(blank: true, nullable: true, attributes: [title: 'fechaFin'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'fechaInicio'])
        numero(size: 1..15, blank: false, attributes: [title: 'numero'])
        tipoCuenta(blank: true, nullable: true, attributes: [title: 'tipoCuenta'])
        banco(blank: true, nullable: true, attributes: [title: 'banco'])
        observaciones(blank: true, maxSize: 127, attributes: [title: 'observaciones'])
    }
}