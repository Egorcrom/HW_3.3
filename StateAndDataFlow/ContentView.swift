//
//  ContentView.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 26.01.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timer = TimeCounter()
    @EnvironmentObject private var userManager: UserManager
    
    var body: some View {
        VStack {
            Text("Hi, \(userManager.name)")
                .font(.largeTitle)
                .padding(.top, 100)
            Text("\(timer.counter)")
                .font(.largeTitle)
                .padding(.top, 50)
            Spacer()
            StartButtonView(timer: timer)
            Spacer()
            LogOutButtonView()
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserManager())
    }
}

struct StartButtonView: View {
    @ObservedObject var timer: TimeCounter
    
    var body: some View {
        Button(action: timer.startTimer) {
            Text(timer.buttonTitle)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .borderedStyle(backgroundColor: .red)
    }
}

struct LogOutButtonView: View {
    @AppStorage("userName") var userName = ""
    @EnvironmentObject private var userManager: UserManager
    
    var body: some View {
        Button(action: logOut) {
            Text("LogOut")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .borderedStyle(backgroundColor: .blue)
    }
    
    private func logOut() {
        userName = ""
        userManager.isRegister.toggle()
        
    }
    
}

struct ButtonModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: 200, height: 60)
            .background(color)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 4)
            )
    }
}

extension Button {
    func borderedStyle(backgroundColor: Color) -> some View {
        ModifiedContent(
            content: self,
            modifier: ButtonModifier(color: backgroundColor))
    }
}
