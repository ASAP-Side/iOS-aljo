//
//  RequestBehavior.swift
//  AJNetworkInterface
//
//  Created by 이태영 on 1/31/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import Alamofire

public enum RequestBehavior {
  case plain
  case requestJsonEncodable(Encodable)
  case requestURLEncoded(parameters: Parameters)
  case requestParameters(parameters: Parameters, encoding: ParameterEncoding)
  case uploadMultipartFormData(MultipartFormData, parameters: Parameters)
}
