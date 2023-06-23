//
//  URLProtocolExtension.swift
//  HeartOfStoneViewerTests
//
//  Created by Tiago Amaral on 22/06/23.
//  Copyright © 2023 developerios. All rights reserved.
//

import Foundation
import Alamofire

extension URLProtocolMock {
    
    class func registerResponses() {
        let mockProvider = MockerContentProvider()
        URLProtocolMock.mockRequests.removeAll()
        URLProtocolMock.mockRequests.insert(mockProvider.mockSuccessCardListPage)
        URLProtocolMock.mockRequests.insert(mockProvider.mockFailureCardListPage)
        URLProtocolMock.mockRequests.insert(mockProvider.mockSuccessMetadata)
        URLProtocolMock.mockRequests.insert(mockProvider.mockFailureMetadata)
        URLProtocolMock.mockRequests.insert(mockProvider.mockSuccessToken)
        
    }

    class func makeSession() -> Session {
        registerResponses()
        URLProtocol.registerClass(URLProtocolMock.self)
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        let session = Session(configuration: configuration)
        return session
    }
}
