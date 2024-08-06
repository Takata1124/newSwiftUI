//
//  ContentViewModel.swift
//  newSwiftUI
//
//  Created by t032fj on 2024/08/06.
//

import Foundation

struct Comment: Codable {
    var id: Int
    var name: String
    var email: String
    var body: String
}

class ContentViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var customCells: [CustomCell] = []
    @Published var selectIndex: Int = 0
    
    init() {
        
    }
    
    func setup() {
        customCells = [
            CustomCell(name: "山田", age: "24"),
            CustomCell(name: "小島", age: "83"),
            CustomCell(name: "岡部", age: "39"),
            CustomCell(name: "山田", age: "24"),
            CustomCell(name: "小島", age: "83"),
            CustomCell(name: "岡部", age: "39"),
            CustomCell(name: "山田", age: "24"),
            CustomCell(name: "小島", age: "83"),
            CustomCell(name: "岡部", age: "39")
        ]
    }
    
    func search() async throws -> Void {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Invalid data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let comments = try decoder.decode([Comment].self, from: data)
                _ = comments.map { comment in
                    DispatchQueue.main.async {
                        self.customCells.append(CustomCell(name: comment.email, age: comment.body))
                    }
                }
            } catch let error {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func clear() {
        customCells.removeAll()
    }
}
