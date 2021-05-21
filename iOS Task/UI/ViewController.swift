//
//  ViewController.swift
//  iOS Task
//
//  Created by Touhid on 21/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myCV: UICollectionView!
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    private let userViewModel = UserViewModel()
    
    var users : [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.stopAnimating()
        
        myCV.delegate   = self
        myCV.dataSource = self
        
        userViewModel.userViewModelDelegate = self

        // Call api to load user data
        userViewModel.userList()
        
    } // viewDidLoad


}


extension ViewController: UserViewModelDelegate {
    
    // Handle user data after loading
    func userList(status: ReqStatus, userModel: UserModel?, err: Error?) {
        
        switch status {
        case ReqStatus.START:
            indicator.startAnimating()
            
            break
            
        case ReqStatus.SUCCESS:
            indicator.stopAnimating()
            
            if let mData = userModel?.results {
                self.users.removeAll()
                self.users = mData
            }
            myCV.reloadData()
            
            break
            
        case ReqStatus.ERROR:
            indicator.stopAnimating()
            
            break
            
        } // switch
        
    } // userList
    
    
    
    
    
}
