//
//  ContentView.swift
//  Login
//
//  Created by Alexa Veletanga on 4/1/21.
//

import SwiftUI


let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)

let storedUsername = "Jack"
let storedPassword = "abcabc"

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    @State var authenticationFailed: Bool = false
    @State var authenticationSuccess: Bool = false
    
  var body: some View {
        
    ZStack{
        VStack{
            HelloText()
            Linkuplogo()
            UsernameTextField(username: $username)
            PasswordSecureField(password: $password)
            if authenticationFailed {
                Text("Information not correct. Try again.")
                    .offset(y: -10)
                    .foregroundColor(.red)
            }
            
            
            Button(action: {
                if self.username == storedUsername && self.password == storedPassword {
                    self.authenticationSuccess = true
                    self.authenticationFailed = false
                    logmein(username: self.username, password: self.password)
                }
                
                else{ self.authenticationFailed = true
                }
            }) {
            LoginButtonContent()
            }
                
        }
        .padding()
        if authenticationSuccess{
            Text("Login succeeded!")
                .font(.headline)
                .frame(width: 250, height: 80)
                .background(Color.yellow)
                .cornerRadius(20.0)
                .animation(Animation.default)
            
        }
    }
        }
        }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HelloText: View{
    var body: some View{
        Text("Welcome To Linkup")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
    }

struct Linkuplogo: View {
    var body: some View {
        Image("Linkuplogo")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.black)
            .cornerRadius(35.0)
    }
}

struct UsernameTextField: View {
   
    @Binding var username: String
    var body: some View {
        TextField("Username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom,20)
    }
}

struct PasswordSecureField: View {
    
    @Binding var password: String
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom,20)
    }
}
    
   // @IBAction func submitAction(_ sender: LoginButtonContent){}
       
        func logmein(username: String, password: String){
        //declare parameter as dictionary which contains string as key and value
        let parameters: [String: String] = ["name": username, "password": password]
        
        //create url to use
        let url = URL(string: "http://example.com/api")!
        
        //create session object
        
        let session = URLSession.shared
        
        //create the request with the url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create Datatask using the session object to send data to server
        let task = session.dataTask(with: request, completionHandler: {data , response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    //handle json
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
    task.resume()
        }
