//
//  ViewModelTests.swift
//  UIKitCombineExampleTests
//
//  Created by Kotaro Fukuo on 2022/08/06.
//

import XCTest
import Combine
@testable import UIKitCombineExample

@MainActor
final class ViewModelTests: XCTestCase {
    private var cancellable = Set<AnyCancellable>()
    
    func testViewShouldBeShowErrorAlert() async throws {
        let requester = APIFailRequester()
        let viewModel = ViewModel(apiRequester: requester)
        
        XCTAssertFalse(viewModel.showErrorAlert)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.text, "")
        
        await viewModel.tapButton()
        
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.text, "")
    }
    
    func testViewShouldBeShowText() async throws {
        let requester = APISuccessRequester()
        let viewModel = ViewModel(apiRequester: requester)
        
        XCTAssertFalse(viewModel.showErrorAlert)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.text, "")
        
        await viewModel.tapButton()
        
        XCTAssertFalse(viewModel.showErrorAlert)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.text, "Success!!!")
    }
    
    func testViewShouldBeShowLoadingIndicator() async throws {
        var requester = APISuspendRequester()
        let viewModel = ViewModel(apiRequester: requester)
        
        requester.callingRequest = {
            XCTAssertFalse(viewModel.showErrorAlert)
            XCTAssertTrue(viewModel.isLoading)
            XCTAssertEqual(viewModel.text, "")
        }
        
        XCTAssertFalse(viewModel.showErrorAlert)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.text, "")
        
        await viewModel.tapButton()
    }
}


private extension ViewModelTests {
    struct APIFailRequester: APIRequestable {
        func request(urlString: String) async throws -> Body {
            throw APIRequestError.statusCode
        }
    }
    
    struct APISuccessRequester: APIRequestable {
        func request(urlString: String) async throws -> Body {
            return Body(current: Current(condition: Condition(text: "Success!!!")))
        }
    }
    
    struct APISuspendRequester: APIRequestable {
        var callingRequest: () -> Void = {}
        
        func request(urlString: String) async throws -> Body {
            callingRequest()
            return Body(current: Current(condition: Condition(text: "")))
        }
    }
}
