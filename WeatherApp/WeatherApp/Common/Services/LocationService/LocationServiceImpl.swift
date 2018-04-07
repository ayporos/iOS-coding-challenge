// @copyright German Autolabs Assignment

import CoreLocation

final class LocationServiceImpl: NSObject, LocationService, CLLocationManagerDelegate {
    // TODO: cash location
    
    private enum Constants {
        static let freshLocation: Double = 20
    }
    private lazy var manager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        return locationManager
    }()
    private var completion: LocationServiceCompletion?
    
    func fetchLocation(completion: @escaping LocationServiceCompletion) {
        guard CLLocationManager.locationServicesEnabled() else {
            completion(.unavailable)
            return
        }
        
        manager.stopUpdatingLocation()
        self.completion = completion
        handle(authorizationStatus: CLLocationManager.authorizationStatus())
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let completion = completion,
            let location = locations.last,
            location.timestamp.timeIntervalSinceNow < Constants.freshLocation else { return }
        completion(.success(location))
        self.completion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            completion?(.denied)
        } else {
            completion?(.failure(error))
        }
        completion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handle(authorizationStatus: status)
    }
}

private extension LocationServiceImpl {
    func handle(authorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            completion?(.denied)
            completion = nil
            break
        case .authorizedWhenInUse, .authorizedAlways:
            if let _ = completion {
                manager.requestLocation()
            }
            break
        }
    }
}
