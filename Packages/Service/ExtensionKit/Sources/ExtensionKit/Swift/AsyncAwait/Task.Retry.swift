//
//  Created by jcc on 2022/11/29.
//

#if canImport(_Concurrency)
import typealias Foundation.TimeInterval

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public extension Task where Failure == Error {
    @discardableResult
    static func retrying(priority: TaskPriority? = nil, maxRetryCount: Int = 3, retryDelay: TimeInterval = 1, operation: @Sendable @escaping () async throws -> Success) -> Task {
        Task(priority: priority) {
            for _ in 0..<maxRetryCount {
                do {
                    return try await operation()
                } catch {
                    let delay = UInt64(retryDelay * TimeInterval(1_000_000_000))
                    try await Task<Never, Never>.sleep(nanoseconds: delay)
                    continue
                }
            }

            try Task<Never, Never>.checkCancellation()
            return try await operation()
        }
    }
}

#endif

