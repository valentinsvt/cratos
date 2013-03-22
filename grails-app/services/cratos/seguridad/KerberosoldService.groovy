package cratos.seguridad

import java.sql.Connection
import java.sql.DriverManager
import java.text.SimpleDateFormat
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.web.context.request.RequestContextHolder

class KerberosoldService {

    boolean transactional = true
    def dbConnectionService
    def dataSource
    def noAuditables = ["constraints", "log", "auditable", "version", "errors", "attached", "metaClass", "mapping", "class", "id", "hasMany", "dirty", "dirtyPropertyNames"]
    def sessionFactory
    def messageSource
    def session
    //principal servicio de seguridad
    public save(params, dominio, perfil, usuario) {
        session = sessionFactory.getCurrentSession()
        def nuevo = dominio.newInstance()
        def old
        def listAudt = []
        def band = true
        def audt
        def sql
        def sdf = new SimpleDateFormat("dd/MM/yyyy");
        def f

        try {
            params.each {
                if (it?.key =~ "fecha") {
                    if (it.value != "" && it.value != null && it.value != "null" && it.value?.trim().size() > 6) {
                        f = sdf.parse(it.value?.toString())
                        it.value = f
                    } else {
                        it.value = null
                    }
                    //println "clase del dato " + it.key + " ==>   valor final " + it.value
                }

            }
        } catch (e) {
            println "error params " + e
        }
        try {

            if (params.id != null && params.id != "") {
                old = dominio.get(params.id)
                def clone = dominio.newInstance(old.properties)
                nuevo = old

                // println "   kerberos----------------------------\n\n " + dominio

                if (nuevo.properties.keySet().contains("lugar") && params.keySet().contains("lugar")) {
                    if (params.lugar != null && params.lugar != "" && params.lugar != "null") {
                        nuevo.lugar = params.lugar
                        params.remove("lugar.id")
                    } else
                        nuevo.lugar = old.lugar
                    //println "params lugar " + nuevo.lugar
                }

                params.each {
                    try {
                        switch (nuevo[it.key].class) {
                            case "class java.lang.Float":
                                // println "0   WTF CAMBIA EL FORMATO DE LOS NUMEROS!!!!"
                                // println " tipo " + it.key + " --> " + nuevo[it.key].class
                                params[it.key] = params[it.key].toFloat()
                                break;
                            case "class java.lang.Double":
                                // println "1   WTF CAMBIA EL FORMATO DE LOS NUMEROS!!!!"
                                //params[it.key] =  params[it.key].replaceAll("\\.",",")
                                params[it.key] = params[it.key].toDouble()
                                //  println " tipo " + it.key + " --> " + nuevo[it.key].class + " value  " + it
                                break;
                        }
                    } catch (e) {
//                        println "Error pendejo en el cambio de formato de numeros"
                    }
                }

                nuevo.properties = params
                old = dominio.get(params.id)
                def ignore =  noAuditables
                nuevo.id = old.id

                clone.properties.each {
                    if (clone.properties?.hasMany?.keySet()?.contains(it.key)) {
                        ignore.add(it.key)
                        noAuditables.add(it.key)
                    }
                    if (it.key != "constraints") {
                        def n = nuevo.properties[it.key]

                        if ((nuevo.properties[it.key]) && (nuevo.properties[it.key]).class == java.lang.String && (nuevo.properties[it.key])?.size() > 255) {
                            n = (nuevo.properties[it.key]).substring(0, 255)
                        }
                        if (it.value != nuevo.properties[it.key]) {
                            //println "asi"
                            if (!ignore.contains(it.key)) {
                                // println "dif ! " + it.key + " viejo  " + it.value + "  actual " + nuevo.properties[it.key] + " en el log " + n
                                sql = """insert into audt (audt__id,usro__id,prfl__id,audtaccn,audtctrl,reg_id,audttbla,audtcmpo,audtoldv,audtnewv,audtfcha,audtoprc)
                                values (default,${usuario.id},${perfil.id},'${params.actionName}','${params.controllerName}',
                                           ${old.id.toInteger()},'${dominio.getName()}','${it.key}','${it.properties[it.key]}','${n}','${new Date().format("yyyy/MM/dd hh:mm:ss")}','UPDATE') """
                                listAudt.add(sql)
                                sql = null
                            }

                        }
                    }
                }
                if (nuevo.save(flush: true)) {
                    def cn = dbConnectionService.getConnection()
                    listAudt.each {
                        try {
                            println "sql " + it
                            if (!cn.execute(it)) {
                                band = false
                                //aqui se deberia hacer algo
                            }
                        } catch (e) {
                            println "ERROR!!!: error en la auditoria "
                            println " audt " + e
                        }

                    }
                    cn.close()
                    session.flush()

                    return nuevo

                }
                else {
                    println "ERROR!!!: error en el save " + nuevo.properties.errors

                    return nuevo
                }

            } else {
                //println "INSERT \n" + dominio
                nuevo.properties = params
                audt = new Audt()
                audt.id = null
                audt.usuario = usuario
                audt.operacion = "INSERT"
                audt.accion = (params.actionName) ? params.actionName : "N.A."
                audt.perfil = perfil
                audt.controlador = (params.controllerName) ? params.controllerName : "N.A."
                audt.old_value = null
                audt.new_value = null
                audt.fecha = new Date()
                audt.dominio = dominio.getName()
                audt.campo = null
//                nuevo.properties.each{
                //                    if(it.key!="constraints")
                //                    println "-> "+it.key+" === "+it.value
                //                }
                if (nuevo.save(flush: true)) {
                    audt.registro = nuevo.id
                    if (!audt.save(flush: true)) {
                        band = false
                        println "ERROR!!!: error en la auditoria "
                        //aqui deberia hacer algo
                    }
                    session.flush()
                    session.clear()
                    //session.clear()
                    //println "si grabo wtf despues del flush "
                    return nuevo

                }
                else {
                    println "errores :" + nuevo.properties.errors
                    println "ERROR!!!: error en el save (save)"
                    return nuevo
                }
            }


        } catch (e) {
            println "ERROR: kerberos"
            println "catch " + e + "  causa " + e.cause
            println " ------------ "
            return nuevo
        }

    }

