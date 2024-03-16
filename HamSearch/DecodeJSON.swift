//
//  DecodeJSON.swift
//  HamSearch
//
//  Created by Benjamin Faershtein on 12/24/23.
//

import Foundation

// Codable structs representing the JSON structure
struct License: Codable {
    let status: String
    let type: String
    let current: LicenseDetail
    let previous: LicenseDetail
    let trustee: Trustee
    let name: String
    let address: Address
    let location: Location
    let otherInfo: OtherInfo
}

struct LicenseDetail: Codable {
    let callsign: String
    let operClass: String
}

struct Trustee: Codable {
    let callsign: String
    let name: String
}

struct Address: Codable {
    let line1: String
    let line2: String
    let attn: String
}

struct Location: Codable {
    let latitude: String
    let longitude: String
    let gridsquare: String
}

struct OtherInfo: Codable {
    let grantDate: String
    let expiryDate: String
    let lastActionDate: String
    let frn: String
    let ulsUrl: String
}
