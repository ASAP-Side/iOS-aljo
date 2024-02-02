//
//  MockKeyChainItem.swift
//  AJKeychainTesting
//
//  Copyright (c) 2024 Minii All rights reserved.

import Foundation
import AJKeychainInterface

public struct MockKeyChainConfiguration {
  let isSuccess: Bool
  let requestValue: Data
  let error: KeyChainError
}
