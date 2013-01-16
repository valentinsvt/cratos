package cratos
class Empleado implements Serializable {
    double porcentajeComision
    String foto
    String estado
    Date fechaFin
    Date fechaInicio
    double sueldo
    String cuenta
    String email
    String telefono
    int hijo
    String iess
    String numero
    TipoContrato tipoContrato
    Cargo cargo
    Persona persona
    Canton canton
    String crgo

    static mapping = {
        table 'empl'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'empl__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'empl__id'
            porcentajeComision column: 'emplpccm'
            foto column: 'emplfoto'
            estado column: 'empletdo'
            fechaFin column: 'emplfcfn'
            fechaInicio column: 'emplfcin'
            sueldo column: 'emplsldo'
            cuenta column: 'emplcnta'
            email column: 'emplmail'
            telefono column: 'empltlfn'
            hijo column: 'emplhijo'
            iess column: 'empliess'
            numero column: 'emplnmro'
            tipoContrato column: 'tpct__id'
            cargo column: 'crgo__id'
            persona column: 'prsn__id'
            canton column: 'cntn__id'
            crgo column: 'emplcrgo'
        }
    }
    static constraints = {
        porcentajeComision(blank: true, nullable: true, attributes: [title: 'porcentajeComision'])
        foto(blank: true, nullable: true, attributes: [title: 'foto'])
        estado(size: 1..1, blank: true, nullable: true, attributes: [title: 'estado'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'fechaFin'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'fechaInicio'])
        sueldo(blank: true, nullable: true, attributes: [title: 'sueldo'])
        cuenta(size: 1..12, blank: true, nullable: true, attributes: [title: 'cuenta'])
        email(size: 1..63, blank: true, nullable: true, attributes: [title: 'email'])
        telefono(size: 1..63, blank: true, nullable: true, attributes: [title: 'telefono'])
        hijo(blank: true, nullable: true, attributes: [title: 'hijo'])
        iess(size: 1..13, blank: true, nullable: true, attributes: [title: 'iess'])
        numero(size: 1..10, blank: true, nullable: true, attributes: [title: 'numero'])
        tipoContrato(blank: true, nullable: true, attributes: [title: 'tipoContrato'])
        cargo(blank: true, nullable: true, attributes: [title: 'cargo'])
        persona(blank: true, nullable: true, attributes: [title: 'persona'])
        canton(blank: true, nullable: true, attributes: [title: 'canton'])
        crgo(blank: true, nullable: true, size: 1..127, attributes: [title: 'crgo'])
    }
}