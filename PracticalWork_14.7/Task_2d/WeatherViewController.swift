//
//  WeatherViewController.swift
//  PracticalWork_14.7
//
//  Created by Alexandr on 27.11.2022.
//

import UIKit
import CoreLocation
import Alamofire
import AlamofireImage
import RealmSwift

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var sityName: UILabel!
    @IBOutlet weak var tempName: UILabel!
    @IBOutlet weak var imageName: UIImageView!
    
    var items:Results<WeatherItem>!
    
    let locationManager = CLLocationManager()
    let keyAPI:String = "3b2065523d2efd848e0d23312c7ad69b"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        self.items = realm.objects(WeatherItem.self)
        
        if items.count > 0 {
            sityName.text = items.last?.nameSity
            tempName.text = items.last?.mainTemp
            imageName.image = UIImage(named: items.last!.iconWeather)
        }
        
        startLocationManadger()
        
    }
    
    func  startLocationManadger() {
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
    
    func getWeatherInfo(latitude:Double, longitude:Double) {

        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(keyAPI)")
            .validate()
            .responseDecodable(of: Data.self) { (response) in
                guard let data = response.value else { return }
                
                self.imageName.image = UIImage(named: String((data.weather[0].icon)))
                self.sityName.text = data.name
                var temperature:String? {
                    get {
                        var temp = ""
                            if (data.main["temp"]! - 273.15) > 0 {
                                temp = "+ \(Float(data.main["temp"]! - 273.15))"
                            } else {
                                temp = "- \(Float(data.main["temp"]! - 273.15))"
                            }
                        return temp
                    }
                }
                self.tempName.text = temperature!
                
                let item = WeatherItem()
                item.iconWeather = data.weather[0].icon
                item.mainTemp = temperature!
                item.nameSity = data.name
                
                let realm = try! Realm()
                try! realm.write {
                    realm.add(item)
                }
            }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            let lat = Double(lastLocation.coordinate.latitude)
            let lon = Double(lastLocation.coordinate.longitude)
            getWeatherInfo(latitude:lat, longitude:lon)
        }
    }
    //Для коммита
}
