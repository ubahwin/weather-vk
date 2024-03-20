//
// WeatherResponseCurrentTemperature.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct WeatherResponseCurrentTemperature: Codable, Hashable {

    public var min: Double?
    public var max: Double?
    public var afternoon: Double?
    public var night: Double?
    public var evening: Double?
    public var morning: Double?

    public init(min: Double? = nil, max: Double? = nil, afternoon: Double? = nil, night: Double? = nil, evening: Double? = nil, morning: Double? = nil) {
        self.min = min
        self.max = max
        self.afternoon = afternoon
        self.night = night
        self.evening = evening
        self.morning = morning
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case min
        case max
        case afternoon
        case night
        case evening
        case morning
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(min, forKey: .min)
        try container.encodeIfPresent(max, forKey: .max)
        try container.encodeIfPresent(afternoon, forKey: .afternoon)
        try container.encodeIfPresent(night, forKey: .night)
        try container.encodeIfPresent(evening, forKey: .evening)
        try container.encodeIfPresent(morning, forKey: .morning)
    }
}