    /**
     *
     * @param params toma params.id para eliminar, p.controllerName, p.actionName
     * @param dominio
     * @param perfil
     * @param usuario
     * @return
     */
    public delete(params, dominio, perfil, usuario) {
        session = sessionFactory.getCurrentSession()
        //println "delete kerberos " + params
        def old = dominio.get(params.id)

        def ignore =  noAuditables
        def listAudt = []
        def band = true
        def sql
        //println " DELETE KERBEROS params !!!\n " + params
        old.properties.each {
            if (!ignore.contains(it.key)) {
                def anterior = old.properties[it.key]
//                println anterior
//                println anterior?.class
//                println anterior?.class.toString()
                if (anterior && anterior.class.toString() =~ "cratos") {
//                    println " original " + anterior + " clase " + anterior.class
//                    println "aqui deberia cambiar "
                    anterior = anterior.id
//                    println "original value cambiado " + anterior
                }
                if (anterior && anterior.class == java.lang.String) {
//                    println "replaceAlls"
                    anterior = (old.properties[it.key]).replaceAll("\\\n", "").replaceAll("\\\t", "").replaceAll(";", "").replaceAll("'", "").replaceAll("\"", "")
                    if (anterior.size() > 255) {
                        anterior = anterior[0..254]
                    }
//                    println "despues de remplazar " + anterior
                }
//                println "+++++++++++++++++++++++++++++++++="
                sql = """insert into audt (audt__id,usro__id,prfl__id,audtaccn,audtctrl,reg_id,audttbla,audtcmpo,audtoldv,audtnewv,audtfcha,audtoprc)
                                values (default,${usuario.id},${perfil.id},'${params.actionName}','${params.controllerName}',
                                           ${old.id.toInteger()},'${dominio.getName()}','${it.key}','${anterior}',' BORRADO ','${new Date().format("yyyy/MM/dd hh:mm:ss")}','DELETE') """

                listAudt.add(sql)
                sql = null
            }

        }

        try {
            old.delete(flush: true)

        } catch (e) {
            println "error delete " + e
            return false
        }
        def cn = dbConnectionService.getConnection()
        listAudt.each {
//            println it
            cn.execute(it)
        }
        cn.close()
        //println "borrando !! : " + band
        session.flush()
        if (band)
            return true
        else
            return false
    }

