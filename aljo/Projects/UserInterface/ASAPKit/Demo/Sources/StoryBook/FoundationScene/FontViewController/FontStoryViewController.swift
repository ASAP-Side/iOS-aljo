//
//  FontStoryViewController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import SnapKit

import ASAPKit

final class FontStoryViewController: UIViewController {
  private let tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
}

private extension FontStoryViewController {
  func configureUI() {
    view.backgroundColor = .systemBackground
    
    configureNavigationBar()
    
    configureHierarchy()
    makeConstraints()
  }
  
  func configureNavigationBar() {
    let titleLabel = UILabel()
    titleLabel.text = "폰트"
    titleLabel.font = .pretendard(.headLine3)
    titleLabel.textColor = .title
    navigationItem.titleView = titleLabel
  }
  
  func configureHierarchy() {
    [tableView].forEach(view.addSubview)
  }
  
  func makeConstraints() {
    tableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.horizontalEdges.bottom.equalToSuperview()
    }
  }
}
