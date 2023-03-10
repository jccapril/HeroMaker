//
//  OursProvider.swift
//  AppOurs
//
//  Created by jcc on 2023/3/1.
//


import Center
import Foundation
import UICore

class OursProvider: Provider {}


extension OursProvider {
    
    
    func testToken() async throws -> COSUploadConfiguration? {
        try await APICenter.Upload.getUploadToken(type: 1)
    }
    
    func testUpload() {
        
//        Task {
//            do {
//                let config = try await testToken()
//                logger.debug("config tokenStartedAt:\(config?.tokenStartedAt)")
//            }catch {
//                logger.error("error:\(error)")
//            }
//
//        }
        
        let imageData = UIImage(color: .systemBlack).pngData()

        TencentCOSCenter.upload(imageData: imageData) { result in
            switch result {
            case .success(let value):
                logger.debug("result: \(value)")
            case .failure(let error):
                logger.debug("error: \(error)")
            }
        }
    }
    
}


