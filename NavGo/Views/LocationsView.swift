//
//  LocationsView.swift
//  NavGo
//
//  Created by Kevin Martinez on 11/8/23.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    //MARK: - Properties
    
    @Environment(LocationsViewModel.self) var vm
    
    let maxWidthForIpad: CGFloat = 600
    
    //MARK: - Main Body
    var body: some View {
        
        @Bindable var vm = vm
        
        ZStack {
            mapLayer
            VStack (spacing: 0) {
                header.padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocaiton, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
        
        //MARK: - end of Main Body
    }
    
    //MARK: - end of LocationView struct
}



//MARK: - Preview

#Preview {
    LocationsView()
        .environment(LocationsViewModel())
}

//MARK: - LocationView extention

extension LocationsView {
    
    //MARK: - header
    
    private var header: some View {
        VStack {
            Button(action:  vm.toggleLocationList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
// can try the new sf symbol  animation for when the list open and close
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }
            .foregroundStyle(.primary)
            
            if vm.showLocationsList {
                LocationsListView()
                   
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 15)
    }
    
    //MARK: - mapLayer
   
   @ViewBuilder private var mapLayer: some View {
        
        @Bindable var vm = vm
        Map(position: $vm.cameraPositon) {
        
            ForEach (vm.locations) { location in

                Annotation(location.name, coordinate: location.coordinates, anchor: .bottom) {
                   
                   LocationMapAnnotatioView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(for: location)
                        }
                }
            }
        }
        .mapControlVisibility(.hidden)
            .ignoresSafeArea()
    }
    
    //MARK: - locationPreviewStack
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                
                if vm.mapLocation == location {
                    LocationPreview(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
    
    //MARK: - end of extention
}
