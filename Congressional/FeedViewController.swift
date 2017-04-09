//
//  FeedViewController.swift
//  Congressional
//
//  Created by Celine Yan on 4/9/17.
//  Copyright © 2017 Ayman Ahmed. All rights reserved.
//

import UIKit
import FirebaseAuth

class FeedViewController: UIViewController {

    @IBOutlet weak var BillCardCell: UICollectionViewCell!
    @IBOutlet weak var followB: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    let reuseIdentifier = "card" // also enter this string as the cell identifier in the storyboard
    var items = [String]()
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! BillCardCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if user == nil {
                self.performSegue(withIdentifier: "feedGate", sender: self)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
