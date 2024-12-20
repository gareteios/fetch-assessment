//
//  DefaultApiServiceTests.swift
//  FetchRecipes
//
//  Created by Garrett Steffens on 12/20/24.
//

import XCTest
@testable import FetchRecipes

final class DefaultApiServiceTests: XCTestCase {
    var sut: DefaultApiService {
        let sessionConfig = URLSessionConfiguration.ephemeral
        sessionConfig.protocolClasses = [MockUrlSessionProtocol.self]
        return DefaultApiService(apiEndpoint: .production, urlSession: URLSession(configuration: sessionConfig))
    }

    func test_fetchRecipes_returnsRecipes() async throws {
        let request = FetchRecipesRequest()

        MockUrlSessionProtocol.simulatedResponse = (
            HTTPURLResponse(url: request.urlRequest(with: .production)!.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!,
            try! Fixture.allRecipes.data()!
        )

        let response = try! await sut.execute(FetchRecipesRequest())

        XCTAssertEqual(response, try! Fixture.allRecipes.load(RecipesResponse.self))
    }

    func test_fetchRecipes_errorsWithMalformedData() async throws {
        let request = FetchRecipesRequest()

        MockUrlSessionProtocol.simulatedResponse = (
            HTTPURLResponse(url: request.urlRequest(with: .production)!.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!,
            try! Fixture.malformedRecipes.data()!
        )

        var failingError: ApiError?
        do {
            let _ = try await sut.execute(FetchRecipesRequest())
        } catch let error as ApiError {
            failingError = error
        } catch {}

        guard let error = failingError, case ApiError.decodingFailed = error else {
            XCTFail("Expected decoding error to be throw")
            return
        }
    }

    func test_fetchRecipes_errorsWithUnacceptableErrorCode() async throws {
        let request = FetchRecipesRequest()

        MockUrlSessionProtocol.simulatedResponse = (
            HTTPURLResponse(url: request.urlRequest(with: .production)!.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!,
            Data()
        )

        var failingError: ApiError?
        do {
            let _ = try await sut.execute(FetchRecipesRequest())
        } catch let error as ApiError {
            failingError = error
        } catch {}

        guard let error = failingError, case ApiError.invalidStatusCode(let code) = error, code == 500 else {
            XCTFail("Expected invalid status error to be throw and code to be 500")
            return
        }
    }
}
