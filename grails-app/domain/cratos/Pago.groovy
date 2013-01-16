package cratos
class Pago implements Serializable {

    Auxiliar auxiliar
    double monto
    double interes = 0
    Date fecha = new Date()



    static mapping = {
        table 'pago'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'pago__id'
        id generator: 'identity'
        version false
        columns {
            auxiliar column: 'axlr__id'
            monto column: 'pagomnto'
            interes column: 'pagointr'
            fecha column: 'pagofcha'
        }
    }
    static constraints = {
        auxiliar(blank:false,nullable: false)
        fecha(nullable: false,blank:false)
    }
}