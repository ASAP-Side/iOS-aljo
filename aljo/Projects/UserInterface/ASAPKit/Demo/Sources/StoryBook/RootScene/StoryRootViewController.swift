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
  
  private let items: [DemoCategory: [DemoDetail]] = DemoCategory.allCaseDictionary
  
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
    
    navigationController?.pushViewController(item.instance, animated: true)
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
    titleLabel.textColor = .black01
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  func configureHierarchy() {
     view.addSubview(tableView)
  }
  
  func makeConstraints() {
    tableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.horizontalEdges.bottom.equalToSuperview()
    }
  }
}
