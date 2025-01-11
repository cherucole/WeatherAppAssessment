//
//  HomeView.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 10/01/2025.
//

import SwiftUI
import MapKit

// add a favorites button on top right
// add a list icon on footer to open favourites
// add a view on map icon/button for current weather
// add a serach icon to allow searching cities

struct HomeView: View {
    @Environment(LocationViewModel.self) private var locationVM
    
    @State private var weatherVM = WeatherViewModel()
    @State var location: CLLocationCoordinate2D?
    
    var body: some View {
        VStack(spacing: 0) {
            switch weatherVM.status {
            case .idle:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loading:
                ProgressView("Getting your weather...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded(let weather, let forecast):
                headerView(weather)
                forecastView(weather: weather, forecast: forecast)
            case .error(let description):
                ContentUnavailableView("Something Went Wrong", systemImage: "exclamationmark.triangle", description: Text("\(description). Please try again"))
            }
        }
        .foregroundStyle(.white)
        .ignoresSafeArea()
        .background(Color.sunny)
        .task {
            self.location = locationVM.getUserLocation()
        }
        .onChange(of: location) { oldLocation, newLocation in
            guard let newLocation else { return }
            Task {
                await weatherVM.getWeather(for: newLocation)
            }
        }
    }
    
    func backgroundImage(_ condition: String) -> ImageResource {
        switch condition.lowercased() {
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
    
    @ViewBuilder
    func headerView(_ weather: CurrentWeather) -> some View {
        VStack(spacing: 8) {
            Text(weather.temperature.toTemperatureString())
                .font(.system(size: 56, weight: .medium))
            Text(weather.description.uppercased())
                .font(.system(size: 36, weight: .medium))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image(backgroundImage(weather.description))
                .resizable()
                .scaledToFill()
                .frame(maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    func forecastView(weather: CurrentWeather, forecast: [ForecastItem]) -> some View {
        VStack {
            HStack {
                VStack {
                    Text(weather.minTemp.toTemperatureString())
                    Text("min")
                        .fontWeight(.light)
                }
                Spacer()
                VStack {
                    Text(weather.temperature.toTemperatureString())
                    Text("current")
                        .fontWeight(.light)
                }
                Spacer()
                VStack {
                    Text(weather.maxTemp.toTemperatureString())
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
}

#Preview {
    HomeView(location: .init(latitude: 0, longitude: 36))
}
