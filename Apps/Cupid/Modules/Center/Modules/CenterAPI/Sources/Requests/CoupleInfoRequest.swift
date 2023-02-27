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



