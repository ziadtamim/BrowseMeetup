//
//  MeetupFeedDataManager.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/23/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import Foundation

final class MeetupFeedDataManager {
    
    fileprivate var _meetupService: MeetupService?
    fileprivate var _locationService: LocationService?
    
    init(meetupService: MeetupService, locationService: LocationService) {
       _meetupService = meetupService
       _locationService = locationService
    }
    
    func searchForGroupNearby(completion: @escaping ( _ groups: [Group]?, _ error: Error?) -> ()) {
        let coordinate = _locationService?.coordinate
        
        _meetupService?.fetchMeetupGroupInLocation(latitude: coordinate!.latitude, longitude: coordinate!.longitude, completion: { (results, error) in
            guard error == nil else { completion(nil, error); return }
            
            let groups = results?.flatMap(self.groupItemFromJSONDictionary)
            completion(groups, nil)
        })
    }
}

extension MeetupFeedDataManager {
    
    func groupItemFromJSONDictionary(_ entry: JSONDictionary) -> Group? {
        guard let created = entry["created"] as? Double, let city = entry["city"] as? String, let country = entry["country"] as? String, let keyPhoto = entry["key_photo"] as? JSONDictionary, let photoUrl = keyPhoto["photo_link"] as? String, let organizerJSON = entry["organizer"] as? JSONDictionary, let organizer = organizerItemFromJSONDictionary(organizerJSON) else {
            return nil
        }
        
        return Group(createdAt: created, photoUrl: URL(string: photoUrl), city: city, country: country, organizer: organizer)
    }
    
    func organizerItemFromJSONDictionary(_ entry: JSONDictionary) -> Organizer? {
        guard let name = entry["name"] as? String, let photo = entry["photo"] as? JSONDictionary, let thumbUrl = photo["thumb_link"] as? String else {
            return nil
        }
        
        return Organizer(name: name, thumbUrl: URL(string: thumbUrl))
    }
}
