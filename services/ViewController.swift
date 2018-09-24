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

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet var imageView: UIImageView!
    
    var services: [Service] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Services"
        //self.imageView.addBlurEffect()
        
        self.collectionView.backgroundColor = UIColor.clear
        //self.collectionView.backgroundView = UIView.init(frame: CGRect.zero)
        
        self.collectionView.register(UINib.init(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = (UIScreen.main.bounds.size.width/2) - 15
            let height = (UIScreen.main.bounds.size.height/4)
            flowLayout.itemSize = CGSize(width: width, height: height)
        }
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell", for: indexPath) as! ServiceCollectionViewCell
        configureCell(cell: cell, forItemAtIndexPath: indexPath)
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionViewLayout.collectionViewContentSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }*/
    
    func configureCell(cell: ServiceCollectionViewCell, forItemAtIndexPath: IndexPath) {
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.titleLabel.text = self.services[forItemAtIndexPath.item].name
    }
}

