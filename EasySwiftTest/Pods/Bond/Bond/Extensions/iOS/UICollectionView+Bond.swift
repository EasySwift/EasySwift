//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Srdan Rasic (@srdanrasic)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

@objc public protocol BNDCollectionViewProxyDataSource {
  @objc optional func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> UICollectionReusableView
  @objc optional func collectionView(_ collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: IndexPath) -> Bool
  @objc optional func collectionView(_ collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: IndexPath, toIndexPath destinationIndexPath: IndexPath)

  /// Override to specify reload or update
  @objc optional func shouldReloadInsteadOfUpdateCollectionView(_ collectionView: UICollectionView) -> Bool
}

private class BNDCollectionViewDataSource<T>: NSObject, UICollectionViewDataSource {
  
  fileprivate let array: ObservableArray<ObservableArray<T>>
  fileprivate weak var collectionView: UICollectionView!
  fileprivate let createCell: (IndexPath, ObservableArray<ObservableArray<T>>, UICollectionView) -> UICollectionViewCell
  fileprivate weak var proxyDataSource: BNDCollectionViewProxyDataSource?
  fileprivate let sectionObservingDisposeBag = DisposeBag()
  
  fileprivate init(array: ObservableArray<ObservableArray<T>>, collectionView: UICollectionView, proxyDataSource: BNDCollectionViewProxyDataSource?, createCell: @escaping (IndexPath, ObservableArray<ObservableArray<T>>, UICollectionView) -> UICollectionViewCell) {
    self.collectionView = collectionView
    self.createCell = createCell
    self.proxyDataSource = proxyDataSource
    self.array = array
    super.init()
    
    collectionView.dataSource = self
    collectionView.reloadData()
    setupPerSectionObservers()
    
    array.observeNew { [weak self] arrayEvent in
      guard let unwrappedSelf = self, let collectionView = unwrappedSelf.collectionView else { return }

      if let reload = unwrappedSelf.proxyDataSource?.shouldReloadInsteadOfUpdateCollectionView?(collectionView) , reload {
        collectionView.reloadData()
      } else {
        switch arrayEvent.operation {
        case .batch(let operations):
          collectionView.performBatchUpdates({
            for operation in changeSetsFromBatchOperations(operations) {
              BNDCollectionViewDataSource.applySectionUnitChangeSet(operation, collectionView: collectionView)
            }
            }, completion: nil)
        case .reset:
          collectionView.reloadData()
        default:
          BNDCollectionViewDataSource.applySectionUnitChangeSet(arrayEvent.operation.changeSet(), collectionView: collectionView)
        }
      }

      unwrappedSelf.setupPerSectionObservers()
    }.disposeIn(bnd_bag)
  }
  
  fileprivate func setupPerSectionObservers() {
    sectionObservingDisposeBag.dispose()
    
    for (sectionIndex, sectionObservableArray) in array.enumerated() {
      sectionObservableArray.observeNew { [weak collectionView, weak proxyDataSource] arrayEvent in
        guard let collectionView = collectionView else { return }
        if let reload = proxyDataSource?.shouldReloadInsteadOfUpdateCollectionView?(collectionView) , reload { collectionView.reloadData(); return }

        switch arrayEvent.operation {
        case .batch(let operations):
          collectionView.performBatchUpdates({
            for operation in changeSetsFromBatchOperations(operations) {
              BNDCollectionViewDataSource.applyRowUnitChangeSet(operation, collectionView: collectionView, sectionIndex: sectionIndex)
            }
          }, completion: nil)
        case .reset:
          collectionView.reloadSections(IndexSet(integer: sectionIndex))
        default:
          BNDCollectionViewDataSource.applyRowUnitChangeSet(arrayEvent.operation.changeSet(), collectionView: collectionView, sectionIndex: sectionIndex)
        }
      }.disposeIn(sectionObservingDisposeBag)
    }
  }
  
  fileprivate class func applySectionUnitChangeSet(_ changeSet: ObservableArrayEventChangeSet, collectionView: UICollectionView) {
    switch changeSet {
    case .inserts(let indices):
      collectionView.insertSections(IndexSet(set: indices))
    case .updates(let indices):
      collectionView.reloadSections(IndexSet(set: indices))
    case .deletes(let indices):
      collectionView.deleteSections(IndexSet(set: indices))
    }
  }
  
  fileprivate class func applyRowUnitChangeSet(_ changeSet: ObservableArrayEventChangeSet, collectionView: UICollectionView, sectionIndex: Int) {
    switch changeSet {
    case .inserts(let indices):
      let indexPaths = indices.map { IndexPath(item: $0, section: sectionIndex) }
      collectionView.insertItems(at: indexPaths)
    case .updates(let indices):
      let indexPaths = indices.map { IndexPath(item: $0, section: sectionIndex) }
      collectionView.reloadItems(at: indexPaths)
    case .deletes(let indices):
      let indexPaths = indices.map { IndexPath(item: $0, section: sectionIndex) }
      collectionView.deleteItems(at: indexPaths)
    }
  }
  
  /// MARK - UICollectionViewDataSource
  
  @objc func numberOfSections(in collectionView: UICollectionView) -> Int {
    return array.count
  }
  
  @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return array[section].count
  }
  
  @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return createCell(indexPath, array, collectionView)
  }
  
  @objc func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if let view = proxyDataSource?.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, atIndexPath: indexPath) {
      return view
    } else {
      fatalError("Dear Sir/Madam, your collection view has asked for a supplementary view of a \(kind) kind. Please provide a proxy data source object in bindTo() method that implements `collectionView(collectionView:viewForSupplementaryElementOfKind:atIndexPath)` method!")
    }
  }
  
  @objc func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    return proxyDataSource?.collectionView?(collectionView, canMoveItemAtIndexPath: indexPath) ?? false
  }
  
  @objc func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    proxyDataSource?.collectionView?(collectionView, moveItemAtIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
  }
}

extension UICollectionView {
  fileprivate struct AssociatedKeys {
    static var BondDataSourceKey = "bnd_BondDataSourceKey"
  }
}

public extension EventProducerType where
  EventType: ObservableArrayEventType,
  EventType.ObservableArrayEventSequenceType.Iterator.Element: EventProducerType,
  EventType.ObservableArrayEventSequenceType.Iterator.Element.EventType: ObservableArrayEventType {
  
  fileprivate typealias ElementType = EventType.ObservableArrayEventSequenceType.Iterator.Element.EventType.ObservableArrayEventSequenceType.Iterator.Element
  
  public func bindTo(_ collectionView: UICollectionView, proxyDataSource: BNDCollectionViewProxyDataSource? = nil, createCell: (IndexPath, ObservableArray<ObservableArray<ElementType>>, UICollectionView) -> UICollectionViewCell) -> DisposableType {
    
    let array: ObservableArray<ObservableArray<ElementType>>
    if let downcastedObservableArray = self as? ObservableArray<ObservableArray<ElementType>> {
      array = downcastedObservableArray
    } else {
      array = self.map { $0.crystallize() }.crystallize()
    }
    
    let dataSource = BNDCollectionViewDataSource(array: array, collectionView: collectionView, proxyDataSource: proxyDataSource, createCell: createCell)
    collectionView.dataSource = dataSource
    objc_setAssociatedObject(collectionView, &UICollectionView.AssociatedKeys.BondDataSourceKey, dataSource, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    
    return BlockDisposable { [weak collectionView] in
      if let collectionView = collectionView {
        objc_setAssociatedObject(collectionView, &UICollectionView.AssociatedKeys.BondDataSourceKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
}
