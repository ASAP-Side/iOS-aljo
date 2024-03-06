//
//  ASStepper.swift
//  ASAPKit
//
//  Created by 이태영 on 2/29/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

public final class ASStepper: UIControl {
  private let disposeBag = DisposeBag()
  
  // MARK: - Components
  private let upButton: UIButton = {
    let button = UIButton()
    button.configuration = UIButton.Configuration.plain()
    button.configuration?.image = .Icon.plus
    return button
  }()
  
  private let downButton: UIButton = {
    let button = UIButton()
    button.configuration = UIButton.Configuration.plain()
    button.configuration?.image = .Icon.minus
    return button
  }()
  
  private let currentValueLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black01
    label.font = .pretendard(.body4)
    label.textAlignment = .center
    return label
  }()
  
  private let totalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 20
    return stackView
  }()
  
  // MARK: - Public
  public var currentValue: Int {
    didSet {
      checkCurrentValueOutOfRange()
      sendActions(for: .valueChanged)
    }
  }
  var maximumValue: Int
  var minimumValue: Int
  
  public var stepValue: Int = 1
  
  // MARK: - init
  public init(
    currentValue: Int = 1,
    maximumValue: Int = 100,
    minimumValue: Int = 1
  ) {
    self.currentValue = currentValue
    self.maximumValue = maximumValue
    self.minimumValue = minimumValue
    super.init(frame: .zero)
    checkCurrentValueOutOfRange()
    configureUI()
    bind()
  }
  
  @available(*, unavailable, message: "스토리 보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func checkCurrentValueOutOfRange() {
    guard currentValue <= maximumValue,
          currentValue >= minimumValue
    else {
      assert(false, "currentValue가 max, min 범위를 벗어날 수 없습니다.")
      return
    }
  }
}

// MARK: - Bind
extension ASStepper {
  private func bind() {
    upButton.rx.tap
      .subscribe(with: self) { object, _ in
        object.currentValue += object.stepValue
      }
      .disposed(by: disposeBag)
    
    downButton.rx.tap
      .subscribe(with: self) { object, _ in
        object.currentValue -= object.stepValue
      }
      .disposed(by: disposeBag)
    
    rx.value
      .map { $0.description }
      .bind(to: currentValueLabel.rx.text)
      .disposed(by: disposeBag)
    
    rx.value
      .withUnretained(self)
      .map { $0.maximumValue > $1 }
      .bind(to: upButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    rx.value
      .withUnretained(self)
      .map { $0.minimumValue < $1 }
      .bind(to: downButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }
}

// MARK: - Configure UI
extension ASStepper {
  private func configureUI() {
    configureHirachy()
    makeConstraints()
    
    [upButton, downButton].forEach {
      $0.configurationUpdateHandler = { button in
        switch button.state {
        case .normal:
          button.configuration?.imageColorTransformer = .init({ _ in
            return .black01
          })
        case .disabled:
          button.configuration?.imageColorTransformer = .init({ _ in
            return .gray02
          })
        default:
          break
        }
      }
    }
  }
  
  private func configureHirachy() {
    addSubview(totalStackView)
    
    [downButton, currentValueLabel, upButton].forEach {
      totalStackView.addArrangedSubview($0)
    }
  }
  
  private func makeConstraints() {
    totalStackView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    currentValueLabel.snp.makeConstraints {
      $0.width.equalTo(50)
    }
  }
}
