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

@objc public protocol BNDTableViewProxyDataSource {
  @objc optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
  @objc optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
  @objc optional func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: IndexPath) -> Bool
  @objc optional func tableView(_ tableView: UITableView, canMoveRowAtIndexPath indexPath: IndexPath) -> Bool
  @objc optional func sectionIndexTitlesForTableView(_ tableView: UITableView) -> [String]?
  @objc optional func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int
  @objc optional func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath)
  @objc optional func tableView(_ tableView: UITableView, moveRowAtIndexPath sourceIndexPath: IndexPath, toIndexPath destinationIndexPath: IndexPath)
  
  /// Override to specify reload or update
  @objc optional func shouldReloadInsteadOfUpdateTableView(_ tableView: UITableView) -> Bool
  
  /// Override to specify custom row animation when row is being inserted, deleted or updated
  @objc optional func tableView(_ tableView: UITableView, animationForRowAtIndexPaths indexPaths: [IndexPath]) -> UITableViewRowAnimation
  
  /// Override to specify custom row animation when section is being inserted, deleted or updated
  @objc optional func tableView(_ tableView: UITableView, animationForRowInSections sections: Set<Int>) -> UITableViewRowAnimation
}

private class BNDTableViewDataSource<T>: NSObject, UITableViewDataSource {
  
  fileprivate let array: ObservableArray<ObservableArray<T>>
  fileprivate weak var tableView: UITableView!
  fileprivate let createCell: (IndexPath, ObservableArray<ObservableArray<T>>, UITableView) -> UITableViewCell
  fileprivate weak var proxyDataSource: BNDTableViewProxyDataSource?
  fileprivate let sectionObservingDisposeBag = DisposeBag()
  
  fileprivate init(array: ObservableArray<ObservableArray<T>>, tableView: UITableView, proxyDataSource: BNDTableViewProxyDataSource?, createCell: @escaping (IndexPath, ObservableArray<ObservableArray<T>>, UITableView) -> UITableViewCell) {
    self.tableView = tableView
    self.createCell = createCell
    self.proxyDataSource = proxyDataSource
    self.array = array
    super.init()
    
    tableView.dataSource = self
    tableView.reloadData()
    setupPerSectionObservers()
    
    array.observeNew { [weak self] arrayEvent in
      guard let unwrappedSelf = self, let tableView = unwrappedSelf.tableView else { return }

      if let reload = unwrappedSelf.proxyDataSource?.shouldReloadInsteadOfUpdateTableView?(tableView) , reload {
        tableView.reloadData()
      } else {
        switch arrayEvent.operation {
        case .batch(let operations):
          tableView.beginUpdates()
          for diff in changeSetsFromBatchOperations(operations) {
            BNDTableViewDataSource.applySectionUnitChangeSet(diff, tableView: tableView, dataSource: unwrappedSelf.proxyDataSource)
          }
          tableView.endUpdates()
        case .reset:
          tableView.reloadData()
        default:
          BNDTableViewDataSource.applySectionUnitChangeSet(arrayEvent.operation.changeSet(), tableView: tableView, dataSource: unwrappedSelf.proxyDataSource)
        }
      }
      
      unwrappedSelf.setupPerSectionObservers()
    }.disposeIn(bnd_bag)
  }
  
  fileprivate func setupPerSectionObservers() {
    sectionObservingDisposeBag.dispose()

    for (sectionIndex, sectionObservableArray) in array.enumerated() {
      sectionObservableArray.observeNew { [weak tableView, weak self] arrayEvent in
        guard let tableView = tableView else { return }
        if let reload = self?.proxyDataSource?.shouldReloadInsteadOfUpdateTableView?(tableView) , reload { tableView.reloadData(); return }
        
        switch arrayEvent.operation {
        case .batch(let operations):
          tableView.beginUpdates()
          for diff in changeSetsFromBatchOperations(operations) {
            BNDTableViewDataSource.applyRowUnitChangeSet(diff, tableView: tableView, sectionIndex: sectionIndex, dataSource: self?.proxyDataSource)
          }
          tableView.endUpdates()
        case .reset:
          let indices = Set([sectionIndex])
          tableView.reloadSections(IndexSet(integer: sectionIndex), with: self?.proxyDataSource?.tableView?(tableView, animationForRowInSections: indices) ?? .automatic)
        default:
          BNDTableViewDataSource.applyRowUnitChangeSet(arrayEvent.operation.changeSet(), tableView: tableView, sectionIndex: sectionIndex, dataSource: self?.proxyDataSource)
        }
      }.disposeIn(sectionObservingDisposeBag)
    }
  }
  
