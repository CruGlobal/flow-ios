//
//  TestFlow.swift
//  Flow
//
//  Created by Levi Eggert on 8/25/26.
//  Copyright © 2026 Cru. All rights reserved.
//

import Foundation
@testable import Flow
import UIKit

class TestFlow: Flow {
    
    private(set) var onAddedToParentCount: Int = 0
    private(set) var onPushCount: Int = 0
    private(set) var onPopCount: Int = 0
    private(set) var onPresentedCount: Int = 0
    private(set) var onDismissedCount: Int = 0
    
    init() {
        
        super.init(initialView: UIViewController(), stepEmitter: FlowStepEmitter())
    }
    
    override func onAddedToParent() {
        
        onAddedToParentCount += 1
    }
    
    override func onPushed(animated: Bool) {
        
        onPushCount += 1
    }
    
    override func onPopped(animated: Bool) {
        
        onPopCount += 1
    }
    
    override func onPresented(animated: Bool) {
        
        onPresentedCount += 1
    }
    
    override func onDismissed(animated: Bool) {
        
        onDismissedCount += 1
    }
}
