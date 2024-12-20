//
//  MockUrlSessionProtocol.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import Foundation

class MockUrlSessionProtocol: URLProtocol {
    static var simulatedError: Error?
    static var simulatedResponse: (response: HTTPURLResponse, data: Data)?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        if let error = MockUrlSessionProtocol.simulatedError {
            client?.urlProtocol(self, didFailWithError: error)
        }

        guard let response = MockUrlSessionProtocol.simulatedResponse else {
            assertionFailure("Missing simulated response")
            return
        }

        client?.urlProtocol(self, didReceive: response.response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: response.data)
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
