//
//  ViewController.swift
//  pixabayImages
//
//  Created by Suresh Rajalingam on 01/08/2017.
//  Copyright © 2017 Suresh Rajalingam. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, RequestManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var resultsImageCollectionView: UICollectionView!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var validButton: UIButton!
    
    private var requestManager = RequestManager()
    private var hitsObjects:NSMutableArray!
    private var selectedElements = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestManager.delegate = self
        searchTextfield.delegate = self
        
        self.resultsImageCollectionView.delegate = self
        self.resultsImageCollectionView.dataSource = self
        self.resultsImageCollectionView.allowsMultipleSelection = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        guard let searchedElements = self.searchTextfield.text else {return}
        
        //make research for elements
        self.selectedElements.removeAllObjects()
        requestManager.searchForElements(elements: searchedElements)
        
    }
    
    @IBAction func validButtonTapped(_ sender: Any) {
        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        let hitsArray = NSMutableArray()
        
        for (hitID, hitURL) in selectedElements {
           let hit = Hit()
            hit.id = Int((hitID as! String))
            hit.previewURL = hitURL as? String
            hitsArray.add(hit)
        }
                
        
        detailsViewController?.selectedHitsArray = hitsArray
          DispatchQueue.main.async() {
            if self.selectedElements.count >= 2 {
        self.navigationController?.pushViewController(detailsViewController!, animated: true)
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hitCell", for: indexPath) as! HitCollectionViewCell
        cell.layer.borderWidth = 0.0
        cell.layer.borderColor = UIColor.clear.cgColor
        
        let hit = self.hitsObjects.object(at: indexPath.row) as! Hit
        
        cell.hitImageView.downloadImageFrom(link: "\(hit.previewURL!)", contentMode: UIViewContentMode.scaleAspectFit)
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.gray.cgColor
        
        let hitSelected = self.hitsObjects.object(at: indexPath.row) as! Hit
        
        if let hitID = hitSelected.id, let hitPreviewURL = hitSelected.previewURL {
            self.selectedElements.setValue("\(hitPreviewURL)", forKey: "\(hitID)")
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.0
        cell?.layer.borderColor = UIColor.clear.cgColor
        let hitSelected = self.hitsObjects.object(at: indexPath.row) as! Hit
        
        if let hitID = hitSelected.id{
            self.selectedElements.removeObject(forKey: "\(hitID)")
        }

    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        if let hits = self.hitsObjects {
            return hits.count
        }
        return 0
    }
    

    
    func requestManager(receivedData: Data) {
        let parser = DataParser()
        let parsedData = parser.parseJSON(data: receivedData)
        
        guard let hitsData = parsedData else {return}
        
        guard let hitsArray = hitsData["hits"] as? NSArray else {return}
        
        self.hitsObjects = NSMutableArray()
        
        for hitDictionnary in hitsArray {
            let hit = Hit(hitData: hitDictionnary as! NSDictionary)
            self.hitsObjects.add(hit)
        }
        
        DispatchQueue.main.async() {
            self.resultsImageCollectionView.reloadData()
        }
    }
    
    func requestManager(receivedError: Error) {
        //UIAlertController
        print(receivedError)
    }
    
    func requestManager(receivedResponse: URLResponse) {
        print(receivedResponse)
    }
    
    
    
}

