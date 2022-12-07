import UIKit


// set up a book object
struct Book: Decodable {
    let author: String
    let title: String
}


// here we set the url for the api
let url = URL(string: "https://bit.ly/3sspdFO")!

// this sets up a request
var request = URLRequest(url: url)

// this is the api call method
request.httpMethod = "GET"


// here we do a data task, with the specified url. then, we get some data, the response, and possibly an error (if it failed)
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    // if we have data...
    if let data = data {
        // decode the response from the pai into the object that we created
        if let books = try? JSONDecoder().decode([Book].self, from: data) {
            print(books)
        // if it fails, then print error
        } else {
            print("invalid response")
        }
    // if we dont have data and have an error
    } else if let error = error {
        print("FAILED: \(error)")
    }

}

task.resume()
