import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
        
        
//        static let orengeYellow = Color(hex: "FFD60A")
    }
}

extension Color {
    
    static let peach = Color(hex: "#ff8882")
    static let ivory = Color(hex: "f8ede3")
    static let brown = Color(hex: "897853")  // #을 제거하고 사용해도 됩니다.
    static let orangeYellow = Color(hex: "FFD60A")
    static let ashGrey = Color(hex: "8A8A8E")
    static let prettyRed = Color(hex: "FF3B30") 
    static let prettynavy = Color(hex: "2F4858")
    static let lightBlue = Color(hex: "8599CE")
    static let olive = Color(hex: "ADB674")
    static let prettyMint = Color(hex: "85CEAB")
    static let prettyPink = Color(hex: "E590BE")
    static let prettyYellow = Color(hex: "FFF3B5")
    static let prettyBlack = Color(hex: "292424")

    
}
