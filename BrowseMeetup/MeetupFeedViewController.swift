//
//  MeetupFeedViewController.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/13/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import AsyncDisplayKit

final class MeetupFeedViewController: ASViewController<ASTableNode>,MeetupFeedInteractorOutput {
    
    var _activityIndicatorView: UIActivityIndicatorView!
    var dataProvider: MeetupFeedTableDataProvider!
    var handler: MeetupFeedInteractorInput?
    var tableNode: ASTableNode
    
    ///--------------------------------------
    // MARK - Life Cycle
    ///--------------------------------------
    
    init() {
        
        tableNode = ASTableNode()
        super.init(node: tableNode)
        setupInitialState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        _activityIndicatorView.hidesWhenStopped = true
        _activityIndicatorView.sizeToFit()
        
        let boundSize = view.bounds.size
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
        
        dataProvider.insertNewGroupsInTableView(groups!)
        _activityIndicatorView.stopAnimating()
    }
    
    ///--------------------------------------
    // MARK - Helper Methods
    ///--------------------------------------
    
    func setupInitialState() {
        title = "Browse Meetup"
        
        dataProvider = MeetupFeedTableDataProvider()
        dataProvider.tableNode = tableNode
        tableNode.dataSource = dataProvider
    }
}
