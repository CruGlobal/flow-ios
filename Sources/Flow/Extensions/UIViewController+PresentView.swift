//
//  UIViewController+PresentView.swift
//  Flow
//
//  Created by Levi Eggert on 8/25/26.
//  Copyright © 2026 Cru. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func presentViewWithCompletion(view: UIViewController, animated: Bool, completion: (() -> Void)?) {
        
        if animated {
            present(view, animated: true, completion: completion)
        }
        else {
            present(view, animated: false, completion: nil)
            completion?()
        }
    }
    
    public static func presentViewIfNotPresented(
        viewController: UIViewController?,
        presentOn: UIViewController?,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        
        guard let viewController = viewController, let presentOn = presentOn else {
            completion?()
            return
        }
        
        guard viewController.presentingViewController == nil else {
            completion?()
            return
        }
        
        presentOn.presentViewWithCompletion(view: viewController, animated: animated, completion: completion)
    }
}
