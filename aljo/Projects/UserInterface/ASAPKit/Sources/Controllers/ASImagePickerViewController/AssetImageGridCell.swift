//
//  AssetImageGridCell.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import SnapKit

final class AssetImageGridCell: UICollectionViewCell {
  static let identifier = "AssetImageGridCell"
  // View Properties
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let selectedBlurView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.alpha = 1
    return view
  }()
  
  private let checkButton: UIButton = {
    var configuration = UIButton.Configuration.filled()
    configuration.baseBackgroundColor = .white
    configuration.image = .Icon.check_small.withTintColor(.white)
    configuration.cornerStyle = .capsule
    
    let button = UIButton(configuration: configuration)
    return button
  }()
  
  // Life Cycle
  override func layoutSubviews() {
    super.layoutSubviews()
    
    configureUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.imageView.image = nil
    setSelected(to: false)
  }
  
  // Configure Method
  func setImage(to image: UIImage?) {
    self.imageView.image = image
  }
  
  func setSelected(to isSelected: Bool, with color: UIColor = .red01) {
    selectedBlurView.layer.borderColor = isSelected ? color.cgColor : UIColor.clear.cgColor
    selectedBlurView.layer.borderWidth = 2
    selectedBlurView.backgroundColor = isSelected ? .black01.withAlphaComponent(0.5) : .clear
    checkButton.configuration?.baseBackgroundColor = isSelected ? color : .white
    checkButton.isSelected = isSelected
  }
  
  func getImage() -> UIImage? {
    return imageView.image
  }
}

// Configure UI Method
private extension AssetImageGridCell {
  func configureUI() {
    configureHierarchy()
    makeConstraints()
  }
  
  func configureHierarchy() {
    [imageView, selectedBlurView, checkButton].forEach(contentView.addSubview(_:))
  }
  
  func makeConstraints() {
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    selectedBlurView.snp.makeConstraints {
      $0.edges.equalTo(imageView)
    }
    
    checkButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.width.height.equalTo(20)
    }
  }
}
