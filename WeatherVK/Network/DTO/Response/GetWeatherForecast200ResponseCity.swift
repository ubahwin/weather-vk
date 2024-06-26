//
// GetWeatherForecast200ResponseCity.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct GetWeatherForecast200ResponseCity: Codable, Hashable {

    public var id: Int?
    public var name: String?
    public var coord: GetWeatherForecast200ResponseCityCoord?
    public var country: String?
    public var population: Int?
    public var timezone: Int?
    public var sunrise: Int?
    public var sunset: Int?

    public init(id: Int? = nil, name: String? = nil, coord: GetWeatherForecast200ResponseCityCoord? = nil, country: String? = nil, population: Int? = nil, timezone: Int? = nil, sunrise: Int? = nil, sunset: Int? = nil) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.population = population
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case coord
        case country
        case population
        case timezone
        case sunrise
        case sunset
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(coord, forKey: .coord)
        try container.encodeIfPresent(country, forKey: .country)
        try container.encodeIfPresent(population, forKey: .population)
        try container.encodeIfPresent(timezone, forKey: .timezone)
        try container.encodeIfPresent(sunrise, forKey: .sunrise)
        try container.encodeIfPresent(sunset, forKey: .sunset)
    }
}

