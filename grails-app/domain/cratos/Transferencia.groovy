package cratos
class Transferencia implements Serializable {
    String registro
    String estado
    Date fecha
    Empresa empresa
    Bodega bodegaRecibe
    Bodega bodegaSale
    String observaciones

    static auditable = true

    static mapping = {
        table 'trnf'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'trnf__idr'
        id generator: 'identity'
        version false
        columns {
            id column: 'trnf__id'
            registro column: 'trnfrgst'
            estado column: 'trnfetdo'
            fecha column: 'trnffcha'
            empresa column: 'empr__id'
            bodegaRecibe column: 'bdgarcbe'
            bodegaSale column: 'bdgasale'
            observaciones column: 'trnfobsr'
        }
    }
    static constraints = {
        registro(size: 1..1, blank: true, nullable: true, attributes: [title: 'registro'])
        estado(size: 1..1, blank: true, nullable: true, attributes: [title: 'estado'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        bodegaRecibe(blank: true, nullable: true, attributes: [title: 'bodega recibe'])
        bodegaSale(blank: true, nullable: true, attributes: [title: 'bodega sale'])
        observaciones(blank: true, nullable: true, size: 1..127, attributes: [title: 'observaciones'])
    }
}