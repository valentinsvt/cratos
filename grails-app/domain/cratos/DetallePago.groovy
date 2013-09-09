package cratos
class DetallePago implements Serializable {
    RolPagos rolPagos
    RubroTipoContrato rubroTipoContrato
    String descripcion
    Empleado empleado
    double valor
    static mapping = {
        table 'dtpg'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtpg__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dtpg__id'
            rubroTipoContrato column: 'rbtc__id'
            empleado column: 'empl__id'
            rolPagos column: 'rlpg__id'
            valor column: 'dtpgvlor'
            descripcion column: 'dtpgdscr'
        }
    }
    static constraints = {
        rubroTipoContrato(blank: true, nullable: true, attributes: [title: 'rubroTipoContrato'])
        empleado(blank: true, nullable: true, attributes: [title: 'empleado'])
        rolPagos(blank: true, nullable: true, attributes: [title: 'rol de pagos'])
        valor(blank: true, nullable: true, attributes: [title: 'valor'])
        descripcion(blank: true,nullable: true,size: 1..124)
    }
}