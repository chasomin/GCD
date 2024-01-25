//
//  Endpoint.swift
//  GCD
//
//  Created by 차소민 on 1/25/24.
//

import Foundation


enum Endpoint: String, CaseIterable {
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2401/image-20240116164558_v11024.jpg"
    case nine = "2401/EarthMoon_Artemis1Saunders_1600.jpg"

    static var url: URL {
        return URL(string: baseURL + Endpoint.allCases.randomElement()!.rawValue)!
    }
    
}
