//
//  LocationsListView.swift
//  NavGo
//
//  Created by Kevin Martinez on 11/9/23.
//

import SwiftUI

struct LocationsListView: View {
    
    //MARK: - Properties
    
    @Environment (LocationsViewModel.self) private var vm 
    
    //MARK: - Main Body
    
    var body: some View {
        List {
            ForEach (vm.locations) { location in
                
                Button {
                    vm.showNextLocation(for: location)
                } label: {
                    listRowView(for: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        
        //MARK: - end of Main Body
    }
    
    //MARK: - end of LocationListView struct
}

//MARK: - Preview

#Preview {
    LocationsListView()
        .environment(LocationsViewModel())
}

//MARK: - LocationListView extention

extension LocationsListView {
    
    //MARK: - listRowView
    
    private func listRowView (for location: Location) -> some View {
        HStack (spacing: 20) {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            
            VStack (alignment: .leading) {
                Text(location.name)
                Text(location.cityName)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
    
    
    //MARK: - end of extention 
}
