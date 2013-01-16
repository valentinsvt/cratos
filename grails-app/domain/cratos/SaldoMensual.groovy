package cratos
class SaldoMensual implements Serializable {
    double debe
    double haber
    double saldoInicial
    Periodo periodo
    Cuenta cuenta
    static mapping = {
        table 'slms'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'slms__id'
        id generator: 'identity'
        version false
        columns {
            haber column: 'slmshber'
            debe column: 'slmsdebe'
            saldoInicial column: 'slmsslin'
            periodo column: 'prdo__id'
            cuenta column: 'cnta__id'
        }
    }
    static constraints = {
        debe(blank: true, nullable: true, attributes: [title: 'debe'])
        saldoInicial(blank: false, attributes: [title: 'saldoInicial'])
        periodo(blank: true, nullable: true, attributes: [title: 'periodo'])
        cuenta(blank: true, nullable: true, attributes: [title: 'cuenta'])
        haber(blank: false, attributes: [title: 'haber'])
    }
}