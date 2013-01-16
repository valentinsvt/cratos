package cratos.seguridad

class Prfl implements Serializable{
    String nombre
    String descripcion
    Prfl   padre
    String observaciones
    static auditable=[ignore:[]]
    
    static hasMany = [permisos: Prms, perfiles: Prfl ]
    
	
    static mapping = {
        table 'prfl'
        cache usage:'read-write'
        version false
        id generator: 'identity'
        sort  nombre: "asc"
        columns {
            id column: 'prfl__id'
            nombre column: 'prflnmbr'
            descripcion column: 'prfldscr'
            padre column: 'prflpdre'
            observaciones column: 'prflobsr'
        }
    }
	
    static constraints = {
       
    }
    String toString(){
        return "${this.nombre}"
    }
}
