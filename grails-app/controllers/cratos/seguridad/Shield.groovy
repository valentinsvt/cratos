package cratos.seguridad

class Shield {
    def beforeInterceptor = [action: this.&auth, except: 'login']
    /**
     * Verifica si se ha iniciado una sesión
     * Verifica si el usuario actual tiene los permisos para ejecutar una acción
     */
    def auth() {

//        println "AUTH SHIELD: an " + actionName + " cn " + controllerName + "  "

//        println session
        session.an = actionName
        session.cn = controllerName
        session.pr = params
        if (!session.usuario || !session.perfil) {
//            println "1"
            redirect(controller: 'login', action: 'login')
            session.finalize()
            return false
        } else {

            if (session.empresa.ordenCompra == '0' && controllerName == "ordenCompra") {
                //si la empresa no utiliza ordenes de compra e intenta acceder al controlador se redirecciona a adquisiciones
                redirect(controller: "adquisiciones", action: "list")
//                return false
            }

//            println "2"
            //verificacion de permisos
            if (!session.unidad) {
                if (controllerName == "proyecto") {
                    if (this.isAllowed())
                        return true
                    response.sendError(403)
                    return false
                } else {
                    try {
//                        println "3"
                        def usuario = session.usuario
//                        session.empresa = usuario.unidad
                        if (this.isAllowed())
                            return true

                        response.sendError(403)
                        return false
                    } catch (e) {
//                        println "4"
                        redirect(controller: 'login', action: 'login')
                        session.finalize()
                        return false
                    }
                }
            } else {
                if (this.isAllowed())
                    return true
                response.sendError(403)
                return false
            }
        }
    }

    boolean isAllowed() {

//        try {
//            if (session.permisos[actionName] == controllerName)
//                return true
//        } catch (e) {
//            println "Shield execption e: " + e
//            return true
//        }
//        return true
        return true
    }
}
 
