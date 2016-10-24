//
//  ApplicationConfigurator.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/24/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import UIKit

final class ApplicationConfigurator {
    
    weak var feedVC: MeetupFeedViewController?
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        let feedVC  = MeetupFeedViewController()
        let feedNavCtrl = UINavigationController(rootViewController: feedVC)
        window.rootViewController  = feedNavCtrl
        
        self.feedVC = feedVC
        
        configure()
    }
    
    fileprivate func configure() {
        let locationService = LocationService()
        let meetupService = MeetupService()
        
        let dataManager = MeetupFeedDataManager(meetupService: meetupService, locationService: locationService)
        let interactor = MeetupFeedInteractor()
        
        feedVC?.handler = interactor
        
        interactor.dataManager = dataManager
        interactor.output = feedVC
    }
}
