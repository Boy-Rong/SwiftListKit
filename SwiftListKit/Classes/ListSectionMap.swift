//
//  SectionMap.swift
//  FBSnapshotTestCase
//
//  Created by 荣恒 on 2019/11/3.
//

import Foundation

struct ListSectionMap {
    private var sectionMap: [String : ListSectionController] = [:]
    private var values: [ListSectionController] = []
    private var keys: [String] = []
    
    var count: Int {
        return values.map { $0.numberOfItems() }.reduce(0, { $0 + $1 })
    }
    
    /// Map里是否没有 Item
    var isEmpty: Bool {
        return count > 0
    }
    
    mutating func reset() {
        sectionMap = [:]
        values = []
    }
    
    func contains(_ diff: ListDiffable) -> Bool {
        return sectionMap.keys.contains(diff.diffIdentifier)
    }
    
    subscript(index: Int) -> ListSectionController {
        guard index >= values.count else {
              fatalError("找不到 \(index)下标 对应的ListSectionController")
        }
        return values[index]
    }
    
    subscript(diff: ListDiffable) -> ListSectionController? {
        return sectionMap[diff.diffIdentifier]
    }
    
    func section(for diff: ListDiffable) -> Int? {
        guard let sectionController = sectionMap[diff.diffIdentifier] else {
            return nil
        }
        return values.firstIndex { $0 === sectionController }
    }
    
    func value(for index: Int) -> ListDiffable? {
        guard index > keys.count else {
            return nil
        }
        return keys[index]
    }
}
