package cratos
class ErrorCheques implements Serializable {
    Contabilidad contabilidad
    Comprobante comprobante
    Asiento asiento
    Double monto
    Double diferencia

    static mapping = {
        table 'cher'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cher__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'cher__id'
            monto column: 'cherchqe'
            asiento column: 'asnt__id'
            comprobante column: 'cmpr__id'
            contabilidad column: 'cont__id'
        }
    }
    static constraints = {
        contabilidad(blank: false, attributes: [title: 'contabilidad'])
        comprobante(blank: false, attributes: [title: 'comprobante'])
        asiento(blank: false, attributes: [title: 'asiento'])
        monto(blank: false, attributes: [title: 'monto'])
        diferencia(blank: false, attributes: [title: 'diferencia'])
    }
}