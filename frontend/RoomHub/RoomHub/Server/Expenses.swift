//
//  Expenses.swift
//  RoomHub
//
//  Created by Saloni Vaishnav on 8/11/22.
//

import Foundation
import SwiftUI

struct Expense: Codable {
    var id: Int = 0
    var name: String = ""
    var amount: Float = 0.0
    var paid: Bool = false
    var date: String = "2002-11-12"
    var category: String = ""
    var room: Int = 0
    var owner: Int = 0
}

//struct NewExpense: Codable {
//    let name: String
//    let amount: Float
//    let paid: Bool
//    let date: String
//    let category: String
//    let room: Int
//    let owner: Int
//}

struct ExpensesView: View {
    @State var results = [Expense]()
    @State var curr = Expense()
    @State var getId = 0
    @State var deleteId = 0
    @State var newExpense = Expense()
    
    var body: some View {
        VStack {
//        Text("THIS IS AN IMPORTANT Expense: " + curr.name)
        List(results, id: \.id) { item in
                HStack() {
                    Image(systemName: "xmark").onTapGesture {
                        deleteExpense(id: item.id)
                    }
//                        Button(action: {
//                            deleteExpense(id: item.id)
//                            print("please")
//                        }, label: {
//
//                        })
                        .frame(maxWidth: .infinity ,alignment: .leading)
//                        .overlay(RoundedRectangle(cornerRadius: 25)
//                            .stroke(Color.blue, lineWidth: 3)
//                            .frame(width: 30, alignment: .bottom)
//                        )

                        
                        Text(item.name)
                            .font(.system(size: 15))
                        Text("$" + String(item.amount))
                            .font(.system(size: 15))
                            .frame(maxWidth: .infinity ,alignment: .leading)
//                            .padding(.trailing, 10)
                        
                        // paid or not button
                    
                    if (item.paid) {
                        Image(systemName: "square.fill").onTapGesture {
                            var tempExpense = item
                            tempExpense.paid = false
                            updateExpense(toUpdate: tempExpense)
                        }
                        
                    } else {
                        Image(systemName: "square").onTapGesture {
                            var tempExpense = item
                            tempExpense.paid = true
                            updateExpense(toUpdate: tempExpense)
                        }
                    }
                    
                    
                        
                }
        }.onAppear(perform: loadExpenses)
            .refreshable {
                loadExpenses()
            }
        }
        
//        Button(action: {
//
//            loadExpense(id: 2)
//
//        }, label: {
//            Text("Get One Expense")
//                .frame(width: 200, height: 50)
//                .font(.system(size: 20))
//                .frame(maxWidth: .infinity)
//                .overlay(
//                        RoundedRectangle(cornerRadius: 25)
//                            .stroke(Color.white, lineWidth: 3)
//                            .frame(width: 200, alignment: .bottom)
//                    )
//        })
        VStack(alignment: .leading) {
            HStack() {
                Text("Name")
                TextField(
                    "add 1 expense",
                    text: $newExpense.name
                )
                
                Text("Amount")
                TextField(
                    "$",
                    value: $newExpense.amount,
                    format: .number
                )
                
                Text("Category")
                TextField(
                    "category",
                    text: $newExpense.category
                )
            }
            
            Button(action: {
            // name: "high chair", amount: 23.35, paid: true, date: "2022-11-12", category: "something", room: 1, owner: 2
                newExpense.owner = 1
                newExpense.room = 1
                addExpense(toAdd: newExpense)
                
            }, label: {
                Text("Add Expense")
            })
            .frame(width: 200, height: 50)
            .font(.system(size: 20))
            .frame(maxWidth: .infinity)
            .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: 200, alignment: .bottom)
                )
        }
//        HStack() {
//            TextField(
//                  "Delete Expense",
//                  value: $deleteId,
//                  formatter: NumberFormatter()
//                ).padding()
//
//            Button(action: {
//                deleteExpense(id: deleteId)
//
//            }, label: {
//                Text("Delete Expense")
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
//        }
        
//        Button(action: {
//            var temp = Expense()
//            updateExpense(toUpdate: temp);
//
//        }, label: {
//            Text("Update Expense")
//                .frame(width: 200, height: 50)
//                .font(.system(size: 20))
//                .frame(maxWidth: .infinity)
//                .overlay(
//                        RoundedRectangle(cornerRadius: 25)
//                            .stroke(Color.white, lineWidth: 3)
//                            .frame(width: 200, alignment: .bottom)
//                    )
//        })
//        }
//        .accentColor(.white)
//        .background(.blue)
    }
    
    func loadExpenses() {
            guard let url = URL(string: "http://0.0.0.0:8000/expenses/") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode([Expense].self, from: data) {
                        DispatchQueue.main.async {
                            self.results = response
                        }
                        return
                    }
                }
            }.resume()
    }
    func addExpense(toAdd: Expense) {
        guard let url = URL(string: "http://0.0.0.0:8000/expenses/") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the response expected to be in JSON format
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
//        let newExpenseData = NewExpense(name: name, amount: amount, paid: paid, date: date, category: category, room: room, owner: owner)
        let jsonData = try? JSONEncoder().encode(toAdd)
        
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Expense].self, from: data) {
                    DispatchQueue.main.async {
                        self.results.append(contentsOf: response)
                        print(results)
                    }
                    return
                }
            }
        }.resume()
    }
    
    func deleteExpense(id: Int) {
            guard let url = URL(string: "http://0.0.0.0:8000/expenses/\(id)") else {
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
    
    func loadExpense(id: Int) {
            guard let url = URL(string: "http://0.0.0.0:8000/expenses/\(id)") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let response = try? JSONDecoder().decode(Expense.self, from: data) {
                        DispatchQueue.main.async {
                            self.curr = response
                        }
                        return
                    }
                }
            }.resume()
    }
    
    func updateExpense(toUpdate: Expense) {
        guard let url = URL(string: "http://0.0.0.0:8000/expenses/\(toUpdate.id)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the response expected to be in JSON format
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
//        let newExpenseData = Expense(id: id, name: name, amount: amount, paid: paid, date: date, category: category, room: room, owner: owner);
        let jsonData = try? JSONEncoder().encode(toUpdate)
        
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Expense].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }
}
