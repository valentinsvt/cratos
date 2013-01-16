package cratos.seguridad

class ValidarSesionController {
    def validarSesion = {
//        render "OK"
        if (session.usuario) {
            render "OK"
        } else {
            render "NO"
        }
    }
}
