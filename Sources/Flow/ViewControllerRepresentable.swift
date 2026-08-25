//
//  ViewControllerRepresentable.swift
//  Flow
//
//  Created by Levi Eggert on 8/25/26.
//  Copyright © 2026 Cru. All rights reserved.
//

import SwiftUI
import UIKit

public struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
    private let viewController: UIViewController
    
    public init(viewController: UIViewController) {
        
        self.viewController = viewController
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}
