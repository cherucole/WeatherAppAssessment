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
    
    @State private var presentFavorites = false
    @State private var presentExtraInfo = false
    
    @State private var mapSelection: CoordinateSelection?
    
    @State private var presentSearchForm = false
    @State private var cityName = ""
    
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
                VStack(spacing: 0) {
                    headerView(weather)
                    forecastView(weather: weather, forecast: forecast)
                }
                .foregroundStyle(.white)
                .ignoresSafeArea()
                .background(backgroundColor(weather.description))
                .overlay(alignment: .top) {
                    HStack {
                        Button {
                            presentSearchForm = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                        }
                        .foregroundStyle(.primary)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.circle)
                        
                        Spacer()
                        
                        FavoriteButton(currentWeather: weather)
                    }
                    .padding(.horizontal, 12)
                }
                .safeAreaInset(edge: .bottom) {
                    HStack {
                        Button("Favorites") {
                            presentFavorites = true
                        }
                        .buttonStyle(.plain)
                        Spacer()
                        Button {
                            mapSelection = .init(coordinates: weather.coordinates)
                        } label: {
                            Image(systemName: "map")
                                .imageScale(.large)
                        }
                    }
                    .foregroundStyle(.white)
                    .font(.title3.weight(.medium))
                    .padding()
                    .background(Material.ultraThin.opacity(0.4))
                }
                .sheet(isPresented: $presentExtraInfo) {
                    ExtraInformationSheet(weather: weather)
                }
                .alert("Enter City Name", isPresented: $presentSearchForm) {
                    TextField("city name", text: $cityName)
                        .textInputAutocapitalization(.none)
                    Button("View") {
                        guard !cityName.trimmed.isEmpty else { return }
                        Task {
                            await weatherVM.getWeather(city: cityName)
                            cityName = ""
                        }
                    }
                    Button("Cancel", role: .cancel) {
                        cityName = ""
                    }
                }
            case .error(let description):
                ContentUnavailableView("Something Went Wrong", systemImage: "exclamationmark.triangle", description: Text("\(description). Please try again"))
            }
        }
        .sheet(isPresented: $presentFavorites) {
            FavoritesList { selection in
                Task {
                    await weatherVM.getWeather(for: .init(latitude: selection.coordinates.latitude, longitude: selection.coordinates.longitude))
                }
            }
        }
        .sheet(item: $mapSelection) { selection in
            MapView(location: selection.coordinates)
        }
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
    
    func backgroundColor(_ condition: String) -> Color {
        switch condition.lowercased() {
        case "rain": .rainy
        case "clouds": .cloudy
        default: .sunny
        }
    }
    
    func backgroundImage(_ condition: String) -> ImageResource {
        switch condition.lowercased() {
        case "rain": .forestRainy
        case "clouds": .forestCloudy
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
            Text(weather.name)
                .font(.title3.weight(.medium))
            Text(weather.temperature.toTemperatureString())
                .font(.system(size: 56, weight: .medium))
            Text(weather.description.uppercased())
                .font(.system(size: 36, weight: .medium))
            
            Button("More Information") {
                presentExtraInfo = true
            }
            .font(.title3.weight(.medium))
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
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
        .environment(LocationViewModel())
}
