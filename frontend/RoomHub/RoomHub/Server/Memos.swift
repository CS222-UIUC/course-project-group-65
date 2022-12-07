//
//  Memos.swift
//  RoomHub
//
//  Created by Saloni Vaishnav on 11/28/22.
//

import Foundation
import SwiftUI

struct Memo: Codable {
    var id: Int = 0
    var room: Int = 0
    var text: String = ""
    var user: Int = 0
    var editable: Bool = false
}

struct NewMemo: Codable {
    let room: Int
    let text: String
    let user: Int
    let editable: Bool
}


struct MemosView: View {
    @State var results = [Memo]()
    @State var curr = Memo()
    @State var getId = 0
    @State var deleteId = 0
    
    @State var newMemo = Memo()
    
    var body: some View {
//        Text("THIS IS AN IMPORTANT MEMO: " + curr.text)
        
        List(results, id: \.id) { item in
            VStack(alignment: .leading) {
                HStack() {
                    Image(systemName: "xmark").onTapGesture {
                        deleteMemo(id: item.id)
                    }
                    
                    Text(item.text)
                }
            }
        }.onAppear(perform: loadMemos)
            .refreshable {
                loadMemos()
            }
        
//        HStack() {
//            Text("Retrieve a Memo")
//            TextField(
//              "Load 1 memo",
//              value: $getId,
//              formatter: NumberFormatter()
//            )
//            Button(action: {
//
//                loadMemo(id: getId)
//
//            }, label: {
//                Text("Get One Memo")
//                    .frame(width: 200, height: 50)
//                    .font(.system(size: 20))
//                    .frame(maxWidth: .infinity)
//                    .overlay(
//                            RoundedRectangle(cornerRadius: 25)
//                                .stroke(Color.white, lineWidth: 3)
//                                .frame(width: 200, alignment: .bottom)
//                        )
//            })
//
//
//        }
        
        // ADDING A MEMO
        
        VStack(alignment: .leading) {
            Text("Name")
            TextField(
              "add 1 memo",
              text: $newMemo.text
            )
            Button(action: {
                newMemo.room = 1;
                newMemo.user = 2;
                addMemo(toAdd: newMemo)
                
            }, label: {
                Text("Add Memo")
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
        
        // DELETING A MEMO
//        VStack(alignment: .leading) {
//            TextField(
//              "Delete memo",
//              value: $deleteId,
//              formatter: NumberFormatter()
//            ).padding()
//
//            Button(action: {
//
//                deleteMemo(id: deleteId)
//
//            }, label: {
//                Text("Delete Memo")
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
//
//            updateMemo(id: 2, room: 2, text: "another test, but updated!", user: 2, editable: true)
//
//        }, label: {
//            Text("Update Memo")
//                .frame(width: 200, height: 50)
//        })
        
    }
    
    // functionality
    
    func loadMemo(id: Int) {
            guard let url = URL(string: "http://0.0.0.0:8000/memos/\(id)") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode(Memo.self, from: data) {
                        DispatchQueue.main.async {
                            self.curr = response
                        }
                        return
                    }
                }
            }.resume()
    }
    
    func loadMemos() {
            guard let url = URL(string: "http://0.0.0.0:8000/memos/") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode([Memo].self, from: data) {
                        DispatchQueue.main.async {
                            self.results = response
                        }
                        return
                    }
                }
            }.resume()
    }
    
    func deleteMemo(id: Int) {
            guard let url = URL(string: "http://0.0.0.0:8000/memos/\(id)") else {
                print("Invalid URL")
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"


            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode([Memo].self, from: data) {
                        DispatchQueue.main.async {
                            print(response)                        }
                        return
                    }
                }
            }.resume()
    }
    
    func addMemo(toAdd: Memo) {
        guard let url = URL(string: "http://0.0.0.0:8000/memos/") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the response expected to be in JSON format
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
//        let newMemoData = NewMemo(room: room, text: text, user: user, editable: editable);
        let jsonData = try? JSONEncoder().encode(toAdd)
        
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Memo].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }
    
    func updateMemo(toUpdate: Memo) {
        guard let url = URL(string: "http://0.0.0.0:8000/memos/\(toUpdate.id)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the response expected to be in JSON format
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
//        let newMemoData = Memo(id: id, room: room, text: text, user: user, editable: editable);
        let jsonData = try? JSONEncoder().encode(toUpdate)
        
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Memo].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }
}

