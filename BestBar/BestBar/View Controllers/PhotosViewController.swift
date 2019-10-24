//
//  PhotosViewController.swift
//  BestBar
//
//  Created by Chris McLearnon on 16/09/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import UIKit
import Nuke
import Firebase

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!

    var imageCollectionURLs: [String] = []
    var barID: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchPhotos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.backgroundColor = #colorLiteral(red: 0.09410236031, green: 0.09412645549, blue: 0.09410081059, alpha: 1)
        // Do any additional setup after loading the view.
        print("Image count: \(imageCollectionURLs.count)")
    }
    
    func fetchPhotos() {
        let db = Firestore.firestore()
        let dbCall = "belfast/\(barID!)"
                
        db.document(dbCall).getDocument() { (documentSnapshot, err) in
            guard let document = documentSnapshot?.data() else {
                print("Error retrieving reviews: \(err!)")
                return
            }
                    
            let urlArray = document["imageCollectionURLs"] as! [String]
            self.imageCollectionURLs = urlArray
            print("BAR DETAIL IMAGE COUNT: \(self.imageCollectionURLs.count)")
                    
            DispatchQueue.main.async {
                self.imageCollectionURLs = urlArray
                print("BAR DETAIL IMAGE COUNT: \(self.imageCollectionURLs.count)")
                self.photosCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollectionURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BarPhotoCell", for: indexPath) as! BarPhotoCell
        Nuke.loadImage(with: URL(string: imageCollectionURLs[indexPath.row])!, into: cell.photoView)
        cell.layer.cornerRadius = 12
        
        return cell
    }

}
