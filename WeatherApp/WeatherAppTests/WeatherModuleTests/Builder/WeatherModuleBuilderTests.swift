// @copyright German Autolabs Assignment

import XCTest
@testable import WeatherApp

final class WeatherModuleBuilderTests: XCTestCase {
    
    func testBuildViewController() {
        // given
        let builder = WeatherModuleBuilder()
        
        // when
        let viewController = builder.build() as! WeatherViewController
        
        // then
        XCTAssertNotNil(viewController.output)
        
        let presenter: WeatherPresenter = viewController.output as! WeatherPresenter
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.router)
        XCTAssertNotNil(presenter.interactor as? WeatherInteractor)
        XCTAssertTrue(presenter.router is WeatherRouter)
        
        let router: WeatherRouter = presenter.router as! WeatherRouter
        XCTAssertNotNil(router.viewController)
    }
}
