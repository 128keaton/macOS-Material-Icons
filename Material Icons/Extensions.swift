//
//  Extensions.swift
//  Material Icons
//
//  Created by Keaton Burleson on 9/17/20.
//  Copyright © 2020 Keaton Burleson. All rights reserved.
//

import Foundation
import AppKit

extension NSImage {
    func tint(color: NSColor) -> NSImage {
        let image = self.copy() as! NSImage
        image.lockFocus()

        color.set()

        let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
        imageRect.fill(using: .sourceAtop)

        image.unlockFocus()

        return image
    }
}
