//
//  FlowPresentDismissViewTests.swift
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
struct FlowPresentDismissViewTests: FlowTesting {
    
    @Test()
    func whenAFlowIsPushedThePresenterShouldBeTheNavigationController() {
     
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flowA = getNewFlow()
        
        rootFlow.pushFlow(flow: flowA, animated: false)
        
        #expect(flowA.presenter == flowA.navigationController)
    }
    
    @Test()
    func whenAFlowIsPresentedWithARootNavigationControllerTheRootNavigationControllerShouldBeThePresenter() {
     
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flowA = getNewFlow(initialView: UIViewController(), onPresentType: .presentNavigationController)
        
        rootFlow.presentFlow(flow: flowA, animated: false)
        
        #expect(flowA.presenter == flowA.navigationController)
    }
    
    @Test()
    func flowIsNotPresentingAViewAfterDismissingTheView() async throws {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flowA = getNewFlow()
        
        rootFlow.pushFlow(flow: flowA, animated: false)
        
        #expect(flowA.isPresentingView == false)
        
        let viewToPresent = UIViewController()
        
        flowA.presentView(view: viewToPresent, animated: false, completion: nil, shouldTogglePresentedView: false)
        
        #expect(flowA.presentedView != nil)
        #expect(flowA.isPresentingView == true)
        #expect(flowA.presenter.presentedViewController != nil)
        
        flowA.dismissView(animated: false)
        
        #expect(flowA.presentedView == nil)
        #expect(flowA.isPresentingView == false)
        
        // I noticed when checking the presentedViewController immediately after dismissing the value is still null even when animated is false.
        // Sleeping for 1 second is a fix around this. ~Levi
        try await Task.sleepOneSecond()
        #expect(flowA.presenter.presentedViewController == nil)
    }
    
    @Test()
    func cannotPresentAViewWhilePresentingAnotherView() {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flowA = getNewFlow()
        
        rootFlow.pushFlow(flow: flowA, animated: false)
        
        #expect(flowA.isPresentingView == false)
        
        let firstViewToPresent = UIViewController()
        let secondViewToPresent = UIViewController()
        
        flowA.presentView(view: firstViewToPresent, animated: true, completion: nil, shouldTogglePresentedView: true)
        
        flowA.presentView(view: secondViewToPresent, animated: true, completion: nil, shouldTogglePresentedView: true)
                
        #expect(flowA.presentedView == firstViewToPresent)
    }
    
    @Test()
    func cannotPresentAViewWhenAnotherViewIsAlreadyPresentedAndTogglePresentedIsFalse() async throws {
        
        let rootFlow = getNewRootFlow()
        
        _ = getWindowAndAttachRootForPresentation(root: rootFlow.navigationController)
        
        let flowA = getNewFlow()
        
        rootFlow.pushFlow(flow: flowA, animated: false)
        
        #expect(flowA.isPresentingView == false)
        
        let firstViewToPresent = UIViewController()
        let secondViewToPresent = UIViewController()
        
        flowA.presentView(view: firstViewToPresent, animated: false, completion: nil, shouldTogglePresentedView: true)
        
        try await Task.sleepOneSecond()
        
        flowA.presentView(view: secondViewToPresent, animated: false, completion: nil, shouldTogglePresentedView: false)
        
        #expect(flowA.presentedView == firstViewToPresent)
    }
}