  fileprivate class func applySectionUnitChangeSet(_ changeSet: ObservableArrayEventChangeSet, tableView: UITableView, dataSource: BNDTableViewProxyDataSource?) {
    switch changeSet {
    case .inserts(let indices):
      tableView.insertSections(IndexSet(set: indices), with: dataSource?.tableView?(tableView, animationForRowInSections: indices) ?? .automatic)
    case .updates(let indices):
      tableView.reloadSections(IndexSet(set: indices), with: dataSource?.tableView?(tableView, animationForRowInSections: indices) ?? .automatic)
    case .deletes(let indices):
      tableView.deleteSections(IndexSet(set: indices), with: dataSource?.tableView?(tableView, animationForRowInSections: indices) ?? .automatic)
    }
  }
  
  fileprivate class func applyRowUnitChangeSet(_ changeSet: ObservableArrayEventChangeSet, tableView: UITableView, sectionIndex: Int, dataSource: BNDTableViewProxyDataSource?) {
    switch changeSet {
    case .inserts(let indices):
      let indexPaths = indices.map { IndexPath(item: $0, section: sectionIndex) }
      tableView.insertRows(at: indexPaths, with: dataSource?.tableView?(tableView, animationForRowAtIndexPaths: indexPaths) ?? .automatic)
    case .updates(let indices):
      let indexPaths = indices.map { IndexPath(item: $0, section: sectionIndex) }
      tableView.reloadRows(at: indexPaths, with: dataSource?.tableView?(tableView, animationForRowAtIndexPaths: indexPaths) ?? .automatic)
    case .deletes(let indices):
      let indexPaths = indices.map { IndexPath(item: $0, section: sectionIndex) }
      tableView.deleteRows(at: indexPaths, with: dataSource?.tableView?(tableView, animationForRowAtIndexPaths: indexPaths) ?? .automatic)
    }
  }
  
  /// MARK - UITableViewDataSource
  
  @objc func numberOfSections(in tableView: UITableView) -> Int {
    return array.count
  }
  
  @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array[section].count
  }
  
  @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return createCell(indexPath, array, tableView)
  }
  
  @objc func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return proxyDataSource?.tableView?(tableView, titleForHeaderInSection: section)
  }
  
  @objc func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
      return proxyDataSource?.tableView?(tableView, titleForFooterInSection: section)
  }
  
  @objc func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return proxyDataSource?.tableView?(tableView, canEditRowAtIndexPath: indexPath) ?? false
  }
  
  @objc func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return proxyDataSource?.tableView?(tableView, canMoveRowAtIndexPath: indexPath) ?? false
  }
  
  @objc func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return proxyDataSource?.sectionIndexTitlesForTableView?(tableView)
  }
  
  @objc func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    if let section = proxyDataSource?.tableView?(tableView, sectionForSectionIndexTitle: title, atIndex: index) {
      return section
    } else {
      fatalError("Dear Sir/Madam, your table view has asked for section for section index title \(title). Please provide a proxy data source object in bindTo() method that implements `tableView(tableView:sectionForSectionIndexTitle:atIndex:)` method!")
    }
  }
  
  @objc func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    proxyDataSource?.tableView?(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
  }
  
  @objc func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    proxyDataSource?.tableView?(tableView, moveRowAtIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
  }
}

extension UITableView {
  fileprivate struct AssociatedKeys {
    static var BondDataSourceKey = "bnd_BondDataSourceKey"
  }
}

public extension EventProducerType where
  EventType: ObservableArrayEventType,
  EventType.ObservableArrayEventSequenceType.Iterator.Element: EventProducerType,
  EventType.ObservableArrayEventSequenceType.Iterator.Element.EventType: ObservableArrayEventType {
  
  fileprivate typealias ElementType = EventType.ObservableArrayEventSequenceType.Iterator.Element.EventType.ObservableArrayEventSequenceType.Iterator.Element
  
  public func bindTo(_ tableView: UITableView, proxyDataSource: BNDTableViewProxyDataSource? = nil, createCell: (IndexPath, ObservableArray<ObservableArray<ElementType>>, UITableView) -> UITableViewCell) -> DisposableType {
    
    let array: ObservableArray<ObservableArray<ElementType>>
    if let downcastedObservableArray = self as? ObservableArray<ObservableArray<ElementType>> {
      array = downcastedObservableArray
    } else {
      array = self.map { $0.crystallize() }.crystallize()
    }
    
    let dataSource = BNDTableViewDataSource(array: array, tableView: tableView, proxyDataSource: proxyDataSource, createCell: createCell)
    objc_setAssociatedObject(tableView, &UITableView.AssociatedKeys.BondDataSourceKey, dataSource, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    
    return BlockDisposable { [weak tableView] in
      if let tableView = tableView {
        objc_setAssociatedObject(tableView, &UITableView.AssociatedKeys.BondDataSourceKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
}
