//
//  CoupleRequest.swift
//  CenterAPI
//
//  Created by jcc on 2023/2/27.
//

import Foundation
import RestfulClient
import Coder

class CoupleInfoRequest: BaseRequestable {
    let path: String = "/api/v1/couple/info"
    let method: HTTPMethod = .GET

}



class CoupleInvitationRequest: BaseRequestable {
    let path: String = "/api/v1/couple/code"
    let method: HTTPMethod = .GET
}


class CoupleUserRequest: BaseRequestable {
    let path: String = "/api/v1/couple/user"
    let method: HTTPMethod = .GET
    let queryItems: [URLQueryItem]?
    
    init(code: String?) {
        if let code = code {
            self.queryItems = [URLQueryItem(name: "code", value: code)]
        }else {
            self.queryItems = nil
        }
    }
}

class BindCoupleRequest: BaseRequestable {
    let path: String = "/api/v1/couple/bind"
    let method: HTTPMethod = .POST
    let body: [UInt8]?
    init(code: String, guid: String) {
        body = try? JSONCoder.encode(object: ["code": code, "guid": guid]).bytes
    }
}

