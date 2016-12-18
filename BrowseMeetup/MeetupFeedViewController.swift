//
//  MeetupFeedViewController.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/13/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import AsyncDisplayKit

final class MeetupFeedViewController: ASViewController<ASTableNode> {
    
    var _tableNode: ASTableNode
    
    ///--------------------------------------
    // MARK - Life Cycle
    ///--------------------------------------
    
    init() {
        _tableNode = ASTableNode()
        super.init(node: _tableNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