    public generarEntradaAuditoria(params, dominio, campo, newValue, oldValue, perfil, usuario) {
        def cn = dbConnectionService.getConnection()
        def band = true
        def sql = """insert into audt (audt__id,usro__id,prfl__id,audtaccn,audtctrl,reg_id,audttbla,audtcmpo,audtoldv,audtnewv,audtfcha,audtoprc)
                                values (default,${usuario.id},${perfil.id},'${params.actionName}','${params.controllerName}',
                                           ${params.id},'${dominio.getName()}','${campo}','${oldValue}',' ${newValue} ','${new Date().format("yyyy/MM/dd hh:mm:ss")}','UPDATE') """
        //println "entrada audt " + sql
        if (!cn.execute(sql)) {
            band = false
            println "ERROR: en auditoria (delete)"
            //aqui se deberia hacer algo
        }
        cn.close()
        return band
    }
/**
 *
 * @param nuevo objeto a guardar
 * @param dominio Dominio
 * @param perfil
 * @param usuario
 * @param actionName
 * @param controllerName
 * @param session
 * @return
 *
 * flow.producto= kerberosService.saveObject( flow.producto,ProductoBancario, session.perfil, session.usuario,actionName,controllerName,session)
 if(flow.producto.errors.getErrorCount()!=0){
 MANEJAR ERRORES AQUI
 } else {
 NO OCURRIERON ERRORES
 }*
 */
    public saveObject(nuevo, dominio, perfil, usuario, actionName, controllerName, session) {
        session = sessionFactory.getCurrentSession()
        def old
        def audt
        def listAudt = []
        def sql
        try {

            nuevo.constraints.each { pr ->

                if (pr.getValue().propertyType == java.lang.Integer || pr.getValue().propertyType == java.lang.Float || pr.getValue().propertyType == java.lang.Double) {
//                    println "\t" + pr.getKey()
//                    println "\t" + pr.getValue().propertyType
                    def val = nuevo[pr.getKey()]
                    val = val.toString()
//                    println val
                    val.replaceAll("\\.", "")
                    val.replaceAll(",", "\\.")
//                    println val
                    if (pr.getValue().propertyType == java.lang.Integer) {
                        val = val.toInteger()
                    } else if (pr.getValue().propertyType == java.lang.Float) {
                        val = val.toFloat()
                    } else if (pr.getValue().propertyType == java.lang.Double) {
                        val = val.toDouble()
                    }
//                    println val.class
                    nuevo[pr.getKey()] = val
                }

            }

            if (nuevo.id == null) { //Insert
                audt = null
                audt = new Audt()

                if (nuevo.save(flush: false)) {
                    //println "si grabo nuevo wtf " + nuevo.class + " !!! audt " + audt.id + " " + audt
                    audt.withTransaction { status ->
                        audt.registro = nuevo.id
                        audt.usuario = usuario
                        audt.operacion = "INSERT"
                        audt.accion = (actionName) ? actionName : "N.A."
                        audt.perfil = perfil
                        audt.controlador = (controllerName) ? controllerName : "N.A."
                        audt.old_value = null
                        audt.new_value = null
                        audt.fecha = new Date()
                        audt.dominio = nuevo.class
                        audt.campo = null
                        audt.save(flush: false)
                        if (status.isCompleted())
                            println "si se completo"
                    }
                    session.flush()
                    return nuevo
                    audt = null
                }
                else {
                    println "errores :" + nuevo.properties.errors
                    println "ERROR!!!: error en el save (save)"
                    return nuevo
                }
            } else { // Update
                old = dominio.get(nuevo.id)
                def ignore = noAuditables
                def names = old.dirtyPropertyNames
                //println " Save object OLD !!!! \n " + old.id + "  " + dominio
                //println "ignore!! "+ignore
                for (name in names) {
                    def originalValue = old.getPersistentValue(name)
                    def newValue = old.properties[name]
                    if (originalValue?.class?.toString() =~ "cratos") {
                        //println  " name --> "+name+ " original "+originalValue+" clase "+originalValue.class
                        // println "aqui deberia cambiar "
                        originalValue = originalValue?.id
                        newValue = newValue.id
                        //println "original value cambiado "+originalValue+" nuevo "+newValue
                    }
                    if (!ignore.contains(name)) {
                        sql = "insert into audt (audt__id,usro__id,prfl__id,audtaccn,audtctrl,reg_id,audttbla,audtcmpo,audtoldv,audtnewv,audtfcha,audtoprc) values (default,${usuario.id},${perfil.id},'${actionName}','${controllerName}',${old.id.toInteger()},'${nuevo.class}','${name}','${originalValue}','${newValue}','${new Date().format("yyyy/MM/dd hh:mm:ss")}','UPDATE') "
                        //println "sql insert audt "+sql
                        listAudt.add(sql)
                        sql = null
                    }
                }//for
                old.discard()
                old.finalize()
                old = null
                println "antes del save " + nuevo.id
                if (nuevo.save(flush: true)) {
                    println "si GRABO "
                    session.flush()
                    def cn = dbConnectionService.getConnection()
                    listAudt.each {
                        try {

                            cn.execute(it.trim().toString())

                        } catch (e) {
                            println "ERROR!!!: error en la auditoria "
                            println " audt " + e
                        }

                    }
                    cn.close()
                    return nuevo

                }
                else {
                    println "ERROR!!!: error en el save " + nuevo.properties.errors

                    return nuevo
                }


            }
        } catch (e) {
            println "\n error try save ob " + e
            return nuevo
        }

    }

