//
// GetWeatherData200ResponseCoord.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct GetWeatherData200ResponseCoord: Codable, Hashable {

    public var lon: Double?
    public var lat: Double?

    public init(lon: Double? = nil, lat: Double? = nil) {
        self.lon = lon
        self.lat = lat
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case lon
        case lat
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(lon, forKey: .lon)
        try container.encodeIfPresent(lat, forKey: .lat)
    }
}

