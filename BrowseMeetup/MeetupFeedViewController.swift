//
//  MeetupFeedViewController.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/13/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import AsyncDisplayKit

final class MeetupFeedViewController: ASViewController<ASTableNode>,ASTableDelegate,ASTableViewDataSource,MeetupFeedInteractorOutput {
    
    var _activityIndicatorView: UIActivityIndicatorView!
    
    var _groups: [Group]?
    var handler: MeetupFeedInteractorInput?
    
    var tableNode: ASTableNode {
        return node
    }
    
    ///--------------------------------------
    // MARK - Life Cycle
    ///--------------------------------------
    
    init() {
        super.init(node: ASTableNode())
        setupInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        _activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        _activityIndicatorView.hidesWhenStopped = true
        _activityIndicatorView.sizeToFit()
        
        let boundSize = self.view.bounds.size
        var refreshRect = _activityIndicatorView.frame
        refreshRect.origin = CGPoint(x: (boundSize.width - _activityIndicatorView.frame.width) / 2.0, y: _activityIndicatorView.frame.midY)
        
        _activityIndicatorView.frame = refreshRect
        view.addSubview(_activityIndicatorView)
        
        tableNode.view.allowsSelection = false
        tableNode.view.separatorStyle = UITableViewCellSeparatorStyle.none
        
        _activityIndicatorView.startAnimating()
        handler?.findGroupItemsNearby()
    }
    
    ///--------------------------------------
    // MARK - Interactor Output
    ///--------------------------------------
    
    func foundGroupItems(_ groups: [Group]?, error: Error?) {
        guard error == nil else { return }
        
        _groups = groups
        insertNewRowsInTableView(newGroups: groups!)
    }
    
    ///--------------------------------------
    // MARK - Table Data Source
    ///--------------------------------------
    
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
    
    ///--------------------------------------
    // MARK - Helper Methods
    ///--------------------------------------

    func insertNewRowsInTableView(newGroups: [Group]) {
        let section = 0
        var indexPaths = [IndexPath]()
        
        newGroups.enumerated().forEach { (row, group) in
            let path = IndexPath(row: row, section: section)
            indexPaths.append(path)
        }
        
        tableNode.view.insertRows(at: indexPaths, with: .none)
        _activityIndicatorView.stopAnimating()
    }
    
    func setupInitialState() {
        title = "Browse Meetup"
        
        tableNode.dataSource = self
        tableNode.delegate = self
    }
}
