//
//  CrashView.swift
//  AppTemplate
//
//  Created by Pieter Jooste on 2024/05/29.
//

import SwiftUI
import FirebaseCrashlytics

final class Crashmanager {
    
    static let shared = Crashmanager()
    private init() { }
    
    func setUserId(userId: String) {
        Crashlytics.crashlytics().setUserID(userId)
    }
    
    private func setValue(value: String, key: String) {
        Crashlytics.crashlytics().setCustomValue(value, forKey: key)
    }
    
    func setIsPremiumValue(isPremium: Bool) {
        setValue(value: isPremium.description.lowercased(), key: "user_is_premium")
    }
    
    func addLog(message: String) {
        Crashlytics.crashlytics().log(message)
    }
}

struct CrashView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                Button("Click me 1") {
                    Crashmanager.shared.addLog(message: "button_1_clicked")
                    
                    let myString: String? = nil
                    let string2 = myString!
                }
                
                Button("Click me 2") {
                    Crashmanager.shared.addLog(message: "button_2_clicked")
                    
                    fatalError("This was a fatal crash")
                }
                
                Button("Click me 3") {
                    Crashmanager.shared.addLog(message: "button_3_clicked")
                    
                    let array: [String] = []
                    let item = array[0]
                }
            }
        }
        .onAppear {
            Crashmanager.shared.setUserId(userId: "ABC123")
            Crashmanager.shared.setIsPremiumValue(isPremium: true)
            Crashmanager.shared.addLog(message: "crash_view_appeared")
        }
    }
}

#Preview {
    CrashView()
}
