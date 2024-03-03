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
  private var currentValue: Int = 0
  
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
    label.text = "0"
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
  
  // MARK: - init
  public init() {
    super.init(frame: .zero)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Configure UI
extension ASStepper {
  private func configureUI() {
    configureHirachy()
    makeConstratins()
    
    [upButton, downButton].forEach {
      $0.configurationUpdateHandler = stepperButtonUpdateHandler
    }
  }
  
  private func configureHirachy() {
    addSubview(totalStackView)
    
    [downButton, currentValueLabel, upButton].forEach {
      totalStackView.addArrangedSubview($0)
    }
  }
  
  private func makeConstratins() {
    totalStackView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func stepperButtonUpdateHandler(_ button: UIButton) {
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
