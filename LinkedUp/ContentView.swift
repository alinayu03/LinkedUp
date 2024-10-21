//
//  ContentView.swift
//  LinkedUp
//
//  Created by Alina Yu on 10/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var availability = Date()
    @State private var interests = ""
    @State private var people: [Person] = []
    @State private var suggestedActivity: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Details")) {
                    TextField("Name", text: $name)
                    DatePicker("Availability", selection: $availability, displayedComponents: .date)
                    TextField("Interests", text: $interests)
                }
                
                Button("Add Another Person") {
                    let person = Person(name: name, availability: availability, interests: interests)
                    FirebaseManager.shared.savePerson(person)
                    people.append(person)
                    clearForm()
                }
                
                Button("Find Activity!") {
                    OpenAIManager.shared.findActivity(forGroup: people) { activity in
                        suggestedActivity = activity
                    }
                }
                
                if !suggestedActivity.isEmpty {
                    Section(header: Text("Suggested Activity")) {
                        Text(suggestedActivity)
                    }
                }
            }
            .navigationTitle("Group Activity Finder")
        }
    }
    
    func clearForm() {
        name = ""
        availability = Date()
        interests = ""
    }
}
