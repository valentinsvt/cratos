package cratos.seguridad

class AccionesController extends cratos.seguridad.Shield  {

    def dbConnectionService

    def index = {
        redirect(action: "configurarMenu")
    }

    /**
     * OJO. el módulo de noAsignadas es de ID = 0
     */
    def acciones = {
        def resultado = []
        def cn = dbConnectionService.getConnection()
        cn.eachRow("select mdlo__id, mdlonmbr from mdlo order by mdloordn"){d ->
            resultado.add([d.mdlo__id] + [d.mdlonmbr])
        }
        cn.close()
        render(view:"acciones", model:[lstacmbo: resultado])
    }

    def ajaxAcciones = {
        //println " ajaxAcciones---parametros: ${params}"

        def titulos = []
        def resultado = []
        def mdlo = params.mdlo
        def tipo = params.tipo
        if(params.mdlo?.size() > 0) mdlo = params.mdlo
        def cn = dbConnectionService.getConnection()
        def tx = ""
        tx = poneSQL(tipo, mdlo)
        //println "ajaxPermisos mdlo: ${mdlo}"
        if(tipo == '1'){
            titulos[0] = ['Permisos']+['Acción']+['Menú']+['Controlador']
        } else {
            titulos[0] = ['Permisos']+['Acción']+['Proceso']+['Controlador']
        }
        println "ajaxPermisos SQL: ${tx}"
        cn.eachRow(tx) { d ->
            resultado.add([d.accn__id] + [d.accnnmbr] + [d.accndscr] +[d.ctrlnmbr] + [d.mdlo__id])
        }
        //cn.disconnect() TODO preguntar si se cierra la conexión
        //println "-------------------------" + resultado
        if(resultado.size() == 0) {
            resultado[0] = ['0'] + ['<font color="red">no hay acciones</font>'] + [''] + [''] + ['']
        }
        cn.close()
        render(view:'detalle', model:[datos:resultado, mdlo__id:mdlo, tpac__id: tipo, titulos: titulos])
    }

    def grabaAccn = {
        //println "graba---------parametros: ${params}"
        def id  = params.id
        def dscr = params.dscr
        def cn = dbConnectionService.getConnection()
        def tx = "update accn set accndscr = '" + dscr + "' where accn__id = " + id
        //println "graba.... ${tx}"
        try {
            cn.execute(tx)
        }
        catch(Exception ex){
            println "Error al insertar:" + ex.getMessage()
        }
        cn.close()
        render("la accion '${dscr}' ha sido modificada")
    }

    def moverAccn = {
       println "moverAccn---------parametros: ${params}"
        def mdlo = params.mdlo
        def ids  = params.ids
        if(params.ids?.size() > 0) ids = params.ids; else ids = "null"
        def cn = dbConnectionService.getConnection()
        def tx = "update accn set mdlo__id = " + mdlo + " where accn__id in (" + ids +")"
        println "modificado.... ${tx}"
        try {
            cn.execute(tx)
        }
        catch(Exception ex){
            println "Error al insertar:" + ex.getMessage()
        }
        cn.close()
        render("Acciones movidas")
    }

    def sacarAccn = {
        println "sacarAccn---------parametros: ${params}"
        def ids  = params.ids
        if(params.ids?.size() > 0) ids = params.ids; else ids = "null"
        def cn = dbConnectionService.getConnection()
        def tx = ""
        tx = "update accn set mdlo__id = 0 where accn__id in (" + ids +")"
        //println "sacando.... ${tx}"
        try {
            cn.execute(tx)
        }
        catch(Exception ex){
            println "Error al insertar:" + ex.getMessage()
        }
        cn.close()
        //println "redirecciona con: " + params
        redirect(action: "ajaxAcciones", params: params)
    }

    def cambiaAccn = {
        println "cambia---------parametros: ${params}"
        def ids  = params.ids
        def tipo = params.tipo
        def tp = 0
        if(tipo == '1') {tp = 2} else {tp = 1}
        if(params.ids?.size() > 0) ids = params.ids; else ids = "null"
        def cn = dbConnectionService.getConnection()
        def modulo = Modulo.findByDescripcionLike("no%asignado")
        def tx = "update accn set mdlo__id = " + modulo.id + ", tpac__id = " + tp + " where accn__id in (" + ids +")"
        println "modificado.... ${tx}"
        try {
            cn.execute(tx)
        }
        catch(Exception ex){
            println "Error al insertar:" + ex.getMessage()
        }
        println "-----------modificado"
        cn.close()
        redirect(action: "ajaxAcciones", params: params)
    }


    def configurarAcciones = {
        def modulos = Modulo.list([sort:"orden"])
        def controladores = []
        def cn = dbConnectionService.getConnection()
        cn.eachRow("select distinct ctrlnmbr from ctrl where ctrl__id in (select  ctrl__id from accn where mdlo__id is not null)"){
            controladores.add(it.ctrlnmbr)
        }
        def tp = 1
        cn.eachRow("select tpac__id from tpac where upper(tpacdscr) like '%MENU%'"){
            tp = it.tpac__id
        }
        println tp

        [modulos:modulos, controladores:controladores, tipo_tpac:tp, titulo:'Men&uacute;s por M&oacute;dulo']
    }

