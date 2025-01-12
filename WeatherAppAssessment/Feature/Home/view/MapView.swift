//
//  MapView.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 12/01/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region: MKCoordinateRegion
    
    @Environment(\.dismiss) private var dismiss
    
    init(location: CLLocationCoordinate2D) {
        self._region = State(
            wrappedValue: .init(center: location, span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01))
        )
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
            .overlay(alignment: .topTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .rotationEffect(.degrees(45))
                }
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                .padding()
            }
    }
}

#Preview {
    MapView(location: .init(latitude: 0.3, longitude: 127.8))
}
