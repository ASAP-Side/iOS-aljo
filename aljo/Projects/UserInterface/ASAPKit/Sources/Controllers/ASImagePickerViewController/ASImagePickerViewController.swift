//
//  ASImagePickerViewController.swift
//  FanFollow
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

import Photos

import SnapKit

final class AssetImageGridCell: UICollectionViewCell {
  static let identifier = "AssetImageGridCell"
  // View Properties
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let selectedBlurView: UIView = {
    let view = UIView()
    view.backgroundColor = .black01
    view.alpha = .zero
    return view
  }()
  
  private let checkButton: UIButton = {
    var configuration = UIButton.Configuration.filled()
    configuration.baseBackgroundColor = .white
    configuration.image = .Icon.check_small.withTintColor(.white)
    configuration.cornerStyle = .capsule
    
    let button = UIButton(configuration: configuration)
    return button
  }()
  
  // Life Cycle
  override func layoutSubviews() {
    super.layoutSubviews()
    
    configureUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.imageView.image = nil
    setSelected(to: false)
  }
  
  // Configure Method
  func setImage(to image: UIImage?) {
    self.imageView.image = image
  }
  
  func setSelected(to isSelected: Bool, with color: UIColor = .red01) {
    self.layer.borderColor = isSelected ? color.cgColor : UIColor.clear.cgColor
    self.layer.borderWidth = 2
    self.checkButton.configuration?.baseBackgroundColor = isSelected ? color : .white
//    self.selectedBlurView.alpha = isSelected ? 0.5 : 0
    self.checkButton.isSelected = isSelected
  }
  
  func getImage() -> UIImage? {
    return imageView.image
  }
}

// Configure UI Method
private extension AssetImageGridCell {
  func configureUI() {
    configureHierarchy()
    makeConstraints()
  }
  
  func configureHierarchy() {
    contentView.addSubview(imageView)
    contentView.addSubview(selectedBlurView)
    contentView.addSubview(checkButton)
  }
  
  func makeConstraints() {
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    selectedBlurView.snp.makeConstraints {
      $0.edges.equalTo(imageView)
    }
    
    checkButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.width.height.equalTo(20)
    }
  }
}

public protocol ASImagePickerDelegate: AnyObject {
  func imagePicker(_ picker: ASImagePickerViewController, didComplete images: [UIImage?])
}

public class ASImagePickerViewController: UIViewController {
  // View Properties
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(
      AssetImageGridCell.self,
      forCellWithReuseIdentifier: AssetImageGridCell.identifier
    )
    return collectionView
  }()
  
  // Properties
  public weak var delegate: ASImagePickerDelegate?
  private var photos: PHFetchResult<PHAsset>?
  private let scale = UIScreen.main.scale
  private var thumbnailSize = CGSize.zero
  private let selectedMaxCount: Int
  private var selectedItems: [PHAsset] = []
  private var selectedColor: UIColor
  
  public init(max selectedMaxCount: Int, selectedColor: UIColor = .red01) {
    self.selectedMaxCount = selectedMaxCount
    self.selectedColor = selectedColor
    
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable, message: "스토리보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Deinit
  deinit { PHPhotoLibrary.shared().unregisterChangeObserver(self) }
  
  // Life Cycle
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    configureLibraryImages()
    configureUI()
  }
  
  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    let width = view.bounds.inset(by: view.safeAreaInsets).width
    
    let columnCount = (width / 90).rounded(.towardZero)
    let itemLength = (width - columnCount) / columnCount
    
    self.thumbnailSize = CGSize(width: itemLength * scale, height: itemLength * scale)
  }
  
  private func fetchSelectedImages(completionHandler: @escaping ([UIImage?]) -> Void) {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    option.deliveryMode = .highQualityFormat
    option.resizeMode = .fast
    var images: [UIImage?] = []
    print(UIScreen.main.scale)
    let group = DispatchGroup()
    
    for asset in selectedItems {
      let size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
      DispatchQueue.global().async(group: group) {
        group.enter()
        manager.requestImage(
          for: asset, targetSize: size, contentMode: .aspectFit, options: option
        ) { image, _ in
          images.append(image)
          group.leave()
        }
      }
    }
    
    group.notify(queue: .main) {
      completionHandler(images)
    }
  }
}

