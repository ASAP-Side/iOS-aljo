//
//  StoryRootViewController.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

class StoryRootViewController: UIViewController {
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = .systemBackground
    tableView.register(DemoCategoryCell.self, forCellReuseIdentifier: DemoCategoryCell.identifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private let textView: ASTextView = {
    let textView = ASTextView()
    textView.borderColor = .title
    textView.font = .pretendard(.headLine3)
    textView.isShowCount = true
    return textView
  }()
  
  private let items: [DemoCategory: [Any]] = DemoCategory.allCaseDictionary
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    
    tableView.delegate = self
    tableView.dataSource = self
  }
}

extension StoryRootViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return items.keys.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let category = DemoCategory(rawValue: section) else { return .zero }
    return items[category]?.count ?? .zero
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return DemoCategory(rawValue: section)?.description
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: DemoCategoryCell.identifier,
      for: indexPath
    ) as? DemoCategoryCell else {
      return UITableViewCell()
    }
    
    if let category = DemoCategory(rawValue: indexPath.section) {
      let item = items[category]?[indexPath.row]
      cell.bind(to: item)
    }
    
    return cell
  }
}

extension StoryRootViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let sectionCategory = DemoCategory(rawValue: indexPath.section),
          let item = items[sectionCategory]?[indexPath.row] else { return }
    
    if let item = item as? SystemConfiguration {
      let controller = item.instance
      
      navigationController?.pushViewController(controller, animated: true)
    }
  }
}

private extension StoryRootViewController {
  func configureUI() {
    view.backgroundColor = .systemBackground

    configureNavigationBar()
    
    configureHierarchy()
    makeConstraints()
  }
  
  func configureNavigationBar() {
    let titleLabel = UILabel()
    titleLabel.font = .pretendard(.headLine1)
    titleLabel.text = "StoryBook"
    titleLabel.textColor = ASAPKitAsset.Basic.title.color
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  func configureHierarchy() {
//    view.addSubview(tableView)
    view.addSubview(textView)
  }
  
  func makeConstraints() {
    textView.snp.makeConstraints {
      $0.horizontalEdges.equalToSuperview().inset(16)
      $0.top.equalToSuperview().offset(16)
      $0.height.equalTo(128)
    }
  }
}
