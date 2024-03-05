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

public final class ASStepper: UIView {
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
  @objc dynamic public var currentValue: Int = 1
  @objc dynamic public var minimumValue: Int = 0
  @objc dynamic public var maximumValue: Int = 100
  public var stepValue: Int = 1
  
  // MARK: - init
  public init() {
    super.init(frame: .zero)
    configureUI()
    bind()
  }
  
  @available(*, unavailable, message: "스토리 보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func shouldClampedCurrentValue() {
    guard currentValue <= maximumValue else {
      currentValue = maximumValue
      return
    }
    
    guard currentValue >= minimumValue else {
      currentValue = minimumValue
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
    
    let currentValue = rx.observe(\.currentValue).share()
    let minimumValue = rx.observe(\.minimumValue).share()
    let maximumValue = rx.observe(\.maximumValue).share()
    
    currentValue
      .map { $0.description }
      .bind(to: currentValueLabel.rx.text)
      .disposed(by: disposeBag)
    
    currentValue
      .withUnretained(self)
      .map { $0.maximumValue > $1 }
      .bind(to: upButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    currentValue
      .withUnretained(self)
      .map { $0.minimumValue < $1 }
      .bind(to: downButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    minimumValue
      .filter { $0 < 0 }
      .subscribe(with: self) { object, _ in
        object.minimumValue = 0
      }
      .disposed(by: disposeBag)
      
    Observable.merge(
      currentValue,
      minimumValue,
      maximumValue
    )
    .map { _ in }
    .bind(onNext: shouldClampedCurrentValue)
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
