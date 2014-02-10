package cratos

import org.springframework.dao.DataIntegrityViolationException

class RubroController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def dbConnectionService
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [rubroInstanceList: Rubro.list(params), rubroInstanceTotal: Rubro.count()]
    }


    def rubros(){
        def tipos = TipoRubro.list([sort:"descripcion"])
        [tipos:tipos]
    }

    def cargaRubros(){
        def rubros = Rubro.findAllByTipoRubro(TipoRubro.get(params.id),[sort:"descripcion"])
        [rubros:rubros]
    }



    def create() {
        [rubroInstance: new Rubro(params)]
    }


    def addRubro(){
        println "params "+params
        def tipo = TipoRubro.get(params.tipo)
        def rubro
        if(params.id!=""){
            rubro=Rubro.get(params.id)
        }else{
            rubro=new Rubro()
        }
        rubro.descripcion=params.descripcion
        rubro.decimo=params.decimo
        rubro.gravable=params.grav
        rubro.iess=params.iess
        rubro.porcentaje=params.porcentaje.toDouble()
        rubro.valor=params.valor.toDouble()
        rubro.tipoRubro=tipo
        rubro.editable="1"
        if(!rubro.save(flush: true)){
            println "error rubro save "+rubro.errors
        }
        redirect(action: "cargaRubros",id: params.tipo)
    }


    def composicion(){
        def tipos = TipoContrato.list([sort:"descripcion"])
        def tiposRubro=TipoRubro.list([sort: "descripcion"])
        def rubros = Rubro.findAllByTipoRubro(tiposRubro[0])
        [tipos:tipos,tiposRubro:tiposRubro,rubros:rubros]
    }
    def cargaRubrosCombo(){
        def rubros = Rubro.findAllByTipoRubro(TipoRubro.get(params.id),[sort:"descripcion"])
        [rubros:rubros]
    }

    def getDatosRubro(){
        def rubro = Rubro.get(params.id)
        render ""+rubro.valor+";"+rubro.porcentaje+";"+rubro.iess+";"+rubro.gravable+";"+rubro.decimo+";"+rubro.decimo
    }


    def addRubroContrato(){
        println "add rubro contrato "+params
        def rubro
        if(params.id!=""){
            rubro=RubroTipoContrato.get(params.id)
        }else{
            rubro=new RubroTipoContrato()
        }
        rubro.rubro=Rubro.get(params.rubro)
        rubro.decimo=params.decimo
        rubro.gravable=params.grav
        rubro.iess=params.iess
        rubro.porcentaje=params.porcentaje.toDouble()
        rubro.valor=params.valor.toDouble()
        rubro.tipoContrato=TipoContrato.get(params.tipoContrato)
        rubro.editable="1"
        if(!rubro.save(flush: true)){
            println "error rubro save "+rubro.errors
        }
        redirect(action: "cargaRubrosContrato",id: params.tipoContrato)
    }


    def cargaRubrosContrato(){
        def rubros = RubroTipoContrato.findAllByTipoContrato(TipoContrato.get(params.id))
        rubros.sort{it.rubro.tipoRubro.descripcion}
        [rubros:rubros]
    }

    def generarRol(){
        println "rol de pagos "+params
        def mes = Mes.get(params.mes)
        def periodo = Periodo.get(params.periodo)
        def empresa = Empresa.get(session.empresa.id)
        def rol = RolPagos.findByMessAndPeriodo(mes,periodo)
        println "rol??  "+rol
        def msg =""
        if(!rol){
            rol = new RolPagos()
            rol.estado="N"
            rol.fecha=new Date()
            rol.mess=mes
            rol.pagado=0
            rol.periodo=periodo
            if(!rol.save(flush: true)){
                println "error save rol "+rol.errors
            }

            def empleados = Empleado.withCriteria {
                persona {
                    eq("empresa", empresa)
                    order("apellido","asc")
                }
                eq("estado","A")
                lt("fechaInicio",periodo.fechaFin)
                or{
                    isNull("fechaFin")
                    gt("fechaFin",periodo.fechaInicio)
                }
                isNotNull("tipoContrato")

            }
//            println "empleados  "+empleados.persona.nombre
            def total = 0
            empleados.each {emp->
//                println "_________________________________________________"
//                println "emp "+emp.persona.nombre+"  contra "+emp.tipoContrato.descripcion
                def sueldo = emp.sueldo
                if(emp.fechaInicio>periodo.fechaInicio && emp.fechaInicio<periodo.fechaFin){
                    println "porcentaje sueldo "
                    sueldo=(emp.sueldo/30*(periodo.fechaFin.day-emp.fechaInicio.day).toInteger()).toDouble().round(2)
                }
                def detalle = DetallePago.findAll("from DetallePago where rolPagos = ${rol.id} and rubroTipoContrato is null and empleado=${emp.id}")
//                println "detalle ?? "+detalle
                if(detalle.size()==0){
                    detalle=new DetallePago()
                    detalle.empleado=emp
                    detalle.rolPagos=rol
                    detalle.rubroTipoContrato=null
                    detalle.valor=sueldo.toDouble().round(2)
                    if(!detalle.save(flush: true))
                        println "error save detalle pago sueldo "+detalle.errors

                }
                total+=sueldo
//                println "total "+total+" sueldo "  +sueldo

                def rubros = RubroTipoContrato.findAllByTipoContrato(emp.tipoContrato)
//                println "rubros ==> "+rubros.rubro.descripcion+"  "+rubros.rubro.valor+"  "+rubros.rubro.porcentaje
//                def rubrosEsp = RubroTipoContrato.findAllByEmpleado(emp)
                rubros.each {r->
                    detalle = DetallePago.findAll("from DetallePago where rubroTipoContrato=${r.id} and rolPagos=${rol.id} and empleado=${emp.id}")

//                    println "detalle rubros ? "+detalle
                    if(detalle.size()==0){
                        detalle=new DetallePago()
                        detalle.empleado=emp
                        detalle.rolPagos=rol
                        detalle.rubroTipoContrato=r
                        def valor = 0
                        def signo = -1
                        if(r.rubro.tipoRubro.codigo=="I")
                            signo=1
                        if(r.valor!=0){
                            valor=r.valor*signo
                        }else{
                            valor=sueldo*(r.porcentaje/100)*signo
                        }
                        detalle.valor=valor.toDouble().round(2)
                        if(!detalle.save(flush: true))
                            println "error save detalle pago "+detalle.errors
                        total+=valor
                    }

                }

            }

            rol.pagado=total.toDouble().round(2)
            rol.save(flush: true)
            println "done"
            render "ok"


        }else{
            msg="Error: Ya ha sido generado un rol de pagos para el mes seleccionado"
            render msg
        }


    }

    def verRol(){
        println "ver rol "+params
        def mes =null
        def periodo=null
        def anio = new Date().format("yyyy").toInteger()
        def anios=[:]
        def meses=Mes.list([sort: "id"])
        3.times {
            anios.put((anio-it).toString(),anio-it)
            anios.put((anio+it).toString(),anio+it)
        }
        anios.sort{ it.key}
//        println "anios "+anios

        def roles
        if(params.mes) {
            mes = Mes.get(params.mes)
            if(params.periodo){
                periodo = Periodo.get(params.periodo)
                roles = RolPagos.findAllByMessAndPeriodo(mes,periodo)
            }
            if(params.anio){
                def fecha = new Date().parse("dd-MM-yyyy","01-01-"+params.anio)
                def cont = Contabilidad.findAllByInstitucionAndFechaInicioGreaterThanEquals(session.empresa,fecha)
//                println "cont "+cont+" anio "+anio
                def periodos = []
                Periodo.findAllByContabilidadInList(cont).each {p->
                    if(p.fechaInicio.format("yyyy")==params.anio)
                        periodos.add(p)
                }
//                println "periodos "+periodos
                roles = RolPagos.findAllByMessAndPeriodoInList(mes,periodos)
//                println "roles "+roles
            }
//            anio=periodo.fechaInicio.format("YYYY")
        }else{
            mes=meses[0]
            roles= RolPagos.findAllByMess(mes,[sort: "id",order: "desc"])
        }

        def rol=null
        def cn

        roles.each {
            if(!rol)
                if(it.periodo.contabilidad.institucion.id.toInteger()==session.empresa.id.toInteger()){
                    rol=it
                    anio=it.periodo.fechaInicio.format("YYYY")
                }
        }
        def datos=[]
        if(rol){
            def sql ="SELECT e.empl__id,p.prsnnmbr || ' ' || p.prsnapll ,c.crgodscr,t.tpctdscr ,sum(d.dtpgvlor) from rlpg r,dtpg d,empl e,prsn p,crgo c, tpct t where r.rlpg__id=${rol.id} and r.rlpg__id=d.rlpg__id and d.empl__id=e.empl__id and e.prsn__id=p.prsn__id and e.crgo__id=c.crgo__id and e.tpct__id=t.tpct__id  group by 1,2,3,4 order by 2;"
            cn = dbConnectionService.getConnection()
            cn.eachRow(sql.toString()){r->
                datos.add(r.toRowResult())
            }
        }
        [datos:datos,rol:rol,mes:mes,meses:meses,anio:anio,anios:anios]

    }


    def getDetalle (){
        println "detalle "+params
        def rol = RolPagos.get(params.rol)
        def emp = Empleado.get(params.emp)
        def detalle= DetallePago.findAllByEmpleadoAndRolPagos(emp,rol)
        [detalle:detalle,emp:emp,rol:rol]
    }

    def registrarRol(){
        def rol = RolPagos.get(params.rol)
        rol.estado="R"
        rol.save(flush: true)
        render "ok"
    }

    def saveDetalle(){
        println "save detalle "+params
        def detalle = DetallePago.get(params.detalle)
        def rol = detalle.rolPagos
        def total = rol.pagado
        total-=detalle.valor
        detalle.valor=params.valor.toDouble()
        total+=detalle.valor
        if(detalle.save(flush: true)){
            rol.pagado=total
            rol.save(flush: true)
            render "ok"
        }
    }

    def deleteDetalle(){
        def detalle = DetallePago.get(params.detalle)
        def valor = detalle.valor
        def rol = detalle.rolPagos
        try{
            detalle.delete(flush: true)
            rol.pagado-=valor
            rol.save(flush: true)
            render "ok"
        }catch (e){
            println "error delete detalle "+e
            render "error"
        }

    }


    def addDetalle(){
        def emp = Empleado.get(params.emp)
        def valor = params.val
        try{
            valor=valor.toDouble()
        }catch (e){
            render "error"
            return
        }
        def rol = RolPagos.get(params.rol)
        def detalle = new DetallePago()
        detalle.descripcion=params.desc
        detalle.empleado=emp
        detalle.rolPagos=rol
        detalle.valor=valor
        if(detalle.save(flush: true)){
            rol.pagado+=detalle.valor
            rol.save(flush: true)
            render "ok"
            return
        }else{
            println "error save detalle "+detalle.errors
            render "error"
            return
        }
    }

    def save() {
        def rubroInstance
        if(params.id) {
            rubroInstance = Rubro.get(params.id)
            if(!rubroInstance) {
                flash.message = "No se encontr&oacute; Rubro a modificar"
                render "NO"
                return
            }
            rubroInstance.properties = params
        } else {
            rubroInstance = new Rubro(params)
        }
        if (!rubroInstance.save(flush: true)) {
            render "NO"
            println rubroInstance.errors
            flash.message = "Ha ocurrido un error al guardar Rubro"
            return
        }

        flash.message = "Rubro guardado exitosamente"
//    redirect(action: "show", id: rubroInstance.id)
        render "OK"
    }

    def show() {
        def rubroInstance = Rubro.get(params.id)
        if (!rubroInstance) {
            flash.message = "No se encontr&oacute; Rubro a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [rubroInstance: rubroInstance]
    }

    def edit() {
        def rubroInstance = Rubro.get(params.id)
        if (!rubroInstance) {
            flash.message = "No se encontr&oacute; Rubro a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [rubroInstance: rubroInstance]
    }

    def delete() {
        def rubroInstance = Rubro.get(params.id)
        if (!rubroInstance) {
            flash.message = "No se encontr&oacute; Rubro a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            rubroInstance.delete(flush: true)
            flash.message = "Rubro eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Rubro"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
