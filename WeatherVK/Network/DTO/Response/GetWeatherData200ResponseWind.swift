//
// GetWeatherData200ResponseWind.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct GetWeatherData200ResponseWind: Codable, Hashable {

    public var speed: Double?
    public var deg: Double?

    public init(speed: Double? = nil, deg: Double? = nil) {
        self.speed = speed
        self.deg = deg
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case speed
        case deg
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(speed, forKey: .speed)
        try container.encodeIfPresent(deg, forKey: .deg)
    }
}

