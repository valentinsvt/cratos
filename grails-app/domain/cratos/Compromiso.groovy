package cratos
class Compromiso implements Serializable {
    int numero
    AsignacionPresupuestaria asignacionPresupuestaria
    EjecucionPresupuestaria ejecucionPresupuestaria
    double valor
    static mapping = {
        table 'cmps'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'asnt__id'
        id generator: 'identity'
        version false
        columns {
            numero column: 'asntnmro'
            asignacionPresupuestaria column: 'asignacion'
            ejecucionPresupuestaria column: 'observaciones'
            valor column: 'cmps__id'
        }
    }
    static constraints = {
        numero(blank: false, attributes: [title: 'numero'])
        asignacionPresupuestaria(blank: true, nullable: true, attributes: [title: 'asignacionPresupuestaria'])
        ejecucionPresupuestaria(blank: true, nullable: true, attributes: [title: 'ejecucionPresupuestaria'])
        valor(blank: false, attributes: [title: 'valor'])
    }
}