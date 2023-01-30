import UIKit
import MapKit
//location  1. 임포트
import CoreLocation
//지도와 위치권한은 상관이 없다, 현재위치등을 표현하고 싶다면 권한필요
// 중심, 범위 지정, 핀(어노테이션)

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var btnShowPopup: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var num : Int = 0
    //location 2. 위치에 대한 대부분을 담당
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        manager.delegate = self
        return manager
     }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.width
        startButton.clipsToBounds = true
        self.mapView.mapType = MKMapType.standard
        mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
        self.mapView.isZoomEnabled = true
        self.mapView.delegate = self
        
        
    }

//     override func viewDidAppear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        showRequestLocationServiceAlert()
//    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D){
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)

    }
    override func viewWillDisappear(_ animated: Bool) {
        self.locationManager.stopUpdatingLocation()
        
    }

}
// 위치 관련 user defined 메서드
extension MapViewController{
    
    //location 7.  iOS버전에 따른 분기 처리 및 iOS 위치 서비스 활성화 여부 확인
    //위치서비스가 켜져있다면 권한을 요청하고, 꺼져있다면 커스텀 얼럿으로 상황 알려주기(2)
    //CLAuthorizationStatus
    //denied: 허용안함/설정에서 추후에 거부/위치서비스 비활성화/비행기모드
    //restricted: 앱권한자체가없는경우/자녀보호기능/
    //notDetermined: 권한 선택 전
    func checkUserDeviceLocationServiceAuthorization(){
        
        let authorizationStatus: CLAuthorizationStatus
        //ios 14.0 이상이라면
        if #available(iOS 14.0, *){
            //인스턴스를 통해 locationManager가 가지고 있는 상태를 가져옴
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //"iOS 위치서비스 활성화" 여부 체크 : locationServicesEnabled()
        if CLLocationManager.locationServicesEnabled(){
            //위치 서비스가 활성화돼 있으므로 위치권한 요청이 가능해서 위치 권한을 요청(3)
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치서비스가 꺼져있어 권한을 요청하지 못 합니다.")
        }
    }
    
    //location 8. 사용자의 위치"권한" 상태 확인
    //사용자가 위치를 허용했는지, 거부했는지, 아직 선택 전인지 등을 확인(사전에 iOS위치서비스활성화 꼭 확인)
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus){
        switch authorizationStatus {
        case .notDetermined:
            print("NotDetermined")
                                              //정확도 : kCLLocationAccuracy
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
                            //앱을 사용하는 동안에 대한 위치 권한 요청, plist의 whenInUse 해줘야 -> request 메서드 사용 가능
            locationManager.requestWhenInUseAuthorization()
            
//            locationManager.startUpdatingLocation() //제거가능
            
        case .restricted, .denied:
            print("Denied, 아이폰 설정으로 유도")
            //얼럿을 띄워 설정으로 유도
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            print("When In Use")
            //사용자가 위치를 허용해둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메서드 실행
            locationManager.startUpdatingLocation()
        default: print("Default")
        }
    }
    
    //Alert 구현
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          if let appSetting = URL(string: UIApplication.openSettingsURLString){
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }

    
}

//location 4. 프로토콜 선언
extension MapViewController: CLLocationManagerDelegate{
    
    //location 5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        
        if let coordinate = locations.last?.coordinate{
            setRegionAndAnnotation(center: coordinate)
//            let latitude = coordinate.latitude
//            let longitude = coordinate.longitude
//            let center = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        }
        
        
        //위치 업데이트 멈춤
        locationManager.stopUpdatingLocation()
    }
    
    //location 6. 사용자의 위치를 못가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    //location 9. 사용자의 권한 상태가 바뀔때를 알려줌
    //거부 -> 허용, notDetermined -> 허용
    //허용했어서 위치 가져오는중에 설정에서 거부
    //ios 14이상: 사용자의 권한 상태가 변경이 될 때, 위치 관리자 생성할 때 호출됨(1)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
    //ios 14미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
}

