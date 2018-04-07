// @copyright German Autolabs Assignment

import CoreLocation

enum LocationServiceResult {
    case success(CLLocation)
    case unavailable
    case denied
    case failure(Error?)
}

typealias LocationServiceCompletion = (LocationServiceResult) -> Void

protocol LocationService {
    func fetchLocation(completion: @escaping LocationServiceCompletion)
}
