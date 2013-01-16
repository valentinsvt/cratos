package cratos.alertas

class Alerta implements Serializable{

    cratos.seguridad.Usro from
    cratos.seguridad.Usro usro
    Date fec_envio
    Date fec_recibido
    String mensaje
    String controlador
    String accion
    int id_remoto
    static auditable=[ignore:['fec_envio','fec_recibido']]

    static mapping = {
        table: 'alertas'
        cache usage:'read-write', include:'non-lazy'
        version false
        id generator: 'identity'

        columns {
            id column: 'aler__id'
            from column: 'alerfrom'
            usro column: 'aler__to'
            fec_envio column: 'alerfcen'
            fec_recibido column: 'alerfcrc'
            mensaje column: 'alermesn'
            controlador column:'alerctrl'
            accion column: 'aleraccn'
            id_remoto column:'aleridrm'
            
        }

    }

    static constraints = {
        from(blank:false)
        usro(blank:false)
        fec_envio(blank:false)
        fec_recibido(nullable:true,blank:true)
        mensaje(size:5..200,blank:false)
        controlador(nullable:true,blank:true)
        accion(nullable:true,blank:true)
        id_remoto(nullable:true,blank:true)
    }
    String toString(){
        return "${this.id} ${this.mensaje}"
    }
}
