//
//  Rewiew.swift
//  BestBar
//
//  Created by Chris McLearnon on 24/10/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import Foundation

struct Review {
    var name: String
    var rating: Double
    var review: String
    var heading: String
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "rating": rating,
            "review": review,
            "heading": heading ]
    }
}

extension Review {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let rating = dictionary["rating"] as? Double,
            let review = dictionary["review"] as? String,
            let heading = dictionary["heading"] as? String
            else { return nil }
        
        self.init(name: name,
                  rating: rating,
                  review: review,
                  heading: heading)
    }
}

class ReviewList: NSObject {
    static var reviewList: [Review] = []
    
    static var count: Int {
        return ReviewList.reviewList.count
    }
    
    public static func orderAtIndex(index: Int) -> Review {
        return ReviewList.reviewList[index]
    }
    
    func populateList(map: [Review]) {
        ReviewList.reviewList = []
        for item in map {
            ReviewList.reviewList.append(item)
        }
    }
    
    func printContents() {
        for item in ReviewList.reviewList {
            print("- Review: \(item)\n")
        }
    }
}
