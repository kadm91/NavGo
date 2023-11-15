//
//  LocationsViewModel.swift
//  NavGo
//
//  Created by Kevin Martinez on 11/8/23.
//

import SwiftUI
import MapKit

@Observable
final class LocationsViewModel {
    
    //MARK: - Properties
    
    // All Loaded Locations
    private (set)  var locations: [Location]
    
    // Current Locaiton on map
    private (set) var mapLocation: Location   {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // Current regino on map // change to camera position in the new MapKit API for iOS 17
    
    var cameraPositon: MapCameraPosition!
    
    //var locationItem = MKMapItem()
    
    // this is for all MapKit api
    // private var mapRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    // Show list of location
    var showLocationsList: Bool = false
    
    // Show location detail via sheet
    
    var sheetLocaiton: Location?
    
    //MARK: - init
    
    init() {
        
        let location = LocationsDataService.locations
        
        self.locations = location
        
        self.mapLocation = location.first!
        
        self.updateMapRegion(location: location.first!)
        
    }
    
    
    //MARK: - Methods
    
    private func updateMapRegion(location: Location) {
        
        withAnimation(.easeInOut){
            
            // this contains examples of how to use the new MapKit Appi for hte camera possiton
            
            //MARK: - Using the .reginon
            
            let mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
            
            cameraPositon = MapCameraPosition.region(mapRegion)
            
            //MARK: - Ussing MapItem
            //            let locationPlaceMaker = MKPlacemark(coordinate: location.coordinates)
            //            let mapItem = MKMapItem(placemark: locationPlaceMaker)
            //            cameraPositon = MapCameraPosition.item(mapItem)
            //
            
            
            //MARK: - Creates a custom camera position
            
            //            cameraPositon = MapCameraPosition.camera(
            //                MapCamera(
            //                    centerCoordinate: location.coordinates,
            //                    distance:
            //                        location.name == "Eiffel Tower" ?  1400 : location.name ==  "Pantheon" ? 450 : location.name == "Trevi Fountain" ? 350 : 980,
            //                    heading: location.name == "Trevi Fountain" ? -50 : 0,
            //                    pitch: location.name == "Eiffel Tower" ? 30 : 65))
        }
    }
    
    
    //MARK: - Intentions
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    
    func showNextLocation(for location: Location) {
        
        
        withAnimation (.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        
        guard let currentIndex = locations.firstIndex(of: mapLocation) else {
            print("Could not find current index in location array! Should never happen")
            return
        }
        
        //check if current index is valid to avoid index out of range
        
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex) else {
            
            // Next index is no valid, Restart from zero
            
            guard let firstLocation = locations.first else {return}
            
            showNextLocation(for: firstLocation)
            
            return
        }
        
        // Next index is valid
        showNextLocation(for: locations[nextIndex])
        
    }
    
    
    
    //MARK: - end of LocationViewModel class
}
