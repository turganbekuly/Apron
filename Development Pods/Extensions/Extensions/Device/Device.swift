//
//  Device.swift
//  Device
//
//  Created by Lucas Ortis on 30/10/2015.
//  Copyright © 2015 Ekhoo. All rights reserved.
//

import UIKit

// swiftlint:disable all
open class Device {
    static fileprivate func getVersionCode() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let versionCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
        
        return versionCode
    }
    
    static fileprivate func getVersion(code: String) -> Version {
        switch code {
            /*** iPhone ***/
        case "iPhone1,1":                                return .iPhone2G
        case "iPhone1,2":                                return .iPhone3G
        case "iPhone2,1":                                return .iPhone3GS
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return .iPhone4
        case "iPhone4,1", "iPhone4,2", "iPhone4,3":      return .iPhone4S
        case "iPhone5,1", "iPhone5,2":                   return .iPhone5
        case "iPhone5,3", "iPhone5,4":                   return .iPhone5C
        case "iPhone6,1", "iPhone6,2":                   return .iPhone5S
        case "iPhone7,2":                                return .iPhone6
        case "iPhone7,1":                                return .iPhone6Plus
        case "iPhone8,1":                                return .iPhone6S
        case "iPhone8,2":                                return .iPhone6SPlus
        case "iPhone8,3", "iPhone8,4":                   return .iPhoneSE
        case "iPhone9,1", "iPhone9,3":                   return .iPhone7
        case "iPhone9,2", "iPhone9,4":                   return .iPhone7Plus
        case "iPhone10,1", "iPhone10,4":                 return .iPhone8
        case "iPhone10,2", "iPhone10,5":                 return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":                 return .iPhoneX
        case "iPhone11,2":                               return .iPhoneXS
        case "iPhone11,4", "iPhone11,6":                 return .iPhoneXS_Max
        case "iPhone11,8":                               return .iPhoneXR
        case "iPhone12,1":                               return .iPhone11
        case "iPhone12,3":                               return .iPhone11Pro
        case "iPhone12,5":                               return .iPhone11Pro_Max
        case "iPhone12,8":                               return .iPhoneSE2
        case "iPhone13,1":                               return .iPhone12Mini
        case "iPhone13,2":                               return .iPhone12
        case "iPhone13,3":                               return .iPhone12Pro
        case "iPhone13,4":                               return .iPhone12Pro_Max
        case "iPhone14,6":                               return .iPhoneSE3
            
            /*** Simulator ***/
        case "i386", "x86_64":                           return .simulator
            
        default:                                         return .unknown
        }
    }
    
    static fileprivate func getType(code: String) -> Type {
        let versionCode = getVersionCode()
        
        if versionCode.contains("iPhone") {
            return .iPhone
        } else if versionCode.contains("iPad") {
            return .iPad
        } else if versionCode.contains("iPod") {
            return .iPod
        } else if versionCode == "i386" || versionCode == "x86_64" {
            return .simulator
        } else {
            return .unknown
        }
    }
    
    static public func version() -> Version {
        return getVersion(code: getVersionCode())
    }
    
    static public func size() -> Size {
        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(w, h)
        
        switch screenHeight {
        case 240, 480:
            return .screen3_5Inch
        case 568:
            return .screen4Inch
        case 667:
            return UIScreen.main.scale == 3.0 ? .screen5_5Inch : .screen4_7Inch
        case 736:
            return .screen5_5Inch
        case 812:
            switch version() {
            case .iPhone12Mini:
                return .screen5_4Inch
            default:
                return .screen5_8Inch
            }
        case 844...852:
            return .screen6_1Inch
        case 896:
            switch version() {
            case .iPhoneXS_Max, .iPhone11Pro_Max:
                return .screen6_5Inch
            default:
                return .screen6_1Inch
            }
        case 926:
            return .screen6_7Inch
        case 1024:
            return .screen9_7Inch
        case 1080:
            return .screen10_2Inch
        case 1112:
            return .screen10_5Inch
        case 1180:
            return .screen10_9Inch
        case 1194:
            return .screen11Inch
        case 1366:
            return .screen12_9Inch
        default:
            return .unknownSize
        }
    }
    
    static public func type() -> Type {
        return getType(code: getVersionCode())
    }
    
    static public func isRetina() -> Bool {
        return UIScreen.main.scale > 1.0
    }
    
    static public func isPad() -> Bool {
        return type() == .iPad
    }
    
    static public func isPhone() -> Bool {
        return type() == .iPhone
    }
    
    static public func isPod() -> Bool {
        return type() == .iPod
    }
    
    static public func isSmallIphones() -> Bool {
        let sizes: [Size] = [
            .unknownSize,
            /// iPhone 2G, 3G, 3GS, 4, 4s, iPod Touch 4th gen.
            .screen3_5Inch,
            /// iPhone 5, 5s, 5c, SE, iPod Touch 5-7th gen.
            .screen4Inch,
            /// iPhone 6, 6s, 7, 8, SE 2nd gen.
            .screen4_7Inch
        ]
        return sizes.contains(size())
    }
    
    static public func isSimulator() -> Bool {
        return type() == .simulator
    }
    
}
