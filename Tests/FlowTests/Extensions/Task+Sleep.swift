//
//  Task+Sleep.swift
//  Flow
//
//  Created by Levi Eggert on 8/25/26.
//  Copyright © 2026 Cru. All rights reserved.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    static func sleepOneSecond() async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }
}
