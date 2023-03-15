//
//  TencentCOSCenter.swift
//  CenterOSS
//
//  Created by jcc on 2023/3/9.
//

import CommonCrypto
import CryptoKit
import Foundation
import QCloudCOSXML
import AppModular

public enum TencentCOSCenter {}

public enum BusinessType: Int64 {
    case image = 1

    var extName: String {
        switch self {
        case .image:
            return ".png"
        }
    }
}


public enum UploadError: Error, LocalizedError {
    case invalidData
    case error(_ error: Error)

    public var errorDescription: String? {
        switch self {
        case .invalidData:
            return "invalidData"
        case .error(let error):
            return error.localizedDescription
        }
    }
}

extension TencentCOSCenter: Centric {
    public static let queue = DispatchQueue(label: typeName)
    static var context: TencentCOSCenterContextual?
}

private extension TencentCOSCenter {
    static let provider = COSSignatureProvider()
}

private extension TencentCOSCenter {
    static func asyncGetService() async throws -> COSUploadConfiguration  {
        guard let configuration = COSConfigurationProvider.configuration else {
            
            try await COSConfigurationProvider.asyncGetConfiguration()
            guard let configuration = COSConfigurationProvider.configuration else {
                throw UploadError.invalidData
            }
            provider.signatureConfigration = configuration
            self.registerCOSConfig(regionName: configuration.region, provider: provider)
            return configuration
        }
        return configuration
    }

    static func registerCOSConfig(regionName: String, provider: QCloudSignatureProvider) {
        let config = QCloudServiceConfiguration()
        let endpoint = QCloudCOSXMLEndPoint()

        // 服务地域简称，例如广州地区是 ap-guangzhou
        endpoint.regionName = regionName
        // 使用 HTTPS
        endpoint.useHTTPS = true
        config.endpoint = endpoint

        config.signatureProvider = provider

        QCloudCOSXMLService.registerDefaultCOSXML(with: config)
        QCloudCOSTransferMangerService.registerDefaultCOSTransferManger(with: config)
    }

    static func upload(body: AnyObject, bucket: String, path: String, process: ((_ presenting: Float) -> Void)?, complete: @escaping (Result<String, UploadError>) -> Void) {
        let put = QCloudCOSXMLUploadObjectRequest<AnyObject>()
        // 存储桶名称，格式为 BucketName-APPID
        put.bucket = bucket
        // 对象键，是对象在 COS 上的完整路径，如果带目录的话，格式为 "dir1/object1"
        put.object = path
        // 需要上传的对象内容。可以传入NSData*或者NSURL*类型的变量
        put.body = body
        // 监听上传结果
        put.setFinish { result, error in
            // 获取上传结果
            if let error = error {
                mainQueue.async { complete(.failure(.error(error))) }
            } else {
                mainQueue.async { complete(.success(result?.key ?? "")) }
            }
        }
        // 监听上传进度
        put.sendProcessBlock = { _, totalBytesSent, totalBytesExpectedToSend in
            if totalBytesExpectedToSend == 0 {
                process?(0)
            }else {
                process?(Float(totalBytesSent / totalBytesExpectedToSend))
            }
           
        }
        QCloudCOSTransferMangerService.defaultCOSTransferManager().uploadObject(put)
    }
}

public extension TencentCOSCenter {
    static func register(context: TencentCOSCenterContextual?) {
        self.context = context
    }

    static func upload(imageData: Data?, process: ((_ presenting: Float) -> Void)? = nil, complete: @escaping (Result<String, UploadError>) -> Void) {
        guard let data = imageData else {
            complete(.failure(.invalidData))
            return
        }
        Task {
            do {
                let config = try await asyncGetService()
                let path = "\(config.path ?? "")\(data.sha256)\(BusinessType.image.extName)"
                upload(body: data as AnyObject, bucket: config.bucket, path: path, process: process, complete: complete)
            } catch{
                mainQueue.async { complete(.failure(.error(error))) }
            }
            
        }
        
    }
}

private extension Data {
    var sha256: String {
        SHA256.hash(data: self).hexStr
    }
}

private extension SHA256Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}
