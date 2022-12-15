//
//  Created by jcc on 2022/12/2.
//

import Foundation
import Kingfisher

public enum AsyncImageManager {}

public extension AsyncImageManager {
    @discardableResult
    static func setupProxy(host: String, port: Int, originalHeaderField: String) -> Self.Type {
        KingfisherManager.shared.downloader.trustedHosts = Set([host])
        KingfisherManager.shared.defaultOptions = [
            .requestModifier(AnyModifier { request in
                guard let url = request.url else { return request }
                guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return request }
                urlComponents.host = host
                urlComponents.port = port
                var modifiedRequest = request
                modifiedRequest.addValue(url.absoluteString, forHTTPHeaderField: originalHeaderField)
                modifiedRequest.url = urlComponents.url
                return modifiedRequest
            }),
        ]
        return self
    }

    @discardableResult
    static func setupCache() -> Self.Type {
        do {
            let name = String(describing: self)
            let cacheDirectoryURL: URL = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(name)
            let imageCache = try ImageCache(name: name, cacheDirectoryURL: cacheDirectoryURL)
            KingfisherManager.shared.cache = imageCache
        } catch {
            fatalError("\(error)")
        }
        return self
    }
}

