package cratos.seguridad

class ErrorLog {

    Date fecha
    String error
    String causa
    String url
    Usro usuario

    static mapping = {
        table 'logf'
        cache usage:'read-write', include:'non-lazy'
        id column:'logf__id'
        id generator:'identity'
        version false
        columns {
            id column:'logf__id'
            fecha column:'logffcha'
            error column:'logferro'
            causa column:'logfcaus'
            url column:'logf_url'
            usuario column:'logfusro'
        }
    }
    static constraints = {

        
    }
    String toString(){
        "${this.error}"
    }
}
