
import UIKit

extension UIColor {
    /**
     16进制颜色转换 例：UIColor.colorWithHex(0xff2),
     UIColor.colorWithHex(0xff2222),UIColor.colorWithHex(0xff2222, alpha:0.5)
     
     - parameter hex:   颜色值 类似0xff2 0xff2222  的值
     - parameter alpha: 透明度
     
     - returns: 颜色对象
     */
    
    class func colorWithHex(hex:UInt32, alpha:Float = 1.0) -> UIColor {
        var red:Float = 0.0, green:Float = 0.0, blue:Float = 0.0, nAlpha:Float = alpha
        let hexString:String = String(format: "%03X", arguments: [UInt32(hex)])
        let length:Int = hexString.lengthOfBytes(using: String.Encoding.utf8)
        switch length {
        case 3:
            red = Float(Float((hex >> 8) & 0xF)/15.0)
            green = Float(Float((hex >> 4) & 0xF)/15.0)
            blue = Float(Float(hex & 0xF)/15.0)
        case 4:
            nAlpha = Float(Float((hex >> 12) & 0xF)/15.0)
            red = Float(Float((hex >> 8) & 0xF)/15.0)
            green = Float(Float((hex >> 4) & 0xF)/15.0)
            blue = Float(Float(hex & 0xF)/15.0)
        case 6:
            red = Float(Float((hex >> 16) & 0xFF)/255.0)
            green = Float(Float((hex >> 8) & 0xFF)/255.0)
            blue = Float(Float(hex & 0xFF)/255.0)
        case 8:
            nAlpha = Float(Float((hex >> 24) & 0xFF)/255.0)
            red = Float(Float((hex >> 16) & 0xFF)/255.0)
            green = Float(Float((hex >> 8) & 0xFF)/255.0)
            blue = Float(Float(hex & 0xFF)/255.0)
        default:
            break
        }
        
        return self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(nAlpha))
    }
    
    /**
     16进制颜色转换 例如：UIColor.colorWithHexString("0xff2222"),
     UIColor.colorWithHexString("ff0000"),UIColor.colorWithHexString("#ff0000")
     
     - parameter string: 16进制字符串
     - parameter alpha:  透明度
     
     - returns: 颜色对象
     */
    class func colorWithHexString(string:String, alpha:Float = 1.0) -> UIColor {
        let colorString = string.replacingOccurrences(of: "#", with: "", options: [], range: nil)
        var red:Float = 0.0, green:Float = 0.0, blue:Float = 0.0, nAlpha:Float = alpha
        let length:Int = colorString.lengthOfBytes(using: String.Encoding.utf8)
        switch length {
        case 3:
            red   = self.colorHexComponent(string: colorString, start: 0, length: 1)
            green = self.colorHexComponent(string: colorString, start: 1, length: 1)
            blue  = self.colorHexComponent(string: colorString, start: 2, length: 1)
        case 4:
            nAlpha = self.colorHexComponent(string: colorString, start: 0, length: 1)
            red   = self.colorHexComponent(string: colorString, start: 1, length: 1)
            green = self.colorHexComponent(string: colorString, start: 2, length: 1)
            blue  = self.colorHexComponent(string: colorString, start: 3, length: 1)
        case 6:
            red   = self.colorHexComponent(string: colorString, start: 0, length: 2)
            green = self.colorHexComponent(string: colorString, start: 2, length: 2)
            blue  = self.colorHexComponent(string: colorString, start: 4, length: 2)
        case 8:
            nAlpha = self.colorHexComponent(string: colorString, start: 0, length: 2)
            red   = self.colorHexComponent(string: colorString, start: 2, length: 2)
            green = self.colorHexComponent(string: colorString, start: 4, length: 2)
            blue  = self.colorHexComponent(string: colorString, start: 6, length: 2)
        default:
            break
        }
        return self.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(nAlpha))
    }
    
    //颜色16进制
    class func colorHexComponent(string:String, start:Int, length:Int) -> Float {
        let startIndex = string.index(string.startIndex, offsetBy: start)
        let endIndex = string.index(string.startIndex, offsetBy: start + length - 1)
        let subString = string[startIndex...endIndex]
        let fullHex = length == 2 ? subString : String(format: "%@%@", arguments: [subString, subString])
        var hexComponent: UInt32 = UInt32()
        Scanner(string: fullHex).scanHexInt32(&hexComponent)
        return Float(hexComponent)/255.0
    }
}
