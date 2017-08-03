//
//  DetailViewController.swift
//  pixabayImages
//
//  Created by Suresh Rajalingam on 01/08/2017.
//  Copyright © 2017 Suresh Rajalingam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var selectedElementsCollectionView: UICollectionView!
    
    var selectedHitsArray:NSArray! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedElementsCollectionView.delegate = self
        self.selectedElementsCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items = self.selectedHitsArray {
            return items.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hitCell", for: indexPath) as! HitCollectionViewCell
        let hit = self.selectedHitsArray.object(at: indexPath.row) as! Hit
        
        cell.hitImageView.downloadImageFrom(link: "\(hit.previewURL!)", contentMode: UIViewContentMode.scaleAspectFit)
        return cell
       
    }


}
