package cratos

import groovy.xml.MarkupBuilder

class XmlController extends cratos.seguridad.Shield {
    def test1() {
        def writer = new StringWriter()
//        def xml = new MarkupBuilder(writer)

        def xml = new MarkupBuilder(writer)
        xml.mkp.xmlDeclaration(version: "1.0", encoding: "UTF-8", standalone: "no")

        xml.records() {
            car(name: 'HSV Maloo', make: 'Holden', year: 2006) {
                country('Australia')
                record(type: 'speed', 'Production Pickup Truck with speed of 271kph')
            }
            car(name: 'P50', make: 'Peel', year: 1962) {
                country('Isle of Man')
                record(type: 'size', 'Smallest Street-Legal Car at 99cm wide and 59 kg in weight')
            }
            car(name: 'Royale', make: 'Bugatti', year: 1931) {
                country('France')
                record(type: 'price', 'Most Valuable Car at $15 million')
            }
        }

        println writer.toString()
        render writer.toString()
    } //test1
}