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
            VStack {
                Text("25")
                Text("Sunny")
            }
            .font(.largeTitle.bold())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image(.forestSunny)
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
    HomeView()
        .onAppear {
            print(Mock.currentWeather())
        }
}
