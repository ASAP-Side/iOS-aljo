//
//  BottomSheetListViewController.swift
//  ASAPKitDemo
//
//  Created by 이태영 on 3/18/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import ASAPKit

import SnapKit

final class BottomSheetListViewController: ASBottomSheetController {
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "프로필 변경"
    label.font = .pretendard(.headLine3)
    label.textColor = .black01
    return label
  }()
  
  private let dismissButton: UIButton = {
    var configuration = UIButton.Configuration.plain()
    configuration.image = .Icon.xmark_black
    let button = UIButton()
    button.configuration = configuration
    return button
  }()
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(
      BottomSheetListCell.self,
      forCellReuseIdentifier: "cell"
    )
    tableView.separatorStyle = .none
    tableView.isScrollEnabled = false
    return tableView
  }()
  
  private let contents: [BottomSheetListCellContent]
  
  init(detent: ASBottomSheetDetent, contents: [BottomSheetListCellContent]) {
    self.contents = contents
    super.init(detent: detent)
  }
  override func viewDidLoad() {
    configureUI()
    configureAction()
  }
}

// MARK: UITableViewDelegate
extension BottomSheetListViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    tableView.deselectRow(at: indexPath, animated: true)
    self.dismiss(animated: true)
    contents[indexPath.row].action()
  }
}

// MARK: UITableViewDataSource
extension BottomSheetListViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return contents.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "cell",
      for: indexPath
    ) as? BottomSheetListCell else {
      return .init()
    }
    
    cell.configureCell(with: contents[indexPath.row])
    return cell
  }
}

// MARK: Configure Action
extension BottomSheetListViewController {
  private func configureAction() {
    let dismissAction = UIAction { [weak self] _ in
      self?.dismiss(animated: true)
    }
    
    dismissButton.addAction(dismissAction, for: .touchUpInside)
  }
}

// MARK: Configure UI
extension BottomSheetListViewController {
  private func configureUI() {
    view.backgroundColor = .systemBackground
    view.layer.cornerRadius = 20
    configureHierarchy()
    configureConstraints()
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func configureHierarchy() {
    [titleLabel, dismissButton, tableView].forEach {
      view.addSubview($0)
    }
  }
  
  private func configureConstraints() {
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(24)
      $0.leading.equalToSuperview().offset(20)
    }
    
    dismissButton.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel.snp.centerY)
      $0.trailing.equalToSuperview().offset(-20)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(28)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
}

final class BottomSheetListCell: UITableViewCell {
  private let iconImageView = UIImageView()
  private let label: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.body2)
    label.textColor = .black02
    return label
  }()
  
  override init(
    style: UITableViewCell.CellStyle,
    reuseIdentifier: String?
  ) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  @available(*, unavailable, message: "스토리 보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCell(with contents: BottomSheetListCellContent) {
    iconImageView.image = contents.image
    label.text = contents.text
  }
  
  private func configureUI() {
    [iconImageView, label].forEach {
      contentView.addSubview($0)
    }
    
    iconImageView.snp.makeConstraints {
      $0.leading.equalTo(contentView.snp.leading).offset(20)
      $0.width.equalTo(24)
      $0.height.equalTo(iconImageView.snp.width)
      $0.top.equalTo(contentView.snp.top).offset(14)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-14)
    }
    
    label.snp.makeConstraints {
      $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
      $0.centerY.equalTo(iconImageView.snp.centerY)
    }
  }
}

struct BottomSheetListCellContent {
  let image: UIImage
  let text: String
  let action: () -> Void
}
