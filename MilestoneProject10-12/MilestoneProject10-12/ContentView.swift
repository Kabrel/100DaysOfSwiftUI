//
//  ContentView.swift
//  MilestoneProject10-12
//
//  Created by Константин Шутов on 16.09.2023.
//

import SwiftUI

struct User: Codable {
    let id: String
    let name: String
    let age: Int
}

struct ContentView: View {
    @State private var users = [User]()

    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text("Age: \(user.age)")
                        .foregroundColor(.secondary)
                }
            }
            .navigationBarTitle("Users")
        }
        .onAppear(perform: loadData)
    }

    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    self.users = try decoder.decode([User].self, from: data)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
