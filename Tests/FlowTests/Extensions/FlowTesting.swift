//
//  FlowTesting.swift
//  Flow
//
//  Created by Levi Eggert on 8/25/26.
//  Copyright © 2026 Cru. All rights reserved.
//

import Foundation
import UIKit
@testable import Flow

@MainActor
protocol FlowTesting {
    
}

extension FlowTesting {
    
    func getWindowAndAttachRootForPresentation(root: UIViewController) -> UIWindow {
        
        let window = UIWindow()
        window.rootViewController = root
        window.makeKeyAndVisible()
        return window
    }
    
    func getNewRootFlow(
        initialView: UIViewController? = nil,
        stepEmitter: FlowStepEmitter = FlowStepEmitter(),
        navigationController: UINavigationController = UINavigationController()
    ) -> RootFlow {
    
        return RootFlow(
            initialView: initialView,
            stepEmitter: stepEmitter,
            navigationController: navigationController
        )
    }
    
    func getNewFlow(
        initialView: UIViewController = UIViewController(),
        onPresentType: Flow.OnPresentType = .presentNavigationController
    ) -> Flow {
        
        return Flow(
            initialView: initialView,
            stepEmitter: FlowStepEmitter(),
            onPresentType: onPresentType
        )
    }
    
    func getNewTestFlow() -> TestFlow {
        return TestFlow()
    }
}
