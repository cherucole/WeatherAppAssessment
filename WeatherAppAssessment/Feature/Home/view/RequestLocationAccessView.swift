//
//  RequestLocationAccessView.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import SwiftUI

struct RequestLocationAccessView: View {
    @Environment(LocationViewModel.self) private var locationVM
    @Environment(PermissionViewModel.self) private var permissionVM
    
    var body: some View {
        ContentUnavailableView {
            Label("Location Access Needed", systemImage: "mappin.circle")
        } description: {
            Text("Please allow your location to get weather updates relevant to you")
        } actions: {
            Group {
                if permissionVM.status == .denied {
                    Button {
                        SystemRouter.openSettings()
                    } label: {
                        Text("Open Settings")
                    }
                } else if permissionVM.status == .notDetermined {
                    Button {
                        locationVM.setupLocationServices(delegate: permissionVM)
                    } label: {
                        Text("Continue")
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        }
    }
}

#Preview {
    RequestLocationAccessView()
        .environment(LocationViewModel())
}
