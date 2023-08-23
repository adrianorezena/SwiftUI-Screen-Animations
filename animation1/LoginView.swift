//
//  LoginView.swift
//  animation1
//
//  Created by Adriano Rezena on 20/08/23.
//

import SwiftUI

struct LoginView: View {
    
    enum Ani: Hashable, CaseIterable {
        case none
        case bgImage
        case bgText
        case loginView
        case loginButtonUp
        case loginTextField
        case passwordTextField
        
        var animation: Animation {
            switch self {
            case .none:
                return .linear
            case .bgImage:
                return Animation.easeIn(duration: 1).delay(0.1)
            case .bgText:
                return Animation.spring(duration: 1, bounce: 0.3, blendDuration: 0.5).delay(0.5)
            case .loginView:
                return .spring(duration: 0.5, bounce: 0.5, blendDuration: 0.5).delay(1)
            case .loginTextField:
                return .spring(duration: 0.7, bounce: 0.4, blendDuration: 0.5).delay(1.5)
            case .passwordTextField:
                return .spring(duration: 0.7, bounce: 0.4, blendDuration: 0.5).delay(1.7)
            case .loginButtonUp:
                return .spring(duration: 0.7, bounce: 0.4, blendDuration: 0.3).delay(1.9)
            }
        }
    }

    @State var shouldAnimate: Bool = false
    
    var body: some View {
        page()
    }
}

// MARK: - Pages
extension LoginView {
    
    @ViewBuilder
    func page() -> some View {
        ZStack {
            backgroundImage()
            
            loginPopup()
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
            
            Image("pexels-josh-hild-2422259")
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
                        Text("Welcome")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("loren ipsum")
                    }
                    .padding(.top, safeArea.top + 20)
                    .padding(.leading, 16)
                    .foregroundStyle(.white)
                    .offset(shouldAnimate ? .zero : CGSize(width: 0, height: -100))
                    .opacity(shouldAnimate ? 1 : 0)
                    .animation(Ani.bgText.animation, value: shouldAnimate)
                }
                .edgesIgnoringSafeArea(.top)
                .offset(shouldAnimate ? .zero : CGSize(width: 0, height: -100))
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
           
            loginButton()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 40)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.5), radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        )
        .padding(16)
        .offset(shouldAnimate ? .zero : CGSize(width: 0, height: 100))
        .opacity(shouldAnimate ? 1 : 0)
        .animation(Ani.loginView.animation, value: shouldAnimate)
    }

    
    @ViewBuilder
    func titleView() -> some View {
        Text("Login")
            .font(.title)
            .foregroundStyle(.primary)
    }
    
    @ViewBuilder
    func loginTextField() -> some View {
        TextField("e-mail", text: .constant(""))
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
        SecureField("password", text: .constant(""))
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
    func loginButton() -> some View {
        Button(
            action: {},
            label: {
                Text("Login")
                    .bold()
            }
        )
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue)
        )
        .foregroundStyle(.white)
        .offset(shouldAnimate ? .zero : CGSize(width: 0, height: -50))
        .opacity(shouldAnimate ? 1 : 0)
        .animation(Ani.loginButtonUp.animation, value: shouldAnimate)
    }
    
}

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
