//
//  ViewController.swift
//  Material Icons
//
//  Created by Keaton Burleson on 9/17/20.
//  Copyright © 2020 Keaton Burleson. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var searchField: NSSearchField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var copyButton: NSButton!
    @IBOutlet weak var iconNameLabel: NSTextField!
    @IBOutlet weak var iconRawNameLabel: NSTextField!
    @IBOutlet weak var iconPreviewImageView: NSImageView!

    var filledIcons: [Icon] = []
    var outlinedIcons: [Icon] = []
    var roundedIcons: [Icon] = []
    var sharpIcons: [Icon] = []
    var twoToneIcons: [Icon] = []
    var currentIcons: [Icon] = []

    var selectedIcon: Icon? {
        didSet {
            self.updateView()
        }
    }

    var iconMode: IconType = .filled
    var inDarkMode: Bool {
        let mode = UserDefaults.standard.string(forKey: "AppleInterfaceStyle")
        return mode == "Dark"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.target = self
        self.tableView.action = #selector(tableViewDidClick)

        self.configureView()
        self.populateIcons()
        self.updateTableView()
    }
    
    
    @IBAction func copyToClipboard(sender: NSButton) {
        if let currentIcon = self.selectedIcon {
            let pasteboard = NSPasteboard.general
            
            pasteboard.clearContents()
            pasteboard.setString(currentIcon.rawName, forType: .string)
        }
    }

    @IBAction func switchMode(sender: NSSegmentedControl) {
        switch sender.selectedSegment {
        case 1:
            self.iconMode = .outlined
            break
        case 2:
            self.iconMode = .rounded
            break
        case 3:
            self.iconMode = .twoTone
            break
        case 4:
            self.iconMode = .sharp
            break
        default:
            self.iconMode = .filled
            break
        }

        self.updateTableView()
    }

    func populateIcons() {
        var icons: [Icon] = []
        let docsPath = Bundle.main.resourcePath! + "/Icons"
        let url = URL(fileURLWithPath: docsPath)


        if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
            for case let fileURL as URL in enumerator {
                do {
                    let fileAttributes = try fileURL.resourceValues(forKeys: [.isRegularFileKey])
                    if fileAttributes.isRegularFile! {
                        icons.append(Icon(filePath: fileURL))
                    }
                } catch { print(error, fileURL) }
            }
        }

        self.filledIcons = icons.filter { $0.type == .filled }.sorted { $0.name < $1.name }
        self.outlinedIcons = icons.filter { $0.type == .outlined }.sorted { $0.name < $1.name }
        self.roundedIcons = icons.filter { $0.type == .rounded }.sorted { $0.name < $1.name }
        self.sharpIcons = icons.filter { $0.type == .sharp }.sorted { $0.name < $1.name }
        self.twoToneIcons = icons.filter { $0.type == .twoTone }.sorted { $0.name < $1.name }
    }

    private func configureView() {
        self.copyButton.isHidden = true
        self.iconRawNameLabel.isHidden = true
        self.iconPreviewImageView.isHidden = true
    }

    private func updateView() {
        if let currentIcon = self.selectedIcon {
            self.iconNameLabel.stringValue = currentIcon.name
            self.iconRawNameLabel.stringValue = currentIcon.rawName
            self.iconPreviewImageView.image = self.inDarkMode ? NSImage(contentsOf: currentIcon.imagePath)?.tint(color: NSColor.white) : NSImage(contentsOf: currentIcon.imagePath)

            self.copyButton.isHidden = false
            self.iconRawNameLabel.isHidden = false
            self.iconPreviewImageView.isHidden = false
        } else {
            self.configureView()
        }
    }

    private func updateTableView() {
        self.currentIcons = self.getIconArray()
        self.tableView.reloadData()
    }

    private func getIconArray() -> [Icon] {
        switch self.iconMode {
        case .filled:
            return self.filledIcons
        case .outlined:
            return self.outlinedIcons
        case .rounded:
            return self.roundedIcons
        case .sharp:
            return self.sharpIcons
        case .twoTone:
            return self.twoToneIcons
        }
    }

    @objc func tableViewDidClick() {
        let row = tableView.clickedRow

        if row == -1 {
            self.selectedIcon = nil
            return
        } else if row != -1 {
            self.selectedIcon = self.currentIcons[row]
            return
        }
    }

    func controlTextDidChange(_ obj: Notification) {
        if (obj.object! as AnyObject === self.searchField) {
            let searchString = self.searchField.stringValue


            if (searchString.isEmpty) {
                self.currentIcons = self.getIconArray()
            } else {
                self.currentIcons = self.getIconArray().filter {
                    return $0.name.lowercased().contains(searchString.lowercased()) || $0.rawName.lowercased().contains(searchString.lowercased())
                }

            }

            self.tableView.reloadData()
        }
    }
}


extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.currentIcons.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "IconCell"), owner: nil) as? NSTableCellView {
            let icon = self.currentIcons[row]

            cell.textField?.stringValue = icon.name
            cell.imageView?.image = self.inDarkMode ? NSImage(contentsOf: icon.imagePath)?.tint(color: NSColor.white) : NSImage(contentsOf: icon.imagePath)

            return cell
        }

        return nil
    }

}