// UICollectionView DataSource Method
extension ASImagePickerViewController: UICollectionViewDataSource {
  public func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return photos?.count ?? .zero
  }
  
  public func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: AssetImageGridCell.identifier,
      for: indexPath
    ) as? AssetImageGridCell else {
      return AssetImageGridCell()
    }
    let asset = photos?.object(at: indexPath.item) ?? PHAsset()
    
    PHImageManager.default().requestImage(
      for: asset,
      targetSize: thumbnailSize,
      contentMode: .aspectFill,
      options: nil
    ) { image, _ in
      cell.setImage(to: image)
    }
    
    return cell
  }
  
  public func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let item = photos?[indexPath.row] else { return }
    let cell = collectionView.cellForItem(at: indexPath) as? AssetImageGridCell
    
    let isContainItem = selectedItems.contains(item)
    
    if selectedItems.count == selectedMaxCount && isContainItem == false { return }
    
    cell?.setSelected(to: isContainItem == false, with: selectedColor)
    
    if isContainItem == false {
      selectedItems.append(item)
    } else {
      selectedItems.removeAll(where: { $0.localIdentifier == item.localIdentifier })
    }
  }
}

// UICollectionView Flow Layout Delegate Method
extension ASImagePickerViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let length = self.view.frame.width / 3 - 1.5
    return CGSize(width: length, height: length)
  }
  
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 1.5
  }
  
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 1.5
  }
}

private extension ASImagePickerViewController {
  func configureLibraryImages() {
    checkPhotoAuthorization()
    
    PHPhotoLibrary.shared().register(self)
    
    let option = PHFetchOptions()
    option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    photos = PHAsset.fetchAssets(with: .image, options: option)
    
    collectionView.reloadData()
  }
  
  func checkPhotoAuthorization() {
    PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        switch status {
          case .denied, .restricted:
            print(status)
          default:
            return
        }
      }
    }
  }
}

// Photo Selected Changed Observer
extension ASImagePickerViewController: PHPhotoLibraryChangeObserver {
  public func photoLibraryDidChange(_ changeInstance: PHChange) {
    guard let photos = photos,
          let changes = changeInstance.changeDetails(for: photos) else { return }
    
    DispatchQueue.main.sync {
      self.photos = changes.fetchResultAfterChanges
      
      if changes.hasIncrementalChanges == true {
        collectionView.performBatchUpdates {
          if let removed = changes.removedIndexes,
             removed.isEmpty == false {
            let indexPaths = removed.map { IndexPath(item: $0, section: .zero) }
            collectionView.deleteItems(at: indexPaths)
          }
          
          if let inserted = changes.insertedIndexes,
             inserted.isEmpty == false {
            let indexPaths = inserted.map { IndexPath(item: $0, section: .zero)}
            collectionView.insertItems(at: indexPaths)
          }
          
          changes.enumerateMoves {
            let fromIndexPath = IndexPath(item: $0, section: .zero)
            let toIndexPath = IndexPath(item: $1, section: .zero)
            self.collectionView.moveItem(at: fromIndexPath, to: toIndexPath)
          }
          
          if let changed = changes.changedIndexes,
             changed.isEmpty == false {
            let indexPaths = changed.map { IndexPath(item: $0, section: .zero) }
            collectionView.reloadItems(at: indexPaths)
          }
        }
      }
      
      if changes.hasIncrementalChanges == false {
        collectionView.reloadData()
      }
    }
  }
}

// Configuration UI
private extension ASImagePickerViewController {
  func configureUI() {
    view.backgroundColor = .systemBackground
    configureNavigationBar()
    configureHierarchy()
    makeConstraints()
  }
  
  func configureNavigationBar() {
    navigationController?.setUpAppearance()
    let dismissAction = UIAction { [weak self] _ in
      self?.dismiss(animated: true)
    }
    
    let confirmAction = UIAction { [weak self] _ in
      // Delegate Method
      guard let self = self else { return }
      fetchSelectedImages { images in
        self.delegate?.imagePicker(self, didComplete: images)
      }
      
      self.dismiss(animated: true)
    }
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: .Icon.xmark_black,
      primaryAction: dismissAction
    )
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", primaryAction: confirmAction)
    navigationItem.title = "앨범 선택"
  }
  
  func configureHierarchy() {
    view.addSubview(collectionView)
  }
  
  func makeConstraints() {
    collectionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

extension UINavigationController {
  func setUpAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithDefaultBackground()
    appearance.backgroundColor = .white
    
    appearance.titleTextAttributes = [
      .font: UIFont.pretendard(.body2) as Any,
      .foregroundColor: UIColor.black01 as Any
    ]
    
    navigationBar.standardAppearance = appearance
    navigationBar.compactAppearance = appearance
    navigationBar.scrollEdgeAppearance = appearance
    navigationBar.isTranslucent = false
    navigationBar.tintColor = .black01
    navigationBar.prefersLargeTitles = false
  }
}
