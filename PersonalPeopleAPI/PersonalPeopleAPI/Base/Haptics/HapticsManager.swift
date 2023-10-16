//
//  HapticsManager.swift
//  PersonalPeopleAPI
//
//  Created by Manish Parihar on 16.10.23.
//

import Foundation
import UIKit

// Haptics Manager class is to create a effect of vibration on success or unsuccess
// Haptics does not work on Simulators

// fileprivate : Reason to marking this classifier private is becauses,
// I dont want anyone from outside of this to access this, i just want this to be private to this file.
fileprivate final class HapticsManager {
    
    // why make singleton class, we are actually creating an object that actually helps us
    // trigger a notification to you to vibrate the users device, and we dont want to create an
    // instance every single time, so by using singleton, it will allow us to use once.
    static let shared = HapticsManager()
    
    private let feedback = UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType){
        feedback.notificationOccurred(notification)
    }
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultsKeys.hapticsEnabled){
        HapticsManager.shared.trigger(notification)
    }
}
