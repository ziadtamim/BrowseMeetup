//
//  MeetupFeedViewController.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/13/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import AsyncDisplayKit

final class MeetupFeedViewController: ASViewController<ASTableNode>,ASTableDelegate,ASTableViewDataSource,MeetupFeedInteractorOutput {
    
    var _groups: [Group]?
    
    var handler: MeetupFeedInteractorInput?
    
    var tableNode: ASTableNode {
        return node
    }
    
    init() {
        super.init(node: ASTableNode())
        setupInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        handler?.findGroupItemsNearby()
    }
    
    func setupInitialState() {
        title = "Browse Meetup"
        
        tableNode.dataSource = self
        tableNode.delegate = self
    }
    
    func foundGroupItems(_ groups: [Group]?, error: Error?) {
        guard error == nil else { return }
        
        _groups = groups
        insertNewRowsInTableView(newGroups: groups!)
    }
    
    func insertNewRowsInTableView(newGroups: [Group]) {
        let section = 0
        var indexPaths = [IndexPath]()
        
        newGroups.enumerated().forEach { (row, group) in
            let path = IndexPath(row: row, section: section)
            indexPaths.append(path)
        }
        
        tableNode.view.insertRows(at: indexPaths, with: .none)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _groups?.count ?? 0
    }
    
    func tableView(_ tableView: ASTableView, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let group = _groups![indexPath.row]
        
        let cellNodeBlock = { () -> ASCellNode in
            let cell = GroupCellNode(group: group)
            return cell
        }
        return cellNodeBlock
    }

}
