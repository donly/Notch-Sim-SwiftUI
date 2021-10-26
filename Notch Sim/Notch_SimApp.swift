//
//  Notch_SimApp.swift
//  Notch Sim
//
//  Created by MBP_A1990 on 2021/10/20.
//

import SwiftUI

@main
struct Notch_SimApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    let screens = NSScreen.screens
    var statusBarItem: NSStatusItem!
    
    var windows = [NSWindow]()
    var windowControllers = [NSWindowController]()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let _ = NSApplication.shared.windows.map {
            $0.close()
        }
        
        setupWindow()
        setupStatusBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(resetWindow), name: NSApplication.didChangeScreenParametersNotification, object: nil)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    @objc func exitApp(_ sender: AnyObject?) {
        NSApplication.shared.terminate(nil)
    }
    
    private func setupWindow() {
        if screens.count == 0 {
            NSApplication.shared.terminate(self)
        }
        
        let menubarHeight = NSApplication.shared.mainMenu!.menuBarHeight
        
        for i in 0..<screens.count {
            let notchWindow = NSWindow()
            notchWindow.styleMask = .borderless
            notchWindow.backingType = .buffered
            notchWindow.backgroundColor = .clear
            notchWindow.hasShadow = false
            notchWindow.level = .screenSaver
            notchWindow.collectionBehavior =  [.canJoinAllSpaces, .fullScreenAuxiliary]
            notchWindow.contentViewController = NSHostingController(rootView: ContentView())
            
            let screenFrame = screens[i].frame
            notchWindow.setFrame(NSRect(x: screenFrame.origin.x, y: screenFrame.origin.y + screenFrame.size.height - menubarHeight, width: screenFrame.size.width, height: menubarHeight), display: true)
            
            let notchWindowController = NSWindowController()
            notchWindowController.contentViewController = notchWindow.contentViewController
            notchWindowController.window = notchWindow
            notchWindowController.showWindow(self)
            
            windows.append(notchWindow)
            windowControllers.append(notchWindowController)
        }
    }
    
    @objc func resetWindow() {
        for item in windows {
            item.close()
        }
        
        windows.removeAll()
        windowControllers.removeAll()
        
        setupWindow()
    }
    
    private func setupStatusBar() {
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "Icon")
        }
        
        // Add a menu and a menu item
        let menu = NSMenu()
        let exitMenuItem = NSMenuItem()
        exitMenuItem.title = "Exit"
        exitMenuItem.action = #selector(exitApp(_:))
        menu.addItem(exitMenuItem)
        
        //Set the menu
        self.statusBarItem.menu = menu
    }
}
