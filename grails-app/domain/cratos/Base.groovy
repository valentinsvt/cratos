package cratos
class Base implements Serializable {
    double impuestosFraccion
    double excesoHasta
    double fraccionBasica
    Contabilidad periodo
    double porcentaje
    static mapping = {
        table 'base'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'base__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'base__id'
            impuestosFraccion column: 'baseimps'
            excesoHasta column: 'baseexcs'
            fraccionBasica column: 'basefrcn'
            periodo column: 'cont__id'
            porcentaje column: 'basepcnt'
        }
    }
    static constraints = {
        periodo(blank: false, nullable: false, attributes: [title: 'periodo'])
        fraccionBasica(blank: false, nullable: false, attributes: [title: 'frcn'])
        excesoHasta(blank: true, nullable: true, attributes: [title: 'exceso'])
        impuestosFraccion(blank: false, nullable: false, attributes: [title: 'impuestos'])
        porcentaje(blank: false, nullable: false, attributes: [title: 'porcentaje'])
    }
}