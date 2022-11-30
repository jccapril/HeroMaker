//
//  Created by jcc on 2022/11/30.
//

import AsyncHTTPClient
import Foundation

public class Configuration {
    private let connectTimeout: Int64
    private let readTimeout: Int64

    public init(connectTimeout: Int64 = 5, readTimeout: Int64 = 5) {
        self.connectTimeout = connectTimeout
        self.readTimeout = readTimeout
    }
}

extension Configuration {
    func export() -> HTTPClient.Configuration {
        HTTPClient.Configuration(
            tlsConfiguration: .makeClientConfiguration(),
            redirectConfiguration: .follow(max: 5, allowCycles: false),
            timeout: .init(connect: .seconds(connectTimeout), read: .seconds(readTimeout)),
            connectionPool: HTTPClient.Configuration.ConnectionPool(),
            proxy: nil,
            decompression: .enabled(limit: .size(10 * 1024 * 1024))
        )
    }
}

