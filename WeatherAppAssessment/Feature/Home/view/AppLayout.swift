//
//  AppLayout.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import SwiftUI

struct AppLayout: View {
    @State private var locationVM = LocationViewModel()

    var body: some View {
        Group {
            if let cordinates = locationVM.cordinates {
                HomeView(location: cordinates)
            } else {
                RequestLocationAccessView()
            }
        }
        .environment(locationVM)
    }
}

#Preview {
    AppLayout()
}
