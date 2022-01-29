//
//  RegisterView.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 26.01.2022.
//

import SwiftUI

struct RegisterView: View {
    @AppStorage("userName") var userName = ""
    @EnvironmentObject private var userManager: UserManager
    @State private var name = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter your name", text: $name)
                    .multilineTextAlignment(.center)
                userNameCounter(name: $name)
            }.padding()
            Button(action: registerUser) {
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text("OK")
                }
            }.disabled(validateUserName())
        }
    }
    
    private func validateUserName() -> Bool {
        if name.count <= 2 {
            return true
        } else {
            return false
        }
    }
    
    private func registerUser() {
        if !name.isEmpty {
            userName = name
            userManager.name = name
            userManager.isRegister.toggle()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

struct userNameCounter: View {
    @Binding var name: String
    
    var body: some View {
        Text("\(name.count)")
            .foregroundColor(coloredCounter())
    }
    
    private func coloredCounter() -> Color {
        if name.count <= 2 {
            return .red
        } else {
            return .green
        }
        
    }
}
