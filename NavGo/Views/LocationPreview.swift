//
//  LocationPreview.swift
//  NavGo
//
//  Created by Kevin Martinez on 11/10/23.
//

import SwiftUI

struct LocationPreview: View {
    
    //MARK: - properties
    
    @Environment(LocationsViewModel.self) private var vm
    let location: Location
    
    //MARK: - Main Body
    var body: some View {
        HStack (alignment: .bottom) {
            VStack(alignment: .leading,spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack (spacing: 8) {
                learnMoreButton
                nextLocationButton
            }
        }
        .padding(20)
        .background(
        RoundedRectangle(cornerRadius: 10)
            .fill(.ultraThinMaterial)
            .offset(y: 65)
        )
        .cornerRadius(10)
        
        //MARK: - end of Main Body
    }
    
    //MARK: - end of LocationPreview struct
}

//MARK: - Preview

#Preview {
    ZStack {
        Color.green.ignoresSafeArea()
        LocationPreview(location: LocationsDataService.locations.first!)
            .environment(LocationsViewModel())
            .padding()
    }
}

//MARK: - View Extention

extension LocationPreview {
    
    //MARK: -  imageSection
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(.white)
        .cornerRadius(10)
    }
    
    //MARK: - titleSection
    
    private var titleSection: some View {
        VStack (alignment: .leading, spacing: 4) {
            
            Text(location.name)
                .font(.title2)
                .bold()
            
            Text(location.cityName)
                .font(.subheadline)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: - learnMoreButton
    
    private var learnMoreButton: some View {
        Button {
            
            vm.sheetLocaiton = location
            
        } label: {
            Label("Learn More", systemImage: "info.circle")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    //MARK: - nextLocationButton
    
    private var nextLocationButton: some View {
        Button {
            Task { @MainActor in
                vm.nextButtonPressed()
            }
           
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
    //MARK: - end of extention
}


