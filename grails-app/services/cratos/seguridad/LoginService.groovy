package cratos.seguridad

class LoginService {

    boolean transactional = true
    static scope = 'session'

    Usro login(user, pass) {
    def usuario = Usro.findWhere(login: user, password: pass.trim().encodeAsMD5() , activo:1 )
        if (usuario) {
            if (this.verificarAccesoUsuario(usuario)) {
                return usuario
            } else {
            	return null
            }
        }
        else{
            return null
        }
    }

    boolean verificarAccesoUsuario(user) {
        def usuario = user
        def hoy = new Date()
        if(usuario.accesos.size() > 0) {
            usuario.accesos.findAll { fila ->
                if(hoy.after(fila.accsFechaInicial) && hoy.before(fila.accsFechaFinal)) {
                    return false
                }
            }
        }
        else
           return true

        return true
    }

    List perfiles(user){
        def lista=[]
        user.sesiones.sort({it.perfil}).each {
            lista.add(it.perfil)
            //println " it  "+it.perfil
        }
        return lista.toArray()
    }

    List alertas(user){
        def lista=[]
        lista=cratos.alertas.Alerta.findAll("from Alerta where usro=${user.id} and fec_recibido is null order by fec_envio",[max:4, offset:0])

        return lista
    }

    boolean autorizaciones(usuario,pass) {
        def us = Usro.findWhere(login: usuario.login, autorizacion: pass.trim().encodeAsMD5(), activo:1 )
        if (us) {
            return true
        }
        else{
            return false
        }
    }




}
