//
//  Chores.swift
//  RoomHub
//
//  Created by Saloni Vaishnav on 11/28/22.
//

import Foundation
import SwiftUI

struct Chore: Codable {
    var id: Int = 0
    var name: String = ""
    var completed: Bool = false
    var weight: Int = 0
    var room: Int = 0
    var user: Int = 0
}

//struct NewChore: Codable {
//    var name: String = 0
//    var completed: Bool
//    var weight: Int
//    var room: Int
//    var user: Int
//}


struct ChoresView: View {
    @State var results = [Chore]()
    @State var curr = Chore()
    @State var getId = 0
    @State var deleteId = 0
    @State var newChore = Chore()


    var body: some View {
//        Text("THIS IS AN IMPORTANT CHORE: " + curr.name)
        List(results, id: \.id) { item in
            VStack(alignment: .leading) {
                HStack() {

                    Image(systemName: "xmark").onTapGesture {
                        deleteChore(id: item.id)
                    }
                    
                    Text(String(item.id))
                    Text(item.name)
                    
//                    Button(action: {
//                        var tempChore = item
//                        tempChore.completed = true
//                        updateChore(toUpdate: tempChore)
//                    }, label: {
                        if (item.completed) {
                            Image(systemName: "square.fill").onTapGesture {
                                var tempChore = item
                                tempChore.completed = false
                                updateChore(toUpdate: tempChore)
                            }
                        } else {
                            Image(systemName: "square").onTapGesture {
                                var tempChore = item
                                tempChore.completed = true
                                updateChore(toUpdate: tempChore)
                            }
                        }
//                   })
                }
            }
        }.onAppear(perform: loadChores)
            .refreshable {
                loadChores()
            }
        
    
        // GETTING ONE CHORE
        
//        HStack() {
//            Text("Retrieve a Chore")
//            TextField(
//              "Load 1 chore",
//              value: $getId,
//              formatter: NumberFormatter()
//            )
//            Button(action: {
//
//                loadChore(id: getId)
//
//            }, label: {
//                Text("Get One Chore")
//                    .frame(width: 200, height: 50)
//            })
//
//
//        }
        
        
        // ADDING A CHORE
        HStack {
            Text("Name")
            TextField(
              "add 1 chore",
              text: $newChore.name
            )
            Button(action: {
                newChore.room = 1;
                newChore.user = 2;
                addChore(toAdd: newChore)
                
            }, label: {
                Text("Add Chore")
                    .frame(width: 200, height: 50)
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity)
                    .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 3)
                                .frame(width: 200, alignment: .bottom)
                        )
            })
        }
//        HStack {
//            Text("Name")
//            TextField(
//              "add 1 chore",
//              text: $newChore.name
//            )
//            Button(action: {
//                newChore.room = 1;
//                newChore.user = 2;
//                addChore(toAdd: newChore)
//
//            }, label: {
//                Text("Add Chore")
//                    .frame(width: 200, height: 50)
//                    .font(.system(size: 20))
//                    .frame(maxWidth: .infinity)
//                    .overlay(
//                            RoundedRectangle(cornerRadius: 25)
//                                .stroke(Color.white, lineWidth: 3)
//                                .frame(width: 200, alignment: .bottom)
//                        )
//            })r
//        }
        
        //        // DELETING A CHORE
//        VStack(alignment: .leading) {
//            TextField(
//              "Delete chore",
//              value: $deleteId,
//              formatter: NumberFormatter()
//            ).padding()
//
//            Button(action: {
//
//                deleteChore(id: deleteId)
//
//            }, label: {
//                Text("Delete Chore")
//                    .frame(width: 200, height: 50)
//            })
//        }

        // DELETING A CHORE
//        VStack(alignment: .leading) {
//            TextField(
//              "Delete chore",
//              value: $deleteId,
//              formatter: NumberFormatter()
//            ).padding()
//
//            Button(action: {
//
//                deleteChore(id: deleteId)
//
//            }, label: {
//                Text("Delete Chore")
//                    .frame(width: 200, height: 50)
//                    .font(.system(size: 20))
//                    .frame(maxWidth: .infinity)
//                    .overlay(
//                            RoundedRectangle(cornerRadius: 25)
//                                .stroke(Color.white, lineWidth: 3)
//                                .frame(width: 200, alignment: .bottom)
//                        )
//            })
//        }
        
//        Button(action: {
//            let temp = Chore(id: 10, name: "vaccum the curtains", completed: true, weight: 3, room: 2, user: 2)
//            updateChore(toUpdate: temp)
//
//        }, label: {
//            Text("Update Chore")
//                .frame(width: 200, height: 50)
//        })
        
    }
    
    func loadChore(id: Int) {
            guard let url = URL(string: "http://0.0.0.0:8000/chores/\(id)") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode(Chore.self, from: data) {
                        DispatchQueue.main.async {
                            self.curr = response
                        }
                        return
                    }
                }
            }.resume()
    }
    
    func loadChores() {
            guard let url = URL(string: "http://0.0.0.0:8000/chores/") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode([Chore].self, from: data) {
                        DispatchQueue.main.async {
                            self.results = response
                        }
                        return
                    }
                }
            }.resume()
    }
    
    func deleteChore(id: Int) {
            guard let url = URL(string: "http://0.0.0.0:8000/chores/\(id)") else {
                print("Invalid URL")
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"


            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode([Chore].self, from: data) {
                        DispatchQueue.main.async {
                            print(response)                        }
                        return
                    }
                }
            }.resume()
    }
    
    func addChore(toAdd: Chore) {
        guard let url = URL(string: "http://0.0.0.0:8000/chores/") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the response expected to be in JSON format
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
//        let newChoreData = NewChore(name: name, completed: completed, weight: weight, room: room, user: user);
        let jsonData = try? JSONEncoder().encode(toAdd)
        
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Chore].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }
    
    func updateChore(toUpdate: Chore) {
        guard let url = URL(string: "http://0.0.0.0:8000/chores/\(toUpdate.id)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the response expected to be in JSON format
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
//        let newChoreData = Chore(id: id, name: name, completed: completed, weight: weight, room: room, user: user);
        let jsonData = try? JSONEncoder().encode(toUpdate)
        
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Chore].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }
}
