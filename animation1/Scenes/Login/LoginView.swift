//
//  LoginView.swift
//
//  Created by Adriano Rezena on 20/08/23.
//

import SwiftUI

struct LoginView: View {

    typealias Strings = LocalizedStrings.LoginView
    
    enum Ani: Hashable, CaseIterable {
        case none
        case bgImage
        case bgText
        case loginView
        case loginButton
        case forgotButton
        case loginTextField
        case passwordTextField
        case dontHaveAccountView
        
        var animation: Animation? {
            switch self {
            case .none:
                return .linear
            case .bgImage:
                return Animation.easeOut(duration: 0.7).delay(0.1)
            case .bgText:
                return Animation.spring(duration: 0.7, bounce: 0.3, blendDuration: 0.5).delay(0.5)
            case .loginView:
                return .spring(duration: 0.5, bounce: 0.5, blendDuration: 0.5).delay(0.8)
            case .loginTextField:
                return .spring(duration: 0.7, bounce: 0.4, blendDuration: 0.5).delay(1.3)
            case .passwordTextField:
                return .spring(duration: 0.7, bounce: 0.4, blendDuration: 0.5).delay(1.5)
            case .forgotButton:
                return .spring(duration: 0.7, bounce: 0.4, blendDuration: 0.3).delay(1.7)
            case .loginButton:
                return .spring(duration: 0.7, bounce: 0.4, blendDuration: 0.3).delay(1.9)
            case .dontHaveAccountView:
                return .spring(duration: 0.7, bounce: 0.5, blendDuration: 0.3).delay(2.1)
            }
        }
    }

    @State var shouldAnimate: Bool = false
    @State var login: String = ""
    @State var password: String = ""
    
    var body: some View {
        mainPage()
    }
}

// MARK: - Pages
extension LoginView {
    
    @ViewBuilder
    func mainPage() -> some View {
        ZStack {
            backgroundImage()
            
            loginPopup()
            
            dontHaveAccountView()
        }
        .onAppear() {
            shouldAnimate = true
        }
    }
    
}

// MARK: - Components
extension LoginView {
    
    @ViewBuilder
    func backgroundImage() -> some View {
        GeometryReader { reader in
            let size = reader.size
            let safeArea = reader.safeAreaInsets
            
            Image.get(.bg)
                .resizable()
                .scaledToFill()
                .frame(height: size.height / 2.5)
                .clipped()
                .overlay {
                    Color.blue.opacity(0.4)
                }
                .overlay {
                    Color.black.opacity(0.4)
                }
                .overlay(alignment: .topLeading) {
                    VStack(alignment: .leading) {
                        Text(Strings.title.rawValue)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(Strings.description.rawValue)
                    }
                    .padding(.top, safeArea.top + 20)
                    .padding(.leading, 16)
                    .foregroundStyle(.white)
                    .offset(shouldAnimate ? .zero : CGSize(width: 0, height: -100))
                    .opacity(shouldAnimate ? 1 : 0)
                    .animation(Ani.bgText.animation, value: shouldAnimate)
                }
                .edgesIgnoringSafeArea(.top)
                .offset(shouldAnimate ? .zero : CGSize(width: 0, height: -(size.height / 2.5)))
                .opacity(shouldAnimate ? 1 : 0)
                .animation(Ani.bgImage.animation, value: shouldAnimate)
        }
    }
    
    @ViewBuilder
    func loginPopup() -> some View {
        VStack(spacing: 20) {
            titleView()
            
            VStack(spacing: 20) {
                loginTextField()
                
                passwordTextField()
            }
           
            HStack {
                Spacer()
                
                forgotPasswordButton()
            }
            
            loginButton()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 40)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.background1)
                .shadow(color: Color.shadow1, radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        )
        .padding(16)
        .offset(shouldAnimate ? .zero : CGSize(width: 0, height: 100))
        .opacity(shouldAnimate ? 1 : 0)
        .animation(Ani.loginView.animation, value: shouldAnimate)
    }

    
    @ViewBuilder
    func titleView() -> some View {
        Text(Strings.popupTitle.rawValue)
            .font(.title)
            .foregroundStyle(Color.text1)
    }
    
    @ViewBuilder
    func loginTextField() -> some View {
        TextField(Strings.popupPlaceholderEmail.rawValue, text: $login)
            .padding(8)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
            )
            .offset(shouldAnimate ? .zero : CGSize(width: 0, height: -50))
            .opacity(shouldAnimate ? 1 : 0)
            .animation(Ani.loginTextField.animation, value: shouldAnimate)
    }
    
    @ViewBuilder
    func passwordTextField() -> some View {
        SecureField(Strings.popupPlaceholderPassword.rawValue, text: $password)
            .padding(8)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
            )
            .offset(shouldAnimate ? .zero : CGSize(width: 0, height: -50))
            .opacity(shouldAnimate ? 1 : 0)
            .animation(Ani.passwordTextField.animation, value: shouldAnimate)
    }
    
    @ViewBuilder
    func forgotPasswordButton() -> some View {
        Button(
            action: {},
            label: {
                Text(Strings.forgotButton.rawValue)
                    .bold()
                    .padding(.trailing, 16)
                    .font(.subheadline)
            }
        )
        .frame(height: 40)
        .foregroundStyle(Color.button1)
        .offset(shouldAnimate ? .zero : CGSize(width: 0, height: -50))
        .opacity(shouldAnimate ? 1 : 0)
        .animation(Ani.forgotButton.animation, value: shouldAnimate)
    }
    
    @ViewBuilder
    func loginButton() -> some View {
        Button(
            action: {},
            label: {
                Text(Strings.popupButtonLogin.rawValue)
                    .bold()
            }
        )
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.button1)
        )
        .contentShape(Rectangle())
        .foregroundStyle(.white)
        .offset(shouldAnimate ? .zero : CGSize(width: 0, height: -50))
        .opacity(shouldAnimate ? 1 : 0)
        .animation(Ani.loginButton.animation, value: shouldAnimate)
    }
    
    @ViewBuilder
    func dontHaveAccountView() -> some View {
        HStack(spacing: 4) {
            Text(Strings.dontHaveAccountButton.rawValue)
            
            Button(
                action: {},
                label: {
                    Text(Strings.signupButton.rawValue)
                        .bold()
                        .foregroundStyle(Color.button1)
                }
            )
            .foregroundStyle(.black)
        }
        .font(.footnote)
        .offset(shouldAnimate ? .zero : CGSize(width: 0, height: 100))
        .opacity(shouldAnimate ? 1 : 0)
        .animation(Ani.dontHaveAccountView.animation, value: shouldAnimate)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
}

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(shouldAnimate: true)
            .previewDisplayName("Static")
            .environment(\.locale, .init(identifier: "en"))
        
        LoginView()
            .environment(\.locale, .init(identifier: "en"))
            .previewDisplayName("EN")
        
        LoginView()
            .environment(\.locale, .init(identifier: "pt"))
            .previewDisplayName("PT")
        
        LoginView(shouldAnimate: true).loginPopup()
            .previewDisplayName("Popup")
    }
}
