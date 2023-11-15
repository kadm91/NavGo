//
//  LocationMapAnnotatioView.swift
//  NavGo
//
//  Created by Kevin Martinez on 11/12/23.
//

import SwiftUI

struct LocationMapAnnotatioView: View {
    
    //MARK: - Properties
    
    let accentColor = Color("AccentColor")
    
    //MARK: - Main Body
    
    var body: some View {
        VStack (spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(accentColor)
                .frame(width: 15, height: 15)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -5)
                //.padding(.bottom, 40)
        }
        //MARK: - end of Main Body
    }
    //MARK: - end of LocationMapAnnotationView struct
}

//MARK: - Preview
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        LocationMapAnnotatioView()
       }
    
    }
   
