//
//  MeetupService.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/23/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import Foundation

typealias JSONDictionary = Dictionary<String,Any>

final class MeetupService {
    
    var baseUrl: String = "https://api.meetup.com/"
    lazy var session: URLSession = URLSession.shared
    
    func fetchMeetupGroupInLocation(latitude: Double, longitude: Double, completion: @escaping (_ results: [JSONDictionary]?, _ error: Error?) -> ()) {
        guard let url = URL(string: "\(baseUrl)find/groups?&lat=\(latitude)&lon=\(longitude)&page=10&key=\(MeetupApiKey)") else {
            fatalError()
        }
        
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                do {
                    let results = try JSONSerialization.jsonObject(with: data!) as? [JSONDictionary]
                    completion(results, nil);
                    
                } catch let underlyingError {
                    completion(nil, underlyingError);
                }
            })
        }.resume()
    }
}
