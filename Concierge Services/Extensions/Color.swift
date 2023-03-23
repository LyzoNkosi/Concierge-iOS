import Foundation
import SwiftUI

extension Color {
    static var theme: Color  {
        return Color("theme")
    }
    static var BackgroundColor: Color  {
        return Color("ColorBackground")
    }
    static var BackgroundColorList: Color  {
        return Color("ColorBackgroundList")
    }
    static var ColorPrimary: Color  {
        return Color("ColorPrimary")
    }
    static var ColorSecondary: Color  {
        return Color("ColorSecondary")
    }
    static var Accent: Color  {
        return Color("ColorAccent")
    }
    static var TextColorPrimary: Color  {
        return Color("ColorTextPrimary")
    }
    static var TextColorSecondary: Color  {
        return Color("ColorTextSecondary")
    }
    static var LightGreyColor: Color {
        return Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    }
}
