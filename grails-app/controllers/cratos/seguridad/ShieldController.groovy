package cratos.seguridad

class ShieldController {
    def loginService
    def ataques = {
        def msn="Se ha detectado que esta ejecutando una acción que atenta contra la seguridad del sistema.<br>Dicha accion sera registrada en su historial.<br>"
        render(view:"advertencia",model:[msn:msn])
    }

    def error404 = {
        def msn="Esta tratando de ingresar a una accion no registrada en el sistema. Por favor use las opciones del menu para navegar por el sistema."
        render(view:"advertencia",model:[msn:msn])
    }
    def error403 = {
        def msn="Esta tratando de ingresar a una accion a la cual no tiene privilegios o estos han expirado."
        render(view:"advertencia",model:[msn:msn])
    }
    def error = {
        def msn="Ha ocurrido un error interno."
        try{
            def er = new ErrorLog()
            er.fecha=new Date()
            er.error=request["exception"].message?.encodeAsHTML()
            er.causa=request["exception"].cause?.message?.encodeAsHTML()
            er.url=request["javax.servlet.forward.request_uri"];
            er.usuario=session.usuario
            er.save()
           // println " \n<===Error Aqui===> "+request["javax.servlet.forward.request_uri"]
            //println " \n<===Que eres pal burro?????? ===> "+request["exception"].message?.encodeAsHTML()
            //println " \n<===Causa===> "+request["exception"].cause?.message?.encodeAsHTML()
            
        }catch (e){
            println "error en error "+e
        }
        render(view:"advertencia",model:[msn:msn,error:true])
    }
    def comprobarPassword = {
        if(request.method=='POST'){
            println "comprobar password "+params
            def resp=loginService.autorizaciones(session.usuario,params.atrz)
            render(resp)
        }else{
            response.sendError(403)
        }
    }
}
