// @copyright German Autolabs Assignment

import UIKit

final class WeatherModuleBuilder: NSObject {
    
    func build() -> UIViewController {
        let viewController = UIStoryboard(name: "Main",
                                          bundle: nil).instantiateInitialViewController() as! WeatherViewController
        
        let router = WeatherRouter()
        router.viewController = viewController
        
        let presenter = WeatherPresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = WeatherInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }
}
