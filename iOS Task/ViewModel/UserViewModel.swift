//
//  UserViewModel.swift
//  iOS Task
//
//  Created by Touhid on 21/5/21.
//

import Foundation

protocol UserViewModelDelegate : AnyObject {
    
    func userList(status: ReqStatus, userModel: UserModel?, err: Error?)
    
}

class UserViewModel {
    
    let userRepository = UserRepository()
    var userViewModelDelegate: UserViewModelDelegate?
    
    public func userList() {
        
        self.userRepository.userList { (status, userModel, err) in
            
            DispatchQueue.main.async {
                self.userViewModelDelegate?.userList(status: status, userModel: userModel, err: err)
            }
            
        }
    
    } // userList
    
}
