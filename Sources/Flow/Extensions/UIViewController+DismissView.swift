//
//  UIViewController+DismissView.swift
//  Flow
//
//  Created by Levi Eggert on 8/25/26.
//  Copyright © 2026 Cru. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func dismissWithCompletion(animated: Bool, completion: (() -> Void)?) {
        
        if animated {
            dismiss(animated: true, completion: completion)
        }
        else {
            dismiss(animated: false, completion: nil)
            completion?()
        }
    }
    
    public static func dismissViewIfPresented(
        viewController: UIViewController?,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        
        guard let viewController = viewController else {
            completion?()
            return
        }
        
        guard viewController.presentingViewController != nil else {
            completion?()
            return
        }
        
        viewController.dismissWithCompletion(
            animated: animated,
            completion: completion
        )
    }
}
