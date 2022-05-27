//
//  ContentView.swift
//  RoomHub
//
//  Created by Saloni Vaishnav on 5/21/22.
//

import SwiftUI
import FirebaseAuth
// import simd

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    func signIn(email: String, password: String) {
        // sign in with email
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return // failed
            }
            // success
            DispatchQueue.main.async {
                self?.signedIn = true

            }

        }
    }
    func signUp(email: String, password: String) {
        // sign up with email
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {

                self?.signedIn = true
            }
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel

    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                Text("You are Signed in")
            } else {
                LogInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct LogInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel

    
    var body: some View {
        VStack {
            TextField("Email Address", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            Button(action:{
                
                guard !email.isEmpty, !password.isEmpty else {
                    return // email and/or password are empty -> tell user this
                }
                
                viewModel.signIn(email: email, password: password)
                
            }, label: {
                Text("Log In")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .cornerRadius(8)
                    .background(Color.purple)
            })
        }
        .padding()
        
        Spacer()
        .navigationTitle("Log In")
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
