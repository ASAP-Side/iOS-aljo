//
//  ColorStoryViewController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import SnapKit

import ASAPKit

class ColorStoryViewController: UIViewController {
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(ColorCell.self, forCellReuseIdentifier: ColorCell.reuseIdentifier)
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    return tableView
  }()
  
  private let colorModels: [ColorModel] = ColorModel.allCases
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    
    tableView.dataSource = self
  }
}

extension ColorStoryViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return colorModels.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return colorModels[section].items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ColorCell = tableView.dequeueReusable(with: indexPath)
    let item = colorModels[indexPath.section].items[indexPath.row]
    cell.configure(with: item)
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return colorModels[section].description
  }
}

private extension ColorStoryViewController {
  func configureUI() {
    view.backgroundColor = .systemBackground
    
    configureNavigationBar()
    
    configureHierarchy()
    makeConstraints()
  }
  
  func configureNavigationBar() {
    let titleLabel = UILabel()
    titleLabel.text = "색상"
    titleLabel.font = .pretendard(.headLine3)
    titleLabel.textColor = .black01
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
