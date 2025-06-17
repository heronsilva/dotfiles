// v1
// import Foundation
// import AppKit
//
// // Get file path from arguments
// guard CommandLine.arguments.count > 1 else {
//     print("Usage: FileClipboard /full/path/to/file")
//     exit(1)
// }
//
// let path = CommandLine.arguments[1]
// let fileURL = URL(fileURLWithPath: path)
//
// guard FileManager.default.fileExists(atPath: fileURL.path) else {
//     print("File does not exist at path: \(fileURL.path)")
//     exit(1)
// }
//
// let pasteboard = NSPasteboard.general
// pasteboard.clearContents()
//
// // Add the file to the clipboard as a file URL
// let success = pasteboard.writeObjects([fileURL as NSPasteboardWriting])
//
// if success {
//     print("✅ File copied to clipboard: \(fileURL.lastPathComponent)")
// } else {
//     print("❌ Failed to copy file to clipboard.")
//     exit(1)
// }

//

// fileclip.swift
// Enhanced CLI tool to copy files to macOS clipboard with thumbnails, multiple file support, and CLI polish

import Foundation
import AppKit

// MARK: - Constants
let args = CommandLine.arguments.dropFirst()
let fileManager = FileManager.default
let pasteboard = NSPasteboard.general

// MARK: - Helper Functions
func printHelp() {
    print("""
    Usage: fileclip [file1] [file2] ...

    Copies file(s) to the macOS clipboard so you can paste into Finder, apps, etc.
    Supports multiple files, relative paths, and image thumbnail previews.
    """)
}

func resolvePath(_ path: String) -> URL {
    if path.hasPrefix("/") {
        return URL(fileURLWithPath: path)
    } else {
        let cwd = fileManager.currentDirectoryPath
        return URL(fileURLWithPath: path, relativeTo: URL(fileURLWithPath: cwd))
    }
}

func verifyFileExists(_ url: URL) -> Bool {
    return fileManager.fileExists(atPath: url.path)
}

func generateThumbnail(for imageURL: URL, maxSize: CGFloat = 256) -> NSImage? {
    guard let image = NSImage(contentsOf: imageURL) else { return nil }
    let thumbnail = NSImage(size: NSSize(width: maxSize, height: maxSize))
    thumbnail.lockFocus()
    image.draw(in: NSRect(x: 0, y: 0, width: maxSize, height: maxSize), from: NSZeroRect, operation: .copy, fraction: 1.0)
    thumbnail.unlockFocus()
    return thumbnail
}

// MARK: - Main Logic
if args.isEmpty || args.contains("--help") || args.contains("-h") {
    printHelp()
    exit(0)
}

let resolvedURLs = args.map(resolvePath)

for url in resolvedURLs {
    if !verifyFileExists(url) {
        print("❌ File not found: \(url.path)")
        exit(1)
    }
}

// Write both file URLs and thumbnails if applicable
pasteboard.clearContents()

var clipboardItems: [NSPasteboardItem] = []

for url in resolvedURLs {
    let item = NSPasteboardItem()
    item.setString(url.absoluteString, forType: .fileURL)

    if url.pathExtension.lowercased() == "png" || url.pathExtension.lowercased() == "jpg" || url.pathExtension.lowercased() == "jpeg" {
        if let thumb = generateThumbnail(for: url),
           let tiff = thumb.tiffRepresentation {
            item.setData(tiff, forType: .tiff)
        }
    }
    clipboardItems.append(item)
}

let success = pasteboard.writeObjects(clipboardItems)

if success {
    print("✅ Copied \(resolvedURLs.count) file(s) to clipboard.")
    // Optional: Verification
    if let items = pasteboard.pasteboardItems {
        for item in items {
            if let fileStr = item.string(forType: .fileURL) {
                print("🔍 Verified: \(fileStr)")
            }
        }
    }
} else {
    print("❌ Failed to copy files to clipboard.")
    exit(1)
}

