//
//  Expenses.swift
//  RoomHub
//
//  Created by Saloni Vaishnav on 8/11/22.
//

import Foundation

struct Expense: Codable {
    let id: Int
    let name: String
    let amount: Float
    let paid: Bool
    let date: String
    let category: String
    let room: Int
}

//class ExpenseApi : ObservableObject {
//    @Published var expenses = [Expense]()
//
//    func loadData
//
//}
//

func getExpenses() {
    let url = URL(string: "http://localhost:8000")!

    var request = URLRequest(url: url)

    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
        if let data = data {
            if let expenses = try? JSONDecoder().decode([Expense].self, from: data) {
                print(expenses)
            } else {
                print("invalid response")
            }
        } else if let error = error {
            print("FAILED: \(error)")
        }
    }

    task.resume()
}

/*
 
 
 name = models.CharField(max_length=45, default="")
    amount = models.FloatField(default=0)
    paid = models.BooleanField(default=0)
    date = models.DateTimeField(auto_now_add=True)
    category = models.CharField(max_length=45, default="")
    room =
 */
