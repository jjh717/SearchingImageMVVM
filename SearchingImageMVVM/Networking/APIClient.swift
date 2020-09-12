//
//  APIService.swift
//  SearchingImageMVVM
//
//  Created by Jang Dong Min on 2020/09/07.
//  Copyright © 2020 jdm. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    static func searchImage(page: Int, completion: @escaping (Result<Any, AFError>) -> Void) {
        AF.request(UserEndpoint.getImageList(page: page)).validate().responseJSON { response in
            completion(response.result)
        }
    }
}


