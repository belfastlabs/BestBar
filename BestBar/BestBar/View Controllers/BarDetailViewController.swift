//
//  BarDetailViewController.swift
//  BestBar
//
//  Created by Chris McLearnon on 13/09/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import UIKit
import Firebase

class BarDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //@IBOutlet weak var contentViewHeader: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bestBitsCollectionView: UICollectionView!
    
    //var bestBitsArray = ["Rooftop Bar", "Dog Friendly", "Beer Garden", "Lots of Gin"]
    var bestBitsArray: [String] = []
    var barTitle: String = ""
    var barSubtitle: String = ""
    var barID: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        bestBitsArray = []
        fetchBestBits()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = barTitle
        subtitleLabel.text = barSubtitle
        // Do any additional setup after loading the view.
        //contentViewHeader.layer.cornerRadius = 16
        bestBitsCollectionView.delegate = self
        bestBitsCollectionView.dataSource = self
    }
    
    func fetchBestBits() {
        let db = Firestore.firestore()
        let dbCall = "belfast/\(barID!)"
        
        db.document(dbCall).getDocument() { (documentSnapshot, err) in
            guard let document = documentSnapshot?.data() else {
                print("Error retrieving reviews: \(err!)")
                return
            }
            
            self.bestBitsArray = document["bestBits"] as! [String]
            self.bestBitsCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestBitsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestBitsCell", for: indexPath) as! BestBitsCell
        cell.bestBitLabel.text = bestBitsArray[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        flowLayout.minimumLineSpacing = 0
        
        return CGSize(width: size, height: size/2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        var containerViewController: ReviewsViewController?
//        if let vc = segue.destination as? ReviewsViewController {
//            vc.barID = self.barID
//        }
        
        if segue.identifier == "Reviews" {
            containerViewController = segue.destination as? ReviewsViewController
            containerViewController?.barID = barID!
        }
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
