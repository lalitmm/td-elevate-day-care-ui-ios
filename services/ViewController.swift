//
//  ViewController.swift
//  services
//
//  Created by Akhlaq Rao on 9/22/18.
//  Copyright © 2018 BMO. All rights reserved.
//

import UIKit

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

class ViewController: UICollectionViewController {

    @IBOutlet var imageView: UIImageView!
    
    var services: [Service] = []
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Services"
        self.imageView.addBlurEffect()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 190, height: 190)
        self.collectionView?.collectionViewLayout = layout
        
        ServicesManager.shared.getServices { (services, error) in
            self.services = services!
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.services.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        configureCell(cell: cell, forItemAtIndexPath: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "collectionCell", for: indexPath) as UICollectionReusableView
        return view
    }
    
    //MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if indexPath.row == 0 {
            let childCareViewController = storyBoard.instantiateViewController(withIdentifier: "childCareView") as! ChildCareViewController
            childCareViewController.title = self.services[indexPath.row].name
            self.navigationController?.pushViewController(childCareViewController, animated: true)
        }else {
            let underConstructionViewController = storyBoard.instantiateViewController(withIdentifier: "underConstructionView") as! UnderConstructionViewController
            underConstructionViewController.title = self.services[indexPath.row].name
            self.navigationController?.pushViewController(underConstructionViewController, animated: true)
        }
        self.collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10); //UIEdgeInsetsMake(topMargin, left, bottom, right);
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.collectionViewLayout.collectionViewContentSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) ->
        CGFloat {
            return 30.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 30.0
    }
    
    func configureCell(cell: UICollectionViewCell, forItemAtIndexPath: IndexPath) {
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.backgroundColor = UIColor(displayP3Red: 42/255.0, green: 86/255.0, blue: 130/255.0, alpha: 1.0)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: layout.itemSize.width, height: layout.itemSize.height))
        label.text = self.services[forItemAtIndexPath.item].name
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.addSubview(label)
    }
}

