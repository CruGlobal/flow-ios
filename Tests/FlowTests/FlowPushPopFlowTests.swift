//
//  FlowPushPopFlowTests.swift
//  Flow
//
//  Created by Levi Eggert on 8/25/26.
//  Copyright © 2026 Cru. All rights reserved.
//

import Foundation
import Testing
import UIKit
@testable import Flow

@MainActor
struct FlowPushPopFlowTests: FlowTesting {
    
    @Test()
    func pushingAFlowSharesNavigationControllerWithParent() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
        
        rootFlow.pushFlow(flow: flow, animated: false)
        
        #expect(flow.navigationController == rootFlow.navigationController)
    }
    
    @Test()
    func pushingAFlowPlacesTheFlowsInitialViewControllerInTheNavigationStack() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
        
        rootFlow.pushFlow(flow: flow, animated: false)
        
        #expect(rootFlow.navigationController.viewControllers.last == flow.initialView)
    }
    
    @Test()
    func pushedFlowsNavigationControllerIsResetToOriginalWhenRemovedFromParent() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
        
        let originalNavigationController: UINavigationController = flow.navigationController
        
        rootFlow.pushFlow(flow: flow, animated: false)
        
        #expect(flow.navigationController == rootFlow.navigationController)
        #expect(flow.navigationController != originalNavigationController)
        
        rootFlow.popFlow(animated: false)
        
        #expect(flow.navigationController == originalNavigationController)
    }
    
    @Test()
    func pushedFlowsNavigationControllerIsResetToOriginalWhenPopped() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
        
        let originalNavigationController: UINavigationController = flow.navigationController
        
        rootFlow.pushFlow(flow: flow, animated: false)
        
        #expect(flow.navigationController == rootFlow.navigationController)
        #expect(flow.navigationController != originalNavigationController)
        
        flow.parent?.popFlow(animated: false)
        
        #expect(flow.navigationController == originalNavigationController)
    }
    
    @Test()
    func cannotPushAFlowOntoItself() {
        
        let flow = getNewFlow()
        
        flow.pushFlow(flow: flow, animated: false)
        
        #expect(flow.parent == nil)
    }
    
    @Test()
    func cannotPushARootFlowOntoAFlow() {
        
        let flow = getNewFlow()
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        flow.pushFlow(flow: rootFlow, animated: false)
        
        #expect(rootFlow.parent == nil)
    }
    
    @Test()
    func cannotPushAFlowThatAlreadyHasAParent() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
        
        let flow2 = getNewFlow()
        
        rootFlow.pushFlow(flow: flow2, animated: false)
        
        #expect(flow2.parent == rootFlow)
        
        flow.pushFlow(flow: flow2, animated: false)
        
        #expect(flow2.parent == rootFlow)
    }
    
    @Test()
    func poppingAPushedFlowIsRemovedFromTheNavigationStack() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
        
        rootFlow.pushFlow(flow: flow, animated: false)
        
        flow.parent?.popFlow()
        
        for viewController in flow.navigationController.viewControllers {
            #expect(rootFlow.navigationController.viewControllers.contains(viewController) == false)
        }
    }
    
    @Test()
    func canPopToASpecificViewControllerInTheStackWhenPoppingAFlow() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flowAInitialView = UIViewController()
        let flowA = getNewFlow(initialView: flowAInitialView)
        
        let flowBInitialView = UIViewController()
        let flowB = getNewFlow(initialView: flowBInitialView)
        
        rootFlow.pushFlow(flow: flowA, animated: false)
        
        #expect(flowA.navigationController.viewControllers.count == 1)
        
        flowA.pushView(view: UIViewController(), animated: false)
        flowA.pushView(view: UIViewController(), animated: false)
        
        #expect(flowA.navigationController.viewControllers.count == 3)
        
        flowA.pushFlow(flow: flowB, animated: false)
        
        #expect(flowA.navigationController.viewControllers.count == 4)
        #expect(flowA.pushedFlows.count == 1)
        
        flowA.popFlow(animated: false, popToViewController: flowAInitialView)
        
        #expect(flowA.navigationController.viewControllers.count == 1)
        #expect(flowA.pushedFlows.count == 0)
    }
    
    @Test()
    func presenterIsTheNavigationControllerWhenTheFlowIsPushed() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
        
        rootFlow.pushFlow(flow: flow, animated: false)
        
        #expect(flow.presenter == flow.navigationController)
    }
    
    @Test()
    func theFlowsInitialViewForPresentationIsNilWhenTheFlowIsPushed() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
        
        rootFlow.pushFlow(flow: flow, animated: false)
        
        #expect(flow.initialViewForPresentedFlow == nil)
    }
    
    // MARK: - Push Flow
    
    @Test()
    func cannotPushARootFlow() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
        
        flow.pushFlow(flow: rootFlow, animated: false)
        
        #expect(flow.pushedFlows.isEmpty == true)
    }
    
    @Test()
    func cannotPushFlowOntoItself() {
                
        let flow = getNewFlow()
        
        flow.pushFlow(flow: flow, animated: false)
        
        #expect(flow.pushedFlows.isEmpty == true)
    }
    
    @Test()
    func cannoPushAFlowThatIsAPushedFlowOfAnotherFlowUntilFlowIsPopped() {
        
        let flowA = getNewFlow()
        let flowB = getNewFlow()
        let flowC = getNewFlow()
        
        flowA.pushFlow(flow: flowB, animated: false)
        
        #expect(flowA.pushedFlows.contains(flowB))
        
        flowC.pushFlow(flow: flowB, animated: false)
        
        #expect(flowC.pushedFlows.isEmpty)
        
        flowA.popFlow(animated: false)
        
        flowC.pushFlow(flow: flowB, animated: false)
        
        #expect(flowC.pushedFlows.contains(flowB))
    }
    
    @Test()
    func cannotPushFlowThatIsAlreadyPresented() {
        
        let flowA = getNewFlow()
        let flowB = getNewFlow()
        let flowC = getNewFlow()
        
        flowA.presentFlow(flow: flowB, animated: false)
        
        #expect(flowA.presentedFlow == flowB)
        
        flowC.pushFlow(flow: flowB, animated: false)
           
        #expect(flowC.pushedFlows.isEmpty == true)
    }
    
    @Test()
    func canPushFlowOnRootFlow() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
        
        rootFlow.pushFlow(flow: flow, animated: false)
        
        #expect(rootFlow.pushedFlows.contains(flow))
    }
    
    @Test()
    func canPushFlowOnAnotherFlow() {
        
        let flowA = getNewFlow()
        
        let flowB = getNewFlow()
        
        flowA.pushFlow(flow: flowB, animated: false)
        
        #expect(flowA.pushedFlows.contains(flowB))
    }
    
    @Test()
    func pushingAFlowTheParentIsSet() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flowA = getNewFlow()
        
        let flowB = getNewFlow()
        
        rootFlow.pushFlow(flow: flowA, animated: false)
        
        flowA.pushFlow(flow: flowB, animated: false)
                
        #expect(rootFlow.parent == nil)
        
        #expect(flowA.parent == rootFlow)
        
        #expect(flowB.parent == flowA)
    }
    
    @Test()
    func pushingAFlowOnPushIsTriggered() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flowA = TestFlow()
        
        #expect(flowA.onPushCount == 0)
        
        rootFlow.pushFlow(flow: flowA)
        
        #expect(flowA.onPushCount == 1)
    }
    
    // MARK: - Pop Flow
    
    @Test()
    func cannotPopAFlowThatIsntPushed() {
        
        let flowA = getNewFlow()
                
        flowA.popFlow(animated: false)
        
        #expect(flowA.pushedFlows.isEmpty == true)
    }
    
    @Test()
    func canPopAPushedFlow() {
        
        let flowA = getNewFlow()
        
        let flowB = getNewFlow()
        
        flowA.pushFlow(flow: flowB, animated: false)
                
        #expect(flowA.pushedFlows.contains(flowB))
        
        #expect(flowB.parent == flowA)
        
        flowA.popFlow(animated: false)
        
        #expect(flowA.pushedFlows.isEmpty == true)
        
        #expect(flowB.parent == nil)
    }
}
