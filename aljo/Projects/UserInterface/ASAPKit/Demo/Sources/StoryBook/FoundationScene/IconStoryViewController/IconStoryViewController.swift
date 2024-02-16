//
//  IconStoryViewController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import SnapKit

class IconStoryViewController: UIViewController {
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(IconCell.self, forCellReuseIdentifier: IconCell.reuseIdentifier)
    return tableView
  }()
  
  private let iconModels: [IconModel] = IconModel.default()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    
    tableView.dataSource = self
  }
}

extension IconStoryViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return iconModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: IconCell = tableView.dequeueReusable(with: indexPath)
    let item = iconModels[indexPath.row]
    
    cell.configure(with: item)
    
    return cell
  }
}

private extension IconStoryViewController {
  func configureUI() {
    view.backgroundColor = .systemBackground
    
    configureNavigationBar()
    
    configureHierarchy()
    makeConstraints()
  }
  
  func configureNavigationBar() {
    let titleLabel = UILabel()
    titleLabel.text = "아이콘"
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
