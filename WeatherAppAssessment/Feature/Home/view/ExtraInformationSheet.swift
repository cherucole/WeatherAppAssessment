//
//  ExtraInformationSheet.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 12/01/2025.
//

import SwiftUI

struct ExtraInformationSheet: View {
    let weather: CurrentWeather
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var mapSelection: CoordinateSelection?
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(weather.name)
                    .font(.title)
                Text(weather.country)
                    .font(.title3)
            }
            
            VStack(alignment: .leading) {
                Image(systemName: "mappin")
                LabeledContent("Longitude", value: weather.coordinates.longitude.formatted())
                LabeledContent("Latitude", value: weather.coordinates.latitude.formatted())
                
                Button("View on Map") {
                    mapSelection = .init(coordinates: weather.coordinates)
                }
            }
            .padding(.vertical)
            
            VStack(alignment: .leading) {
                Image(systemName: "sun.horizon")
                LabeledContent("Sunrise", value: weather.sunrise.formatted(.dateTime.hour().minute()))
                LabeledContent("Sunset", value: weather.sunset.formatted(.dateTime.hour().minute()))
            }
            .padding(.vertical)

            Text("Last updated: \(Date(), format: .reference(to: weather.date))")
        }
        .fontWeight(.medium)
        .presentationDetents([.medium])
        .presentationCornerRadius(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(20)
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
        .sheet(item: $mapSelection) { selection in
            MapView(location: selection.coordinates)
        }
    }
}

#Preview {
    ExtraInformationSheet(weather: .init(apiResponse: Mock.currentWeather()))
}
