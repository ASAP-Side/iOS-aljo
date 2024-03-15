//
//  ASListViewDemoController.swift
//  ASAPKitDemo
//
//  Created by 이태영 on 3/8/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import ASAPKit

import RxCocoa
import RxSwift
import SnapKit

final class ASListViewDemoController: UIViewController {
  private let disposeBag = DisposeBag()
  
  private let listView: ASListView = {
    let listView = ASListView()
    listView.spacing = 20
    return listView
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .gray04
    return imageView
  }()
  private let imageDetailLabel: UILabel = {
    let label = UILabel()
    label.text = "사진을 등록하지 않는 경우 랜덤 이미지로 보여집니다"
    label.textColor = .black03
    label.font = .pretendard(.caption2)
    return label
  }()
  private let imageStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 8
    
    return stackView
  }()
  
  private let groupNameTextField: ASBorderHighlightTextField = {
    let textField = ASBorderHighlightTextField()
    textField.placeholder = "그룹명을 입력해주세요 (최대 15자 이내)"
    return textField
  }()
  private let groupIntroduceTextView: ASTextView = {
    let textView = ASTextView(placeholder: "내용을 입력해주세요", maxLength: 50)
    textView.borderColor = .black04
    return textView
  }()
  
  private let groupCountLabel: UILabel = {
    let label = UILabel()
    label.text = "최대 8명"
    label.font = .pretendard(.caption3)
    label.textColor = .black03
    return label
  }()
  private let groupCountStepper: ASStepper = {
    let stepper = ASStepper(maximumValue: 8)
    return stepper
  }()
  private let groupCountStackView: UIStackView = {
    let stackView = UIStackView()
    let label = UILabel()
    label.text = "인원"
    label.textColor = .black01
    label.font = .pretendard(.body3)
    label.setContentHuggingPriority(.required, for: .horizontal)
    stackView.addArrangedSubview(label)
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 4
    stackView.layoutMargins = .init(top: 12, left: 16, bottom: 12, right: 16)
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layer.borderColor = UIColor.gray02.cgColor
    stackView.layer.borderWidth = 1
    stackView.layer.cornerRadius = 6
    return stackView
  }()
  
  override func viewDidLoad() {
    configureUI()
    bindUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    print(view.frame.width)
  }
}

// MARK: Bind
extension ASListViewDemoController {
  private func bindUI() {
    groupIntroduceTextView.rx.text.orEmpty
      .map { $0.isEmpty }
      .distinctUntilChanged()
      .map { $0 ? UIColor.gray02 : UIColor.black }
      .bind(to: groupIntroduceTextView.rx.borderColor)
      .disposed(by: disposeBag)
  }
}

// MARK: - UI Configuration
extension ASListViewDemoController {
  private func configureUI() {
    view.backgroundColor = .systemBackground
    configureHirearchy()
    configureConstraints()
  }
  
  private func configureHirearchy() {
    view.addSubview(listView)
    
    [imageView, imageDetailLabel].forEach {
      imageStackView.addArrangedSubview($0)
    }
    
    [groupCountLabel, groupCountStepper].forEach {
      groupCountStackView.addArrangedSubview($0)
    }
    groupCountLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    groupCountStepper.setContentHuggingPriority(.required, for: .horizontal)
    
    listView.addItem(imageStackView, title: "대표이미지")
    listView.addItem(groupNameTextField, title: "그룹명")
    listView.addItem(groupIntroduceTextView, title: "그룹 소개글")
    listView.addItem(groupCountStackView, title: "그룹 인원")
    listView.addSeperator()
    
    let view = UIView()
    view.backgroundColor = .yellow
    view.snp.makeConstraints {
      $0.height.equalTo(30)
    }
    listView.addItem(view)
  }
  
  private func configureConstraints() {
    listView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    imageView.snp.makeConstraints {
      $0.height.equalTo(230)
    }
    
    groupIntroduceTextView.snp.makeConstraints {
      $0.height.equalTo(128)
    }
  }
}
