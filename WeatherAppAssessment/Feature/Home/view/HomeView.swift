//
//  HomeView.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 10/01/2025.
//

import SwiftUI
import MapKit
//1. Use a formatter to show temperature correctly
// create a model that is purely for UI so we are protected from backend changes
// make backgrounds dynamic
// make colors dynamic
// make icons dynamic
// fetch data from here if needed based location changes

struct HomeView: View {
    let currentWeather: CurrentWeather
    let forecast: [ForecastItem]
    
    let temp = Measurement(value: 25, unit: UnitTemperature.celsius)
    
    var backgroundImage: ImageResource {
        switch currentWeather.description.lowercased() {
        case "rainy": .forestRainy
        case "cloudy": .forestCloudy
        default: .forestSunny
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                //                Text(temp.formatted(.measurement(width: .abbreviated, usage: .weather)))
                Text(currentWeather.temperature.toTemperatureString())
                Text(currentWeather.description)
            }
            .font(.largeTitle.bold())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image(backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: .infinity)
            }
            
            VStack {
                HStack {
                    VStack {
                        Text("19")
                        Text("min")
                    }
                    Spacer()
                    VStack {
                        Text("19")
                        Text("min")
                    }
                    Spacer()
                    VStack {
                        Text("19")
                        Text("min")
                    }
                }
                .padding(.horizontal)
                Rectangle()
                    .fill(.white)
                    .frame(height: 1)
                
                Grid(alignment: .top) {
                    GridRow {
                        Text("Tuesday")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(.clear)
                            .frame(maxWidth: .infinity)
                        
                        Text("19")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .ignoresSafeArea()
        .background(Color.sunny)
    }
}

#Preview {
    HomeView(
        currentWeather: CurrentWeather(apiResponse: Mock.currentWeather()),
        forecast: Mock.weatherForecast().list.map { ForecastItem(apiResponse: $0) }
    )
    .onAppear {
        print(Mock.currentWeather())
    }
}
