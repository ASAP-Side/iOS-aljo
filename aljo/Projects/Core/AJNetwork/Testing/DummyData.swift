//
//  DummyData.swift
//  AJNetworkTesting
//
//  Created by 이태영 on 2/1/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import Foundation

struct DummyData: Decodable {
  let title: String
}

let dummyJson = """
  {
  "title" : "Hi"
}
"""
