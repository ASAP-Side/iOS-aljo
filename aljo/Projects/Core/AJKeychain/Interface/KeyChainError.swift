//
//  KeyChainError.swift
//  AJKeychainInterface
//
//  Copyright (c) 2024 Minii All rights reserved.

import CoreFoundation

public enum KeyChainError: Error {
  case duplicate
  case invalidDecode
  case unknown(OSStatus)
}
