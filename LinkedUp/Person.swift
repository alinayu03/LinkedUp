//
//  Person.swift
//  LinkedUp
//
//  Created by Alina Yu on 10/20/24.
//

import Foundation

struct Person: Identifiable, Codable {
    var id = UUID()
    var name: String
    var availability: Date
    var interests: String
}
