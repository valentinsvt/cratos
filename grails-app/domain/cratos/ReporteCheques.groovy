package cratos
class ReporteCheques implements Serializable {
    double debe
    double haber
    double saldo
    double saldoBancario
    String cheque
    String persona
    Date fecha
    String estado
    static mapping = {
        table 'rpch'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rpch__id'
        id generator: 'identity'
        version false
        columns {
            saldoBancario column: 'rpchslbn'
            saldo column: 'rpchsldo'
            haber column: 'rpchhber'
            debe column: 'rpchdebe'
            persona column: 'rpchprsn'
            cheque column: 'rpchchqe'
            fecha column: 'rpchfcha'
            estado column: 'rpchetdo'
        }
    }
    static constraints = {
        debe(blank: false, nullable: false, attributes: [title: "debe"])
        haber(blank: false, nullable: false, attributes: [title: "haber"])
        saldo(blank: false, nullable: false, attributes: [title: "saldo"])
        saldoBancario(blank: false, nullable: false, attributes: [title: "saldoBancario"])
        cheque(blank: false, nullable: false, attributes: [title: "cheque"])
        persona(blank: false, nullable: false, attributes: [title: "persona"])
        fecha(blank: false, nullable: false, attributes: [title: "fecha"])
        estado(blank: false, nullable: false, attributes: [title: "estado"])
    }
}