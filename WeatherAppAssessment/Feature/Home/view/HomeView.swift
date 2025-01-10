//
//  HomeView.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 10/01/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image(.forestSunny)
                    .resizable()
//                    .ignoresSafeArea()
//                    .scaledToFill()
//                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea()
                VStack {
                    Text("25")
                    Text("Sunny")
                }
                .font(.largeTitle.bold())
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .ignoresSafeArea()
        .background(Color.sunny)
    }
}

#Preview {
    HomeView()
        .onAppear {
            print(Mock.currentWeather())
        }
}