    def procesos = {
        def modulos = Modulo.list([sort:"orden"])
        def controladores = []
        def cn = dbConnectionService.getConnection()
        cn.eachRow("select distinct ctrlnmbr from ctrl where ctrl__id in (select  ctrl__id from accn where mdlo__id is not null)"){
            controladores.add(it.ctrlnmbr)
        }
        def tp = 2  //hallar el valor desde la BD
        cn.eachRow("select tpac__id from tpac where upper(tpacdscr) like '%PROC%'"){
            tp = it.tpac__id
        }
        render(view: "configurarAcciones", model:[modulos:modulos, controladores:controladores, tipo_tpac:tp,
            titulo:'Procesos por M&oacute;dulo'])
    }


    def perfiles = {
        def modulos = Modulo.list([sort:"orden"])
        [modulos:modulos]
    }


    def guardarPermisos = {
        println "guardar permisos " + params
        def perfil = Prfl.get(params.perfil)
        def permisos = Prms.findAllByPerfil(perfil).accion
        //println "permisos "+permisos+" "+params.chk.clazz
        if(params.chk){
            params.chk.each {

                def accn = Accn.get(it)
                println "each accn "+it + " "+permisos.contains(accn)
                if(!(permisos.contains(accn))){
                    println "paso el if"
                    def perm = new Prms([accion:accn,perfil:perfil])
                    perm.save(flush:true)
                    println "errors "+perm.errors
                }
            }
            permisos.each {
                println "quitar "+it+" "+params.chk.toList()
                if(!(params.chk.toList().contains(it.id.toString()))) {
                    println "entro if del"
                    def perm = Prms.findByAccionAndPerfil(it,perfil).delete(flush:true)
                }
            }
        }else{
            permisos = Prms.findAllByPerfil(perfil)
            permisos.each {
                it.delete(flush:true)
            }
        }


        redirect(action: "perfiles")
    }

    def cargarAccionesPerfil = {
        //println "cargar a p "+params
        def perfil = Prfl.get(params.perfil)
        def permisos = Prms.findAllByPerfil(perfil).accion.id
        def modulos = Modulo.list()
        [modulos:modulos,permisos:permisos,perfil:perfil]
    }

    def cambiarTipo = {
        println "cambiar tipo "+params
        def accn = Accn.get(params.accn)
        accn.tipo= Tpac.get(params.val)
        render "ok"
    }

    def cambiarModulo = {
        println "cambiar tipo "+params
        def accn = Accn.get(params.accn)
        accn.modulo=Modulo.get(params.val)
        render "ok"
    }

    def cambiarModuloControlador = {
        println "cmc "+params
        def ctrl = Ctrl.findByCtrlNombre(params.ctrl)
        def acs = Accn.findAllByControl(ctrl)
        def modulo = Modulo.get(params.val)
        acs.each {
            it.modulo=modulo
            it.save(flush:true)
        }
        render "ok"
    }

    def cargarControladores = {
        println "cargar controladores"
        def i = 0
        grailsApplication.controllerClasses.each {
            //def  lista = Ctrl.list()
            def ctr =  Ctrl.findByCtrlNombre(it.getName())
            if(!ctr){
                ctr= new Ctrl([ctrlNombre:it.getName()])
                ctr.save(flush:true)
                i++
            }
        }
        render("Se han agregado ${i} Controladores")
    }

    def cargarAcciones = {

        println "cargar acciones"
        def ac = []
        def accs = [:]
        def i=0
        def ignore=["afterInterceptor","beforeInterceptor"]
        grailsApplication.controllerClasses.each {ct ->
            def t = []
            ct.getURIs().each{
                def s = it.split("/")
                if(s.size()>2)
                    if(!t.contains(s[2]))
                        if(!ignore.contains(s[2]))
                            if(!(s[2]=~"Service")){

                                def accn = Accn.findByAccnNombreAndControl(s[2],Ctrl.findByCtrlNombre(ct.getName()))

                                if(accn == null){
                                    println "if 2";
                                    accn = new Accn()
                                    accn.accnNombre = s[2]
                                    accn.control = Ctrl.findByCtrlNombre(ct.getName())
                                    accn.accnDescripcion = s[2]
                                    accn.accnAuditable = 1
                                    if(s[2] =~ "save" || s[2] =~ "update" || s[2] =~ "delete" || s[2] =~ "guardar")
                                        accn.tipo=Tpac.get(2)
                                    else
                                        accn.tipo = Tpac.get(1)
                                    accn.modulo = Modulo.findByDescripcionLike("no%asignado")
                                    accn.save(flush: true)
                                    i++
                                    println "errores " + accn.errors

                                }
                                t.add(s.getAt(2))
                            }

            }
            accs.put(ct.getName(),t)
            t=null
        }
        render("Se han agregado ${i} acciones")
    }

    def poneSQL(tipo, mdlo){
        return "select accn.accn__id, accnnmbr, accndscr, ctrlnmbr, accn.mdlo__id " +
            "from accn, mdlo, ctrl where mdlo.mdlo__id = accn.mdlo__id and " +
            "mdlo.mdlo__id = ${mdlo} and accn.ctrl__id = ctrl.ctrl__id and " +
            "tpac__id = ${tipo} order by ctrlnmbr, accnnmbr"
    }

    def poneSQLnull(tipo){
        return "select accn.accn__id, accnnmbr, accndscr, ctrlnmbr, accn.mdlo__id " +
            "from accn, ctrl where mdlo__id is null and accn.ctrl__id = ctrl.ctrl__id and " +
            "tpac__id = ${tipo} order by ctrlnmbr, accnnmbr"
    }


}
