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
    
    func conditionSymbol(_ condition: String) -> ImageResource {
        switch condition.lowercased() {
        case "rain": .rain
        case "clear": .clear
        case "partlysunny": .partlysunny
        default: .clear
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 8) {
                //                Text(temp.formatted(.measurement(width: .abbreviated, usage: .weather)))
                Text(currentWeather.temperature.toTemperatureString())
                    .font(.system(size: 56, weight: .medium))
                Text(currentWeather.description.uppercased())
                    .font(.system(size: 36, weight: .medium))
            }
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
                        Text(currentWeather.minTemp.toTemperatureString())
                        Text("min")
                            .fontWeight(.light)
                    }
                    Spacer()
                    VStack {
                        Text(currentWeather.temperature.toTemperatureString())
                        Text("current")
                            .fontWeight(.light)
                    }
                    Spacer()
                    VStack {
                        Text(currentWeather.maxTemp.toTemperatureString())
                        Text("max")
                            .fontWeight(.light)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                Rectangle()
                    .fill(.white)
                    .frame(height: 1)
                
                Grid(alignment: .top, verticalSpacing: 24) {
                    ForEach(forecast) { forecast in
                        GridRow {
                            Text(forecast.date.formatted(.dateTime.weekday(.wide)))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(conditionSymbol(forecast.condition))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28)
                                .frame(maxWidth: .infinity)
                            
                            Text(forecast.temperature.toTemperatureString())
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                .font(.title3)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .foregroundStyle(.white)
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
