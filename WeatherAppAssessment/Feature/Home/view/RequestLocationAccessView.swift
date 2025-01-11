//
//  RequestLocationAccessView.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import SwiftUI

struct RequestLocationAccessView: View {
    @Environment(LocationViewModel.self) private var locationVM
    
    var body: some View {
        ContentUnavailableView {
            Label("Location Access Needed", systemImage: "mappin.circle")
        } description: {
            Text("Please allow your location to get weather updates relevant to you")
        } actions: {
            Group {
                if locationVM.presentLocationDeniedWarning {
                    Button {
                        SystemRouter.openSettings()
                    } label: {
                        Text("Open Settings")
                    }
                } else {
                    Button {
                        locationVM.checkIfLocationServicesEnabled()
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
