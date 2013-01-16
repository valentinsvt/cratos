package cratos
class Canton implements Serializable {

    String nombre;

    static mapping = {
        table 'cntn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cntn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'cntn__id'
            nombre column: 'cntnnmbr'
        }
    }
    static constraints = {

        nombre(maxSize: 60, nullable: false, blank: false, attributes: [title: 'nombrecanton'])

    }
}