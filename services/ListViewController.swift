//
//  ListViewController.swift
//  services
//
//  Created by Akhlaq Rao on 9/23/18.
//  Copyright © 2018 BMO. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var childCareService: [Artwork] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        ServicesManager.shared.getChildCareService { (artWorks, error) in
            self.childCareService = artWorks!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.childCareService.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! ChildCareTableViewCell
        
        let text = childCareService[indexPath.row] //2.
        
        cell.name.text = text.locationName //3.
        cell.address.text = text.streetNumber + " " + text.streetName + " " + text.postalCode //3.
        cell.phoneNumber.text = text.phoneNumber
        cell.waitList.text = "Wait: " + text.waitList + "   Available : " + text.availList + "   Total: " + text.totalList
        
        return cell //4.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
}