    def insertaKerberos(id, usuario, perfil) {
        def audt = new Audt()
        //println "si grabo wtf " + nuevo.class + " !!! audt " + audt.id + " " + audt
        audt.withTransaction { status ->
            audt.registro = id
            audt.usuario = usuario
            audt.operacion = "INSERT"
            audt.accion = (actionName) ? actionName : "N.A."
            audt.perfil = perfil
            audt.controlador = (controllerName) ? controllerName : "N.A."
            audt.old_value = null
            audt.new_value = null
            audt.fecha = new Date()
            audt.dominio = nuevo.class
            audt.campo = null
            audt.save(flush: false)
            if (status.isCompleted())
                println "si se completo"
        }
    }


    /**
     *
     * @param dominio
     * @param operacion
     * @return
     *
     *@comment operacion debe ser 1 para insert 2 para update 3 para delete


     */
    def logObject(domain,operacion){

        println "domain "+domain+" id "+domain.id
        def session = RequestContextHolder.currentRequestAttributes().getSession()
        def usuario = session.usuario
        def perfil = session.perfil
        def actionName=session.an
        def controllerName=session.cn
        def old
        def audt
        def listAudt = []
        def sql
        def cn = dbConnectionService.getConnection()
        try {
            switch (operacion){
                case 1:
                    //Insert
                    sql = "insert into audt (audt__id,usro__id,prfl__id,audtaccn,audtctrl,reg_id,audttbla,audtcmpo,audtoldv,audtnewv,audtfcha,audtoprc) values (default,${usuario.id},${perfil.id},'${actionName}','${controllerName}',${domain.id.toInteger()},'${domain.class}',null,null,null,'${new Date().format("yyyy/MM/dd hh:mm:ss")}','INSERT') "
                    println "sql insert audt "+sql
                    println "llego aca 2 "+cn
                    try {

                        println "ejecuto "+cn.execute(sql.trim().toString())
                    } catch (e) {
                        println "ERROR!!!: error en la auditoria "
                        println " audt " + e
                    }
                    println "llego aca 3"
                    break;

                case 2:
                    //update
                    def ignore = noAuditables
                    def names = old.dirtyPropertyNames
                    for (name in names) {
                        def originalValue = domain.getPersistentValue(name)
                        def newValue = domain.properties[name]
                        if (originalValue?.class?.toString() =~ "cratos") {
                            //println  " name --> "+name+ " original "+originalValue+" clase "+originalValue.class
                            // println "aqui deberia cambiar "
                            originalValue = originalValue?.id
                            newValue = newValue.id
                            //println "original value cambiado "+originalValue+" domain "+newValue
                        }
                        if (!ignore.contains(name)) {
                            sql = "insert into audt (audt__id,usro__id,prfl__id,audtaccn,audtctrl,reg_id,audttbla,audtcmpo,audtoldv,audtnewv,audtfcha,audtoprc) values (default,${usuario.id},${perfil.id},'${actionName}','${controllerName}',${domain.id.toInteger()},'${domain.class}','${name}','${originalValue}','${newValue}','${new Date().format("yyyy/MM/dd hh:mm:ss")}','UPDATE') "
                            println "sql update audt "+sql
                            listAudt.add(sql)
                            sql = null
                        }
                    }//for

                    listAudt.each {
                        try {

                            cn.execute(it.trim().toString())

                        } catch (e) {
                            println "ERROR!!!: error en la auditoria "
                            println " audt " + e
                        }

                    }

                    break;
                case 3:
                    old = domain
                    def ignore =  noAuditables
                    def band = true

                    old.properties.each {
                        if (!ignore.contains(it.key)) {
                            def anterior = old.properties[it.key]

                            if (anterior && anterior.class.toString() =~ "cratos") {

                                anterior = anterior.id

                            }
                            if (anterior && anterior.class == java.lang.String) {

                                anterior = (old.properties[it.key]).replaceAll("\\\n", "").replaceAll("\\\t", "").replaceAll(";", "").replaceAll("'", "").replaceAll("\"", "")
                                if (anterior.size() > 255) {
                                    anterior = anterior[0..254]
                                }

                            }

                            sql = """insert into audt (audt__id,usro__id,prfl__id,audtaccn,audtctrl,reg_id,audttbla,audtcmpo,audtoldv,audtnewv,audtfcha,audtoprc)
                                values (default,${usuario.id},${perfil.id},'${actionName}','${controllerName}',
                                           ${old.id.toInteger()},'${old.class()}','${it.key}','${anterior}',' BORRADO ','${new Date().format("yyyy/MM/dd hh:mm:ss")}','DELETE') """

                            listAudt.add(sql)
                            sql = null
                        }

                    }

                    listAudt.each {
//            println it
                        cn.execute(it)
                    }


                    break;
            }

            cn.close()
           println "depues del close"

        } catch (e) {
            println "\n error try log ob " + e
        }

    }


