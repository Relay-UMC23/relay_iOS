
import UIKit
import CoreLocation
import MapKit
import CoreMotion


class TrackMyTraceViewController: UIViewController {
    @IBOutlet weak var goalView: UIView!
    
    @IBOutlet weak var currentrunView: UIView!
    @IBOutlet weak var MapView: MKMapView!
    var points: [CLLocationCoordinate2D] = []
    @IBOutlet weak var distanceLabel: UILabel!
    var totalDistance: CLLocationDistance = CLLocationDistance()
    var Distance : Double = 0
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        manager.delegate = self
        return manager
     }()

    var previousCoordinate: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        goalView.layer.cornerRadius = 30
        currentrunView.layer.cornerRadius = 30
        var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.location?.coordinate.longitude ?? 0)

        getLocationUsagePermission()
        // xcode 종료 후 어플을 다시 실행했을 때 뜨는 오류 방지.
        self.MapView.setRegion(MKCoordinateRegion(center: currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: true)
        self.MapView.mapType = MKMapType.standard
        // 지도에 내 위치 표시
        MapView.showsUserLocation = true
        // 현재 내 위치 기준으로 지도를 움직임.
        self.MapView.setUserTrackingMode(.follow, animated: true)
        
        self.MapView.isZoomEnabled = true
        self.MapView.delegate = self
        
    }

    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.locationManager.stopUpdatingLocation()
    }
}



extension TrackMyTraceViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                print("GPS 권한 설정됨")
            case .restricted, .notDetermined:
                print("GPS 권한 설정되지 않음")
                DispatchQueue.main.async {
                    self.getLocationUsagePermission()
                }
            case .denied:
                print("GPS 권한 요청 거부됨")
                DispatchQueue.main.async {
                    self.getLocationUsagePermission()
                }
            default:
                print("GPS: Default")
            }
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude
        
        let point1 = CLLocationCoordinate2DMake(self.previousCoordinate?.latitude ?? location.coordinate.latitude, self.previousCoordinate?.longitude ?? location.coordinate.longitude)
        let point2: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)

        self.points.append(point1)
        self.points.append(point2)
        
        let loc1 = CLLocation(latitude: self.previousCoordinate?.latitude ?? 0.0, longitude: self.previousCoordinate?.longitude ?? 0.0)
        let loc2 = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let distanceFormatter = MKDistanceFormatter()
        distanceFormatter.units = .metric
        let addedDistance = loc1.distance(from: loc2)
        let lineDraw = MKPolyline(coordinates: points, count:points.count)
        self.MapView.addOverlay(lineDraw)
        self.Distance += addedDistance
        debugPrint(Distance)
        let stringDistance = distanceFormatter.string(fromDistance: totalDistance)

        self.previousCoordinate = location.coordinate
    }
}
//오버레이 그리는 function
extension TrackMyTraceViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline
        else {
            return MKOverlayRenderer()
        }
        let renderer = MKPolylineRenderer(polyline: polyLine)
            renderer.strokeColor = .orange
            renderer.lineWidth = 5.0
            renderer.alpha = 1.0

        return renderer
    }
}
