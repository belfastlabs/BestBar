//
//  ReviewsViewController.swift
//  BestBar
//
//  Created by Chris McLearnon on 24/10/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import UIKit
import Firebase

class ReviewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    
    var barID: String?
    var reviewList = ReviewList()
    
    private var listener: ListenerRegistration?
    
    override func viewWillAppear(_ animated: Bool) {
        fetchReviews()
        reviewList.printContents()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
        print("BAR ID: \(barID!)")
        // Do any additional setup after loading the view.
        //fetchReviews()
        reviewsCollectionView.reloadData()
        //reviewList.printContents()
    }
    
    func fetchReviews() {
        let dbCall = "belfast/\(barID!)/reviews"
        let db = Firestore.firestore()
        print("DBCALL: \(dbCall)")
        
        db.collection(dbCall).addSnapshotListener() { (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else {
                print("Error retrieving reviews: \(err!)")
                return
            }
            
            let reviewMap = documents.compactMap({
                $0.data().flatMap({ (data) in
                    return Review(dictionary: data)
                })
            })
            
            DispatchQueue.main.async {
                self.reviewList.populateList(map: reviewMap)
                self.reviewsCollectionView.reloadData()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ReviewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        
        cell.layer.cornerRadius = 12
        cell.rating.rating = ReviewList.reviewList[indexPath.row].rating
        cell.reviewHeadingLabel.text = ReviewList.reviewList[indexPath.row].heading
        cell.reviewText.text = ReviewList.reviewList[indexPath.row].review
        
        
//        cell.rating.rating = 4.5
//        cell.reviewHeadingLabel.text = "BEST BAR EVER"
//        cell.reviewText.text = "Oh i love this bar so much its so much fun ahhhhh"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 398, height: 267)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UILabel
{
var optimalHeight : CGFloat
    {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 4
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text

            label.sizeToFit()

            return label.frame.height
         }
    }
}
