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
    
    func signOut() {
        try? auth.signOut();
        
        self.signedIn = false;
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                VStack {
                    Text("You are Signed in")
                    
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Log Out")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.purple)
                    })
                    
                }
                
            } else {
                StartView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct StartView: View {
    var body: some View {
        ZStack{
            VStack(){
                Text("all your\nroomate\nneeds\nin one pod.")
                    .font(.system(size: 50, weight: .bold))
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .padding(.leading, 25)
                    .foregroundColor(.white)
                Spacer()
                Button(action: {
                    // do nothing... yet
                }, label: {
                    NavigationLink(destination: LogInView()) {
                        Text("get started \(Image(systemName: "arrow.right"))")
                            .font(.system(size: 25))
                            .frame(maxWidth: .infinity ,alignment: .trailing)
                            .padding(.trailing, 25)
                            .imageScale(.small)
                    }
                })
                .cornerRadius(25)
                .padding(.bottom, 100)
            }
        }
        .accentColor(.white)
        .background(.purple)
    }
}

struct LogInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text("log in")
                    .font(.system(size: 50, weight: .bold))
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .padding(.leading, 25)
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 0){
                    Text("email address")
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .padding(.leading, 25)
                        .foregroundColor(.white)
                    TextField("", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        .foregroundColor(.white)
                    .padding()
                    Text("password")
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity ,alignment: .leading)
                        .padding(.leading, 25)
                        .padding(.bottom, 15)
                        .foregroundColor(.white)
                    SecureField("", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        .padding()
                }
                Button(action:{
                    
                    guard !email.isEmpty, !password.isEmpty else {
                        return // email and/or password are empty -> tell user this
                    }
                    
                    viewModel.signIn(email: email, password: password)
                    
                }, label: {
                    Text("Log In")
                        .frame(width: 200, height: 50)
                })
                .cornerRadius(25)
                
                Spacer()
                Button(action: {
                    // do nothing... yet
                }, label: {
                    NavigationLink(destination: SignUpView()) {
                        Text("first time? \(Image(systemName: "arrow.right"))")
                            .font(.system(size: 25))
                            .frame(maxWidth: .infinity ,alignment: .trailing)
                            .padding(.trailing, 25)
                            .imageScale(.small)
                    }
                })
                .cornerRadius(25)
                .padding(.bottom, 100)
            }
        }
        .accentColor(.white)
        .background(.purple)
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        VStack {
            
            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                Button(action:{
                    
                    guard !email.isEmpty, !password.isEmpty else {
                        return // email and/or password are empty -> tell user this
                    }
                    
                    viewModel.signUp(email: email, password: password)
                    
                }, label: {
                    Text("Create Account")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .cornerRadius(8)
                        .background(Color.purple)
                })
            }
            Button(action: {
                // do nothing... yet
            }, label: {
                NavigationLink(destination: LogInView()) {
                    Text("Already have an account? Sign in here")
                        .foregroundColor(Color.blue)
                }
            })
            
            .padding()
            
            Spacer()
        }
        .navigationTitle("Create Account")
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
