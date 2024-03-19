//
//  PhotoAssetGridViewController.swift
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
  
  // Properties
  var identifier: String?
  
  // Life Cycle
  override func layoutSubviews() {
    super.layoutSubviews()
    
    configureUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.imageView.image = nil
//    setSelected(to: false)
  }
  
  // Configure Method
  func setImage(to image: UIImage?) {
    self.imageView.image = image
  }
  
  func setSelected(to isSelected: Bool, with color: UIColor = .red01) {
    self.backgroundColor = isSelected ? color : nil
    self.imageView.alpha = isSelected ? 0.5 : 1.0
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
  }
  
  func makeConstraints() {
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

public class PhotoAssetGridViewController: UIViewController {
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
  private var photos: PHFetchResult<PHAsset>?
  private let scale = UIScreen.main.scale
  private var thumbnailSize = CGSize.zero
  
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
}

// UICollectionView DataSource Method
extension PhotoAssetGridViewController: UICollectionViewDataSource {
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
    
    cell.identifier = asset.localIdentifier
    
    PHImageManager.default().requestImage(
      for: asset,
      targetSize: thumbnailSize,
      contentMode: .aspectFill,
      options: nil
    ) { image, _ in
      if cell.identifier == asset.localIdentifier {
        cell.setImage(to: image)
      }
    }
    
    return cell
  }
}

// UICollectionView Flow Layout Delegate Method
extension PhotoAssetGridViewController: UICollectionViewDelegateFlowLayout {
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

private extension PhotoAssetGridViewController {
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
extension PhotoAssetGridViewController: PHPhotoLibraryChangeObserver {
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
private extension PhotoAssetGridViewController {
  func configureUI() {
    view.backgroundColor = .systemBackground
    configureHierarchy()
    makeConstraints()
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
