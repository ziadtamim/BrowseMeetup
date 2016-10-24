//
//  MeetupService.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/23/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import Foundation

fileprivate let MeetupApiKey = "1f5718c16a7fb3a5452f45193232"

typealias JSONDictionary = Dictionary<String,Any>

final class MeetupService {
    
    let baseUrl: String = "https://api.meetup.com/"
    
    func fetchMeetupGroupInLocation(latitude: Double, longitude: Double, completion: @escaping (_ results: [JSONDictionary]?, _ error: Error?) -> ()) {
        let url = URL(string: "\(baseUrl)find/groups?&lat=\(latitude)&lon=\(longitude)&page=10&key=\(MeetupApiKey)")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                guard error == nil else { completion(nil, error); return }
                
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
