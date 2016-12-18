//
//  MeetupFeedTableDataProvider.swift
//  BrowseMeetup
//
//  Created by Ziad on 12/18/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MeetupFeedTableDataProvider: NSObject, ASTableDataSource {
    
    var _groups: [Group]?
    weak var tableNode: ASTableNode?
    
    ///--------------------------------------
    // MARK - Table data source
    ///--------------------------------------
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return _groups?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let group = _groups![indexPath.row]
        let cellNodeBlock = { () -> ASCellNode in
            return GroupCellNode(group: group)
        }
        return cellNodeBlock
    }
    
    ///--------------------------------------
    // MARK - Helper Methods
    ///--------------------------------------
    
    func insertNewGroupsInTableView(_ groups: [Group]) {
        _groups = groups
        
        let section = 0
        var indexPaths = [IndexPath]()
        groups.enumerated().forEach { (row, group) in
            let path = IndexPath(row: row, section: section)
            indexPaths.append(path)
        }
        tableNode?.insertRows(at: indexPaths, with: .none)
    }
}
