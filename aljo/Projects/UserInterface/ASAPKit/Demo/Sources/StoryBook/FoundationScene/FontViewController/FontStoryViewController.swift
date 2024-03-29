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
    tableView.register(FontCell.self, forCellReuseIdentifier: FontCell.reuseIdentifier)
    tableView.register(
      FontHeaderView.self,
      forHeaderFooterViewReuseIdentifier: FontHeaderView.reuseIdentifier
    )
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    return tableView
  }()
  
  private let typographyModels: [TypographyModel] = TypographyModel.allCases
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    
    tableView.dataSource = self
    tableView.delegate = self
  }
}

extension FontStoryViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return typographyModels.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return typographyModels[section].items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: FontCell = tableView.dequeueReusable(with: indexPath)
    
    let item = typographyModels[indexPath.section].items[indexPath.row]
    
    cell.configure(with: item)
    return cell
  }
}

extension FontStoryViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view: FontHeaderView = tableView.dequeueReusableHeaderFooterView()
    let title = typographyModels[section].description
    view.configure(title: title)
    return view
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
