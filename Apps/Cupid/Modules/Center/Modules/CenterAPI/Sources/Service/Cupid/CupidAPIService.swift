//
//  CupidAPIService.swift
//  CenterAPI
//
//  Created by jcc on 2023/3/7.
//

import Foundation
import RestfulClient

public final class CupidAPIService: APIService {
    
    let context: CupidAPIServiceContextual
    
    public init(context: CupidAPIServiceContextual) {
        self.context = context
        super.init()
    }
}


public extension CupidAPIService {
 
    func callOptions(additionHeader: [(String, String)] = []) -> HTTPHeaders {
        let guid = context.guid
        let token = context.token
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        let version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        let build = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? ""
        let language = Bundle.main.preferredLocalizations.first ?? ""
        let regionCode = Locale.current.regionCode ?? ""
        let defaultHeaders = [
            ("Authorization", "Bearer \(token)"),
            ("X-CUPID-GUID", guid),
            ("X-CUPID-BID", bundleID),
            ("X-CUPID-VERSION", version),
            ("X-CUPID-BUILD", build),
            ("X-CUPID-LANGUAGE", language),
            ("X-CUPID-REGIONCODE", regionCode),
        ]
        
        let allHeaders = defaultHeaders + additionHeader
        return HTTPHeaders(allHeaders)
    }
    
}
