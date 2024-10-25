//
//  Styles.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 24/10/2024.
//

import SwiftUI

struct Title2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle, design: .default, weight: .semibold))
    }
}

struct Semibold8: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("InterVariable", size: 32))
            .fontWeight(.semibold)
            .lineSpacing(36 - 32) // LineH - FontH
            .kerning(-0.3 / 16) // Letter / 16
    }
}

struct Semibold7: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("InterVariable", size: 24))
            .fontWeight(.semibold)
            .lineSpacing(32 - 24) // LineH - FontH
            .kerning(-0.1 / 16) // Letter / 16
    }
}

struct Semibold4: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("InterVariable", size: 16))
            .fontWeight(.semibold)
            .lineSpacing(24 - 16) // LineH - FontH
    }
}

struct Medium4: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("InterVariable", size: 16))
            .fontWeight(.medium)
            .lineSpacing(24 - 16) // LineH - FontH
    }
}

struct Medium3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("InterVariable", size: 14))
            .fontWeight(.medium)
            .lineSpacing(20 - 14) // LineH - FontH
    }
}

struct Regular4: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("InterVariable", size: 16))
            .fontWeight(.regular)
            .lineSpacing(24 - 16) // LineH - FontH
    }
}

struct Regular3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("InterVariable", size: 14))
            .fontWeight(.regular)
            .lineSpacing(20 - 14) // LineH - FontH
    }
}

struct Regular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("InterVariable", size: 20))
            .fontWeight(.semibold)
            .lineSpacing(28 - 20) // LineH - FontH
            .kerning(-0.1 / 16) // Letter / 16
    }
}

struct TimeBig: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("InterVariable", size: 120))
            .fontWeight(.semibold)
            .lineSpacing(160 - 120) // LineH - FontH
            .kerning(-1.12 / 16) // Letter / 16
    }
}

extension View {
    func semibold11() -> some View {
        modifier(Title2())
    }
    func semibold8() -> some View {
        modifier(Semibold8())
    }
    func semibold7() -> some View {
        modifier(Semibold7())
    }
    func semibold4() -> some View {
        modifier(Semibold4())
    }
    func medium4() -> some View {
        modifier(Medium4())
    }
    func medium3() -> some View {
        modifier(Medium3())
    }
    func regular3() -> some View {
        modifier(Regular3())
    }
    func regular4() -> some View {
        modifier(Regular4())
    }
    func regular() -> some View {
        modifier(Regular())
    }
}

#Preview {
    List {
        Text("Semi-bold 11")
            .semibold11()
        Text("Semi-bold 8")
            .semibold8()
        Text("1234567890")
            .semibold8()
        Text("Semi-bold 7")
            .semibold7()
        Text("Semi-bold 4")
            .semibold4()
        Text("Medium 4")
            .medium4()
        Text("Medium 3")
            .medium3()
        Text("Regular 4")
            .regular4()
        Text("Regular 3")
            .regular3()
        Text("Regular")
            .regular()
    }
    .preferredColorScheme(.dark)
}
