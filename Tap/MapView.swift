import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var position: MapCameraPosition = .camera(
        MapCamera (
            centerCoordinate: CLLocationCoordinate2D(
                latitude: 36.01429, longitude: 129.3256), 
            distance: 980, 
            heading: 60, 
            pitch: 60
        )
    )
    
    //    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    //    static let userLocation = CLLocation(latitude: , longitude: )
    //서울 좌표
    var body: some View {
        Map(position: $position){
            Marker("Mac Home", coordinate: .parking)
            Marker("Futsal", coordinate: .soccer)
        }
    }
    
}
struct MapView_Previews: PreviewProvider {
    
    static var previews: some View {
        MapView()
    }
}
//.tag(Tab.map)
extension CLLocationCoordinate2D{
    static let parking = CLLocationCoordinate2D(latitude: 36.01429, longitude: 129.3256)
    static let soccer = CLLocationCoordinate2D(latitude: 36.01730, longitude: 129.3244)
}
