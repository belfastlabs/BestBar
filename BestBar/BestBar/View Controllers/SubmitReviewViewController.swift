//
//  SubmitReviewViewController.swift
//  BestBar
//
//  Created by Chris McLearnon on 24/10/2019.
//  Copyright © 2019 BelfastLabs. All rights reserved.
//

import UIKit
import Firebase
import Cosmos

class SubmitReviewViewController: UIViewController {

    @IBOutlet weak var nameTextVIew: UITextView!
    @IBOutlet weak var mainCommentTextView: UITextView!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var confView: UIView!
    
    var barID: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundBlur()
        confView.layer.cornerRadius = 12
        nameTextVIew.layer.cornerRadius = 12
        mainCommentTextView.layer.cornerRadius = 12
        reviewTextView.layer.cornerRadius = 12
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func submitReview(_ sender: Any) {
        if (nameTextVIew.text.isEmpty) || (mainCommentTextView.text.isEmpty) || (reviewTextView.text.isEmpty) {
            let alert = UIAlertController(title: "Cannot send Review", message: "Make sure all fields are filled in before sending.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            let db = Firestore.firestore()
            let dbCall = "belfast/\(barID!)/reviews"
            
            var ref: DocumentReference? = nil
            ref = db.collection(dbCall).addDocument(data: [
                "name": nameTextVIew.text,
                "heading": mainCommentTextView.text,
                "review": reviewTextView.text,
                "rating": ratingView.rating
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func addBackgroundBlur() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        self.view.insertSubview(blurEffectView, at: 0)
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
