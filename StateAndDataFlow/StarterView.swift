//
//  StarterView.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 26.01.2022.
//

import SwiftUI

struct StarterView: View {
    @AppStorage("userName") var userName = ""
    @EnvironmentObject private var userManager: UserManager
    
    var body: some View {
        Group {
            if userManager.isRegister || naming() {
                ContentView()
            } else {
                RegisterView()
            }
        }
    }
    
    private func naming() -> Bool {
        if userName.count > 0 {
        userManager.name = userName
            userManager.isRegister.toggle()
            return true
        } else { return false }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
            .environmentObject(UserManager())
    }
}
}
