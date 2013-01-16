package cratos
class Periodo implements Serializable {
    Date fechaFin
    Date fechaInicio
    Integer numero
    Contabilidad contabilidad
    static mapping = {
        table 'prdo'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prdoetdo'
        id generator: 'identity'
        version false
        columns {
            id column: 'prdo__id'
            fechaFin column: 'prdofcfn'
            fechaInicio column: 'prdofcin'
            numero column: 'prdonmro'
            contabilidad column: 'cont__id'
        }
    }
    static constraints = {
        fechaFin(blank: true, nullable: true, attributes: [title: 'fechaFin'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'fechaInicio'])
        numero(blank: true, nullable: true, attributes: [title: 'numero'])
        contabilidad(blank: true, nullable: true, attributes: [title: 'contabilidad'])
    }

    String toString() {
        return "Desde " + this.fechaInicio.format("dd-MM-yyyy") + " hasta " + this.fechaFin.format("dd-MM-yyyy")
    }
}