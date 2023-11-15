//
//  Location.swift
//  NavGo
//
//  Created by Kevin Martinez on 11/8/23.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    
//MARK: - Properties
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String

    //MARK: - Identifiable
    
    var id: String {
        name + cityName
    }
    
    
//MARK: - Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
