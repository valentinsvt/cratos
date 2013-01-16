package cratos.seguridad

class Audt implements Serializable {
    Usro usuario
    Prfl perfil
    String accion
    String controlador
    int registro
    String dominio
    String campo
    String old_value
    String new_value
    Date fecha
    String operacion
    
    static mapping = {
        table: 'audt'
        cache usage:'read-write', include:'non-lazy'
       	id column:'audt__id'
        id generator:'identity'
        version false
        columns {
            id column: 'audt__id'
            usuario column:'usro__id'
            perfil column:'prfl__id'
            accion column: 'audtaccn'
            controlador column: 'audtctrl'
            registro column: 'reg_id'
            dominio column:'audttbla'
            campo column:'audtcmpo'
            old_value column:'audtoldv'
            new_value column:'audtnewv'
            fecha column:'audtfcha'
            operacion column: 'audtoprc'
        }
    }
    
    static constraints = {
        usuario(blank:false, nullable:false)
        fecha(blank:true, nullable:true)
        accion(blank:false, nullable:false)
        perfil(blank:false, nullable:false)
        controlador(blank:false, nullable:false)
        registro(blank:false, nullable:false)
        dominio(blank:false, nullable:false)
        campo(blank:true, nullable:true)
        old_value(blank:true,nullable:true)
        new_value(blank:true,nullable:true)
        operacion(blank:false, nullable:false)
    }
    
    String toString(){
        return "${this.usuario} ${this.dominio} ${this.operacion}"
    }
    
}
