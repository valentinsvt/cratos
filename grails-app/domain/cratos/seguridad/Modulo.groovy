package cratos.seguridad

class Modulo implements Serializable{
    String nombre
    String descripcion
    int    orden
    static auditable=[ignore:[]]

    static mapping = {
        table 'mdlo'
        cache usage:'read-write', include:'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id          column: 'mdlo__id'
            nombre      column: 'mdlonmbr'
            descripcion column: 'mdlodscr'
            orden       column: 'mdloordn'
        }
    }

    static constraints = {

    }
    String toString(){
        "${this.nombre}"
    }
}
