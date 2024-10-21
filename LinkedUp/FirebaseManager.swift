//
//  FirebaseManager.swift
//  LinkedUp
//
//  Created by Alina Yu on 10/20/24.
//

import FirebaseFirestore
import Foundation

class FirebaseManager {
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()
    
    func savePerson(_ person: Person) {
        do {
            let _ = try db.collection("people").addDocument(from: person)
        } catch let error {
            print("Error saving person: \(error)")
        }
    }
}
