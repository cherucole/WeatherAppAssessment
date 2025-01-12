//
//  View+Ext.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 12/01/2025.
//

import SwiftUI

extension View {
    func entireFramePressable() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
    }
}
