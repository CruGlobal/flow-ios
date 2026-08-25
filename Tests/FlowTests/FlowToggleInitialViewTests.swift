//
//  FlowToggleInitialViewTests.swift
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
struct FlowToggleInitialViewTests: FlowTesting {
    
    @Test()
    func presenterIsTheToggableInitialViewControllerWhenTheFlowIsPresentedWithInitialViewControllerPresentType() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow(onPresentType: .presentInitialView)
                
        rootFlow.presentFlow(flow: flow, animated: false)
        
        let toggleViewController = UIViewController()
        
        flow.toggleInitialView(view: toggleViewController, animated: false)
        
        let flowPresenter = flow.presenter
                
        #expect(flowPresenter == toggleViewController)
    }
    
    @Test()
    func presenterIsTheToggableInitialViewControllerWhenTheFlowIsPresentedWithNavigationControllerPresentType() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow(onPresentType: .presentNavigationController)
                
        rootFlow.presentFlow(flow: flow, animated: false)
        
        let toggleViewController = UIViewController()
        
        flow.toggleInitialView(view: toggleViewController, animated: false)
        
        let flowPresenter = flow.presenter
                
        #expect(flowPresenter == toggleViewController)
    }
    
    @Test()
    func togglingTheInitialViewOnAPushFlowsDoesNothing() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
                
        rootFlow.pushFlow(flow: flow, animated: false)
        
        let toggleViewController = UIViewController()
        
        flow.toggleInitialView(view: toggleViewController, animated: false)
                        
        #expect(flow.presenter == flow.navigationController)
        
        #expect(flow.presenter.presentedViewController == nil)
    }
    
    @Test()
    func presentingTheInitialViewOnAPushFlowsDoesNothing() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow()
                
        rootFlow.pushFlow(flow: flow, animated: false)
                
        flow.presentInitialView(animated: false)
                        
        #expect(flow.presenter == flow.navigationController)
        
        #expect(flow.presenter.presentedViewController == nil)
    }
    
    @Test()
    func presentsToggableViewAsInitialView() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flow = getNewFlow(onPresentType: .presentInitialView)
                
        rootFlow.presentFlow(flow: flow, animated: false)
        
        #expect(flow.presenter == flow.initialView)
                
        let toggleViewController = UIViewController()
        
        flow.toggleInitialView(view: toggleViewController, animated: false)
                                
        #expect(flow.presenter == toggleViewController)
    }
    
    @Test()
    func presentsInitialViewWhenToggableViewIsPresented() {
        
    }
    
    @Test()
    func presentsInitialViewWhenNoViewIsPresented() {
        
    }
}
