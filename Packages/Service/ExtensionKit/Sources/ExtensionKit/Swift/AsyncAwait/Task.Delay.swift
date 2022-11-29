//
//  Created by jcc on 2022/11/29.
//

#if canImport(_Concurrency)
import typealias Foundation.TimeInterval

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public extension Task where Failure == Error {
    static func delayed(timeInterval: TimeInterval, priority: TaskPriority? = nil, operation: @Sendable @escaping () async throws -> Success) -> Task {
        Task(priority: priority) {
            let delay = UInt64(timeInterval * 1_000_000_000)
            try await Task<Never, Never>.sleep(nanoseconds: delay)
            return try await operation()
        }
    }
}

#endif

