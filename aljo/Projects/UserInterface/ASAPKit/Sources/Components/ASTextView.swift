//
//  ASTextView.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import SnapKit
import RxSwift
import RxRelay
import RxCocoa

extension String {
  func toAttributedString(
    with style: UIFont.PretendardStyle,
    _ styleHandler: ((inout NSMutableParagraphStyle) -> Void)? = nil
  ) -> NSMutableAttributedString {
    let attributedString = NSMutableAttributedString(string: self)
    
    var paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.maximumLineHeight = style.lineHeight
    paragraphStyle.minimumLineHeight = style.lineHeight
    paragraphStyle.lineBreakMode = .byTruncatingTail
    styleHandler?(&paragraphStyle)
    
    let range = NSRange(location: .zero, length: attributedString.length)
    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
    return attributedString
  }
}

extension NSMutableAttributedString {
  func color(_ color: UIColor, of searchTerm: String) -> NSMutableAttributedString {
    let length = self.string.count
    var range = NSRange(location: .zero, length: length)
    var rangeArray = [NSRange]()
    
    while range.location != NSNotFound {
      range = (self.string as NSString)
        .range(of: searchTerm, options: .caseInsensitive, range: range)
      rangeArray.append(range)
      
      if range.location != NSNotFound {
        range = NSRange(
          location: range.location + range.length,
          length: self.string.count - (range.location + range.length)
        )
      }
    }
    
    rangeArray.forEach {
      self.addAttribute(.foregroundColor, value: color, range: $0)
    }
    return self
  }
}


/*
 ASTextView
 - borderColor : Border의 색상을 조절
 - font : Font를 조절
 - shouldShowCount : 글자 수 세기가 필요한가?
 - placeholder: 플레이스 홀더
 */
public class ASTextView: UIView {
  // MARK: View Properties
  private let textView: UITextView = UITextView()
  private let countLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.caption3)
    label.textAlignment = .right
    return label
  }()
  
  // MARK: Public Properties
  public var borderColor: UIColor? {
    get {
      guard let color = layer.borderColor else { return nil }
      return UIColor(cgColor: color)
    }
    set {
      self.layer.borderColor = newValue?.cgColor
    }
  }
  
  public var font: UIFont? {
    get {
      return textView.font
    }
    set {
      textView.font = newValue
    }
  }
  
  public var isShowCount: Bool {
    get {
      return countLabel.isHidden
    }
    set {
      countLabel.isHidden = newValue
    }
  }
  private var disposeBag = DisposeBag()
  
  public convenience init() {
    self.init(frame: .zero)
    
    textView.font = .pretendard(.body3)
    textView.contentInset = UIEdgeInsets(top: 13, left: 16, bottom: 13, right: 16)
    
    configureUI(isShowCount: isShowCount)
    
    layer.borderWidth = 1
    layer.cornerRadius = 6
    
    binding()
  }
  
  func binding() {
    countLabel.rx.observe(\.isHidden, options: [.initial, .new])
      .bind(onNext: configureUI)
      .disposed(by: disposeBag)
    
  }
}

private extension ASTextView {
  func configureUI(isShowCount: Bool) {
    if subviews.contains(textView) {
      textView.removeFromSuperview()
    }
    
    if subviews.contains(countLabel) {
      countLabel.removeFromSuperview()
    }
    
    if isShowCount {
      [textView, countLabel].forEach(addSubview)
      
      textView.snp.makeConstraints {
        $0.top.horizontalEdges.equalToSuperview()
      }
      
      countLabel.snp.makeConstraints {
        $0.top.equalTo(textView.snp.bottom).offset(15)
        $0.horizontalEdges.equalToSuperview().inset(16)
        $0.bottom.equalToSuperview().offset(-10)
      }
    } else {
      addSubview(textView)
      
      textView.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
}
