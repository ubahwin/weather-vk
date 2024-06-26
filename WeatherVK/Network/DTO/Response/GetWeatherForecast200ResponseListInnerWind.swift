//
// GetWeatherForecast200ResponseListInnerWind.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct GetWeatherForecast200ResponseListInnerWind: Codable, Hashable {

    public var speed: Double?
    public var deg: Double?
    public var gust: Double?

    public init(speed: Double? = nil, deg: Double? = nil, gust: Double? = nil) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case speed
        case deg
        case gust
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(speed, forKey: .speed)
        try container.encodeIfPresent(deg, forKey: .deg)
        try container.encodeIfPresent(gust, forKey: .gust)
    }
}

