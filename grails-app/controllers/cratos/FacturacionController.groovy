package cratos


class FacturacionController extends cratos.seguridad.Shield  {


    def index() {

        def iva = ParametrosAuxiliares.get(1).iva

        return [iva: iva]
    }


    def buscarItem() {
        def search = params.search

        def iva = ParametrosAuxiliares.get(1).iva

        def c = Item.createCriteria()
        def results = c.list {
            or {
                marca {
                    ilike("descripcion", "%" + search + "%")

                }
                ilike("codigo", "%" + search + "%")
                ilike("observaciones", "%" + search + "%")
            }
            maxResults(20)
            order("nombre", "asc")
        }

        return [results: results, iva: iva]
    }




}