    ///////////////////////////////////////////////////Funciones de base de datos ////////////////////////////////////////


    def ejecutarProcedure(nombre, parametros) {
        def p = ""
        parametros.each {
            p += "" + it + ","
        }
        p = p.substring(0, p.length() - 1)
        def sql = " select " + nombre + "(" + p + ")"
        println "ejecutar Procedure " + sql
        def template = new JdbcTemplate(dataSource)
        def result = template.queryForMap(sql)
//        println "result " + result
        return result
    }

    def getJavaConnection() {
        Connection dbConnection
        try {
            dbConnection = DriverManager.getConnection("jdbc:postgresql://10.0.0.3:5432/cratos", "postgres", "postgres")
            println "coneccion " + dbConnection
        }
        catch (e) {
            println("Couldn’t get connection!  " + e);
        }
        return dbConnection
    }

///////////////////////////////////////////////////// ALERTAS \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


    boolean generarAlerta(from, to, mensaje, controlador, accion, id) {
        try {
            def alerta = new cratos.alertas.Alerta()
            alerta.from = from
            alerta.usro = to
            alerta.mensaje = mensaje
            alerta.controlador = controlador
            alerta.accion = accion
            alerta.id_remoto = id
            alerta.fec_envio = new Date()
            if (alerta.save(flush: true))
                return true
            else
                return false
        } catch (e) {
            println "error generar alerta " + e
            return false
        }

    }

}