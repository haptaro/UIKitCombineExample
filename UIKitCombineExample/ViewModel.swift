//
//  ViewModel.swift
//  UIKitCombineExample
//
//  Created by Kotaro Fukuo on 2022/08/06.
//

import Foundation

@MainActor
final class ViewModel {
    @Published private(set) var text: String = ""
    @Published private(set) var showErrorAlert = false
    @Published private(set) var isLoading = false
    
    private let apiRequester: any APIRequestable
    
    init(apiRequester: any APIRequestable = APIClient()) {
        self.apiRequester = apiRequester
    }
    
    func tapButton() async {
        do {
            isLoading = true
            let key = "" // add your private key
            let body = try await apiRequester.request(urlString: "http://api.weatherapi.com/v1/current.json?key=\(key)&q=Vancouver&aqi=no")
            isLoading = false
            text = body.current.condition.text
        } catch {
            isLoading = false
            showErrorAlert = true
        }
    }
}
