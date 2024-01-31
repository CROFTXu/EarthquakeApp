//
//  Model.swift
//  EarthquakeApp
//
//  Created by xzy on 2024/1/31.
//

import Foundation

struct Response: Codable {
    let type: String?
    let metadata: MetaData?
    let features: [Features]?
    let bbox: [Double]?
}

struct MetaData: Codable {
    let generated: Int
    let url: String?
    let title: String?
    let status: Int
    let api: String?
    let count: Int
}

struct Features: Codable {
    let type: String?
    let properties: Property?
    let geometry: Geometry?
    let id: String?
}

struct Property: Codable {
    let mag: Double
    let place: String?
    let time: Int
    let updated: Int
//    let tz: String?
    let url: String?
    let detail: String?
    let felt: Int
    let cdi: Double
    let mmi: Double
    let alert: String?
    let status: String?
    let tsunami: Int
    let sig: Int
    let net: String?
    let code: String?
    let ids: String?
    let sources: String?
    let types: String?
    let nst: Int
    let dmin: Double
    let rms: Double
    let gap: Int
    let magType: String?
    let type: String?
    let title: String?
}

struct Geometry: Codable {
    let type: String?
    let coordinates: [Double]?
}

