//
//  OpenAIManager.swift
//  LinkedUp
//
//  Created by Alina Yu on 10/20/24.
//

import Foundation

class OpenAIManager {
    static let shared = OpenAIManager()
    
    func getOpenAIAPIKey() -> String? {
        if let path = Bundle.main.path(forResource: "OpenAIKeys", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
           let apiKey = dict["OpenAI_API_Key"] as? String {
            return apiKey
        }
        return nil
    }
    
    func findActivity(forGroup group: [Person], completion: @escaping (String) -> Void) {
        let prompt = generatePrompt(forGroup: group)
        
        guard let url = URL(string: "https://api.openai.com/v1/completions") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": prompt,
            "max_tokens": 100
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching activity: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            if let responseDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = responseDict["choices"] as? [[String: Any]],
               let activity = choices.first?["text"] as? String {
                DispatchQueue.main.async {
                    completion(activity)
                }
            }
        }
        task.resume()
    }
    
    func generatePrompt(forGroup group: [Person]) -> String {
        var prompt = "Suggest a fun activity for the following group:\n"
        for person in group {
            prompt += "- Name: \(person.name), Interests: \(person.interests), Available on: \(person.availability)\n"
        }
        return prompt
    }
}
