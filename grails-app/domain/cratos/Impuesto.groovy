package cratos
class Impuesto implements Serializable {

    String nombre
    String codigo
    double porcentaje
    double retencion

    static mapping = {
        table 'impt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'impt__id'
        id generator: 'identity'
        version false
        columns {
            nombre column: 'imptnmbr'
            codigo column: 'imptcdgo'
            porcentaje column: 'imptpctj'
            retencion column: 'imptrtcn'
        }
    }
    static constraints = {
        nombre(size: 1..40, blank: false, attributes: [title: 'descripcion'])
        codigo(size: 1..4, blank: false, attributes: [title: 'codigo'])

    }
}