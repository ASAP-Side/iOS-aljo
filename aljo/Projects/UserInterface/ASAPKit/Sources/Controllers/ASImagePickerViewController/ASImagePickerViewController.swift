//
//  ASImagePickerViewController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

public class ASImagePickerViewController: PhotoAssetGridViewController {
  public var selectedColor: UIColor = .red01
  
  public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as? AssetImageGridCell
    cell?.setSelected(to: true, with: selectedColor)
  }
}
