//
//  LocationDetailView.swift
//  NavGo
//
//  Created by Kevin Martinez on 11/13/23.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    //MARK: - properties
    
    @Environment(LocationsViewModel.self) var vm
    let location: Location
    
   //MARK: - Main body
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(
                        color: .black.opacity(0.3),
                        radius: 20,
                        x: 0,
                        y: 10)
                VStack (alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
        .onDisappear {
            vm.sheetLocaiton = nil
        }
        
        
        //MARK: - end of Main Body
    }
    
    //MARK: - end of LocationDetailView Struc
}


//MARK: - Preview
#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environment(LocationsViewModel())
}


//MARK: - extention

extension LocationDetailView {
    
    //MARK: - imageSection
    
    private var imageSection: some View {
        TabView {
            ForEach (location.imageNames, id: \.self) {
                
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width )
                    .clipped()
                
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    //MARK: - titleSection
    
    private var titleSection: some View {
        VStack (alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
            
        }
    }
    
    //MARK: - descriptionSection
    
    private var descriptionSection: some View {
        VStack (alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link) {
                
                Link(destination: url)  {
                    Label("Read More in Wikipedia",
                          systemImage: "safari.fill").underline()
                }
                .font(.headline)
                
                .tint(.blue)
                
            }
        }
    }
    
    //MARK: - mapLayer
    
     private var mapLayer: some View {
        
        ZStack {
            let position: MapCameraPosition = .region(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
            
            Map(position: .constant(position)) {
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotatioView()
                        .shadow(radius: 10)
                }
            }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(20)
        }
    }
    
    
    //MARK: - backButton
    
    private var backButton: some View {
        Button {
            vm.sheetLocaiton = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundStyle(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
    
    
    //MARK: - End of extention
}
