//
//  Icon.swift
//  Material Icons
//
//  Created by Keaton Burleson on 9/17/20.
//  Copyright © 2020 Keaton Burleson. All rights reserved.
//

import Foundation

class Icon: CustomStringConvertible, CustomDebugStringConvertible {
    var type: IconType
    var imagePath: URL
    var name: String
    var rawName: String

    init(filePath: URL) {
        let fileName = String(filePath.absoluteString.split(separator: "/").last!)
        let fileNameData = fileName.split(separator: "_").filter { (subString) -> Bool in
            return String(subString) != "48dp.png"
        }

        let rawIconType = String(fileNameData.first!)

        self.type = IconType.init(rawValue: rawIconType)!
        self.imagePath = filePath

        self.rawName = fileNameData.filter({ (subString) -> Bool in
            subString != rawIconType
        }).joined(separator: "_").replacingOccurrences(of: "black", with: "")

        if (self.rawName.last == "_") {
            self.rawName.removeLast()
        }

        self.name = self.rawName.replacingOccurrences(of: "_", with: " ")
            .capitalized
            .replacingOccurrences(of: "Hdr", with: "HDR")
            .replacingOccurrences(of: "Wifi", with: "WiFi")
            .replacingOccurrences(of: "Adb", with: "ADB")
            .replacingOccurrences(of: "Amp", with: "AMP")
            .replacingOccurrences(of: "Ios", with: "iOS")
            .replacingOccurrences(of: "Atm", with: "ATM")
            .replacingOccurrences(of: "Vpn", with: "VPN")
            .replacingOccurrences(of: "Sip", with: "SIP")
            .replacingOccurrences(of: "Dvr", with: "DVR")
            .replacingOccurrences(of: "Hdmi", with: "HDMI")
            .replacingOccurrences(of: "Svideo", with: "S-Video")
            .replacingOccurrences(of: "Dns", with: "DNS")
            .replacingOccurrences(of: "Rtt", with: "RTT")
            .replacingOccurrences(of: "Rv", with: "RV")
            .replacingOccurrences(of: "Ac ", with: "AC ")
            .replacingOccurrences(of: "Mp", with: "MP")
            .replacingOccurrences(of: "Black", with: "")
    }

    var description: String {
        return "type: \(self.type), name: \(self.name)"
    }

    var debugDescription: String {
        return "type: \(self.type), name: \(self.name), rawName: \(self.rawName), imagePath: \(self.imagePath)"
    }
}
