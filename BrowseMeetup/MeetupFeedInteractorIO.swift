//
//  MeetupFeedIO.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/24/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import Foundation

protocol MeetupFeedInteractorInput {
    func findGroupItemsNearby ()
}

protocol MeetupFeedInteractorOutput {
    func foundGroupItems (_ groups: [Group]?, error: Error?)
}
