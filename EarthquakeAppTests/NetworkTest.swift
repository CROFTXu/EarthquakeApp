//
//  NetworkTest.swift
//  EarthquakeAppTests
//
//  Created by xzy on 2024/1/31.
//

import Foundation
import XCTest

class NetworkManagerTests: XCTestCase {
    
    func testRequest() {
        let expectation = XCTestExpectation(description: "Network Request")
        let url = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2023-01-01&endtime=2024-01-01&minmagnitude=7"
        NetworkManager.shared.request(urlString: url, method: .get, success: { data in
            do {
                let decoder = JSONDecoder()
                decoder.dataDecodingStrategy = .base64
                let response = try decoder.decode(Response.self, from: data)
                XCTAssertEqual(response.metadata!.status, 200)
                expectation.fulfill()
            } catch {
                XCTFail("Failed to decode JSON: \(error)")
            }
        }, failure: { error in
            XCTFail("Network request failed with error: \(error)")
        })
        wait(for: [expectation], timeout: 10.0)
    }
}
