//
//  NavGoApp.swift
//  NavGo
//
//  Created by Kevin Martinez on 11/8/23.
//

import SwiftUI

@main
struct NavGoApp: App {
    
    @State var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environment(vm)
        }
    }
}
