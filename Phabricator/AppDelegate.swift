//
//  AppDelegate.swift
//  Phabricator
//
//  Created by Feifan Zhou on 2/18/15.
//  Copyright (c) 2015 Feifan Zhou. All rights reserved.
//

import Cocoa
import WebKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	@IBOutlet weak var webView: WebView!

	@IBOutlet weak var sidebar: NSView!
	@IBOutlet weak var addURL: NSWindow!
	@IBOutlet weak var newURLField: NSTextField!

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		// Insert code here to initialize your application
		renderURLButtons()
	}

	@IBAction func triggerAddURL(sender: AnyObject) {
		addURL.makeKeyAndOrderFront(sender)
	}
	@IBAction func addNewURL(sender: AnyObject) {
		var newURL = newURLField.stringValue
		var currentlySaved: AnyObject? = Defaults.get("URLs")
		if currentlySaved == nil {
			currentlySaved = []
		}
		var urls = (currentlySaved as [String])
		urls.append(newURL)
		Defaults.set(urls, key: "URLs")
		Defaults.sync()
		renderURLButtons()
		addURL.close()
	}
	
	func goto(sender: NSButton) {
		var tag = sender.tag
		var currentlySaved: AnyObject? = Defaults.get("URLs")
		if currentlySaved == nil {
			currentlySaved = []
		}
		var urls = (currentlySaved as [String])
		var clickedURL = urls[tag]
		webView.mainFrame.loadRequest(NSURLRequest(URL: NSURL(string: clickedURL)!))
	}
	
	func renderURLButtons() {
		var currentlySaved: AnyObject? = Defaults.get("URLs")
		if currentlySaved == nil {
			currentlySaved = []
		}
		var urls = (currentlySaved as [String])
		var buttons: [NSButton] = []
		buttons.reserveCapacity(urls.count)
		var index = 1
		var height = 56
		var baseOffset = 24
		for i in 0..<urls.count {
			var heightOffset = height * index + baseOffset
			var yVal = window.frame.height - CGFloat(heightOffset)
			var button: NSButton = NSButton(frame: CGRectMake(6, yVal, 52, 52))
			button.bezelStyle = NSBezelStyle.RegularSquareBezelStyle
			button.font = NSFont.boldSystemFontOfSize(17.0)
			button.title = "\(index)"
			button.tag = i
			button.target = self
			button.action = "goto:"
			sidebar.addSubview(button)
			index++
		}
	}
	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}


}

