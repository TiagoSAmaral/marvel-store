//
//  File.swift
//  HeartOfStoneViewerTests
//
//  Created by Tiago Amaral on 22/06/23.
//  Copyright © 2023 developerios. All rights reserved.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    
    static var mockRequests: Set<MockNetworkPurveyor> = []
    static var shouldCheckQueryParameters = false
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func stopLoading() {
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func startLoading() {
        
        var foundRequest: MockNetworkPurveyor?
        
        if request.httpMethod == "GET" {
            foundRequest = Self.mockRequests.first { [unowned self] in
                request.url?.absoluteString == $0.urlRequest.url?.absoluteString &&
                request.httpMethod == $0.urlRequest.httpMethod &&
                request.headers[Header.Keys.authorization.rawValue] == $0.response.headers[Header.Keys.authorization.rawValue] &&
                (Self.shouldCheckQueryParameters ? request.url?.query == $0.urlRequest.url?.query: true)
            }
        
        }
        
        if request.httpMethod == "POST" {
            foundRequest = Self.mockRequests.first { [unowned self] in
                request.url?.absoluteString == $0.urlRequest.url?.absoluteString &&
                request.httpMethod == $0.urlRequest.httpMethod &&
                (Self.shouldCheckQueryParameters ? request.url?.query == $0.urlRequest.url?.query: true)
            }
        
        }
        
        guard let mockPurveyor = foundRequest else {
            client?.urlProtocol(self, didFailWithError: MockNetworkPurveyorError.routeNotFound)
            return
        }
        
        guard mockPurveyor.urlRequest.headers[Header.Keys.authorization.rawValue] != .empty else {
            client?.urlProtocol(self, didFailWithError: MockNetworkPurveyorError.notAuthorizated)
            return
        }
        
        if let data = mockPurveyor.response.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        client?.urlProtocol(self, didReceive: mockPurveyor.urlResponse, cacheStoragePolicy: .notAllowed)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    enum MockNetworkPurveyorError: Error {
        case routeNotFound
        case badRequest
        case notAuthorizated
    }
}

struct MockResponse: Hashable {
    let statusCode: StatusCode
    let httpVersion: HTTPVersionTable
    let data: Data?
    let headers: [String: String]
    
    static func == (lhs: MockResponse, rhs: MockResponse) -> Bool {
        lhs.statusCode == rhs.statusCode &&
        lhs.httpVersion.rawValue == rhs.httpVersion.rawValue &&
        lhs.data?.hashValue == rhs.data?.hashValue &&
        lhs.headers.first?.value == rhs.headers.first?.value
    }
}

struct MockNetworkPurveyor: Hashable {

    let urlRequest: URLRequest
    let response: MockResponse
    var urlResponse: HTTPURLResponse {
        HTTPURLResponse(url: urlRequest.url!,
                        statusCode: response.statusCode.rawValue,
                        httpVersion: response.httpVersion.rawValue,
                        headerFields: (urlRequest.allHTTPHeaderFields ?? [:]).merging(response.headers) { $1 }
        )!
    }
    
    static func == (lhs: MockNetworkPurveyor, rhs: MockNetworkPurveyor) -> Bool {
        return lhs.urlRequest.url!.absoluteString == rhs.urlRequest.url!.absoluteString &&
        lhs.response.statusCode.rawValue == rhs.response.statusCode.rawValue &&
        lhs.urlResponse == rhs.urlResponse
    }
}

enum StatusCode: Int {
    case code200 = 200
    case code400 = 400
    case code500 = 500
}

enum HTTPVersionTable: String {
    case http1 = "HTTP/1.0"
}

enum Header {

    enum Keys: String {
        case contentType = "Content-Type"
        case authorization = "Authorization"
    }
    
    enum Values: String {
        case applicationJson = "application/json"
    }
}
