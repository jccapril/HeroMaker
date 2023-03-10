//
//  COSSignatureProvider.swift
//  CenterOSS
//
//  Created by jcc on 2023/3/9.
//

import Foundation
import QCloudCOSXML
import ExtensionKit

class COSSignatureProvider: NSObject {
    private lazy var credentialFenceQueue: QCloudCredentailFenceQueue = {
        let queue = QCloudCredentailFenceQueue()
        queue.delegate = self
        return queue
    }()

    var signatureConfigration: COSUploadConfiguration?
}

enum SignatureError: Error {
    case noToken
}

extension SignatureError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noToken:
            return "signature token is null"
        }
    }
}

extension COSSignatureProvider: QCloudSignatureProvider {
    func signature(with _: QCloudSignatureFields?, request _: QCloudBizHTTPRequest?, urlRequest urlRequst: NSMutableURLRequest?, compelete continueBlock: QCloudHTTPAuthentationContinueBlock?) {
        if signatureConfigration == nil {
            continueBlock?(nil, SignatureError.noToken)
            return
        }
        credentialFenceQueue.performAction { creator, error in
            if error != nil {
                continueBlock?(nil, error)
            } else {
                let signature = creator?.signature(forData: urlRequst)
                continueBlock?(signature, nil)
            }
        }
    }
}

extension COSSignatureProvider: QCloudCredentailFenceQueueDelegate {
    func fenceQueue(_: QCloudCredentailFenceQueue?, requestCreatorWithContinue continueBlock: QCloudCredentailFenceQueueContinue?) {
        guard let config = signatureConfigration else {
            continueBlock?(nil, SignatureError.noToken)
            return
        }
        // ...
        let credential = QCloudCredential()
        // 临时密钥 SecretId
        credential.secretID = config.tmpSecretID
        // 临时密钥 SecretKey
        credential.secretKey = config.tmpSecretKey
        // 临时密钥 Token
        credential.token = config.token
        // 强烈建议返回服务器时间作为签名的开始时间
        // 用来避免由于用户手机本地时间偏差过大导致的签名不正确
        credential.startDate = config.tokenStartedAt
        // 这里返回的时间单位是秒
        credential.expirationDate = config.tokenExpiredAt
        let auth = QCloudAuthentationV5Creator(credential: credential)
        continueBlock?(auth, nil)
    }
}

