//
//  TaskExtensions.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import Foundation

func withMinimumDuration(
    seconds: Double,
    operation: @escaping () async -> Void
) async {
    await withTaskGroup(of: Void.self) { group in
        group.addTask {
            await operation()
        }
        group.addTask {
            try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
        }
        await group.waitForAll()
    }
}
