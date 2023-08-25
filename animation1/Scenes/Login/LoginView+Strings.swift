//
//  LoginView+Strings.swift
//
//  Created by Adriano Rezena on 23/08/23.
//

import SwiftUI

extension LocalizedStrings {
    
    enum LoginView: LocalizedStringKey, CaseIterable {
        case signupButton = "login_button_signup"
        case dontHaveAccountButton = "login_button_dont_have_account"
        case forgotButton = "login_button_forgot"
        case popupTitle = "login_popup_title"
        case popupButtonLogin = "login_popup_button_login"
        case popupPlaceholderEmail = "login_popup_placeholder_email"
        case popupPlaceholderPassword = "login_popup_placeholder_password"
        case title = "login_title"
        case description = "login_description"
    }
    
}
