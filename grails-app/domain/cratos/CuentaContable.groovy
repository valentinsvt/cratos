package cratos
class CuentaContable implements Serializable {
    Contabilidad contabilidad
    String observaciones
    Cuenta actual
    Cuenta antiguo

    static mapping = {
        table 'cnco'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cnco__id'
        id generator: 'identity'
        version false
        columns {
            antiguo column: 'cntaantg'
            actual column: 'cntaactl'
            contabilidad column: 'cont__id'
            observaciones column: 'cncoobsr'
        }
    }
    static constraints = {
        antiguo(blank: true, nullable: true, attributes: [title: 'antiguo'])
        actual(blank: true, nullable: true, attributes: [title: 'actual'])
        contabilidad(blank: true, nullable: true, attributes: [title: 'contabilidad'])
        observaciones(blank: false, attributes: [title: 'observaciones'])
    }
}