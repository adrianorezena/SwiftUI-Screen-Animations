//
//  Color+Extensions.swift
//
//  Created by Adriano Rezena on 24/08/23.
//

import SwiftUI

extension Color {
    static let text1: Color = Color(light: Color.black, dark: Color.white)
    static let background1: Color = Color(light: Color.white, dark: Color.black)
    static let background2: Color = Color(light: Color.gray.opacity(0.1 ), dark: Color.black.opacity(0.8))
    static let button1: Color = Color(light: Color.blue, dark: Color.purple)
    static let shadow1: Color = Color(light: Color.black.opacity(0.5), dark: Color.gray.opacity(0.3))
}

// https://www.jessesquires.com/blog/2023/07/11/creating-dynamic-colors-in-swiftui/
extension Color {
    
    init(light: Color, dark: Color) {
        #if canImport(UIKit)
        self.init(light: UIColor(light), dark: UIColor(dark))
        #else
        self.init(light: NSColor(light), dark: NSColor(dark))
        #endif
    }

    #if canImport(UIKit)
    init(light: UIColor, dark: UIColor) {
        #if os(watchOS)
        // watchOS does not support light mode / dark mode
        // Per Apple HIG, prefer dark-style interfaces
        self.init(uiColor: dark)
        #else
        self.init(uiColor: UIColor(dynamicProvider: { traits in
            switch traits.userInterfaceStyle {
            case .light, .unspecified:
                return light

            case .dark:
                return dark

            @unknown default:
                assertionFailure("Unknown userInterfaceStyle: \(traits.userInterfaceStyle)")
                return light
            }
        }))
        #endif
    }
    #endif

    #if canImport(AppKit)
    init(light: NSColor, dark: NSColor) {
        self.init(nsColor: NSColor(name: nil, dynamicProvider: { appearance in
            switch appearance.name {
            case .aqua,
                 .vibrantLight,
                 .accessibilityHighContrastAqua,
                 .accessibilityHighContrastVibrantLight:
                return light

            case .darkAqua,
                 .vibrantDark,
                 .accessibilityHighContrastDarkAqua,
                 .accessibilityHighContrastVibrantDark:
                return dark

            default:
                assertionFailure("Unknown appearance: \(appearance.name)")
                return light
            }
        }))
    }
    #endif
    
}
