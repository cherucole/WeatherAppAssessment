//
//  SystemRouter.swift
//  WeatherAppAssessment
//
//  Created by Cheruiyot Collins on 11/01/2025.
//

import Foundation
import UIKit

enum SystemRouter {
    static func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        Task { @MainActor in
            await UIApplication.shared.open(url)
        }
    }
}
