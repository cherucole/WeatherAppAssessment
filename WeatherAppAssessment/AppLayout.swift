//
//  AppLayout.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import SwiftUI

struct AppLayout: View {
    @State private var permissionVM = PermissionViewModel.shared
    @State private var locationVM = LocationViewModel()
    
    var body: some View {
        Group {
            switch permissionVM.status {
            case .authorizedWhenInUse, .authorized, .authorizedAlways:
                HomeView()
            case .notDetermined, .restricted, .denied:
                RequestLocationAccessView()
            @unknown default:
                Text("Unhandled Permission Status")
            }
        }
        .environment(locationVM)
        .environment(permissionVM)
        .task {
            locationVM.setupLocationServices(delegate: permissionVM)
        }
    }
}

#Preview {
    AppLayout()
}
