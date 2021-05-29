//
//  UserRepository.swift
//  iOS Task
//
//  Created by Touhid on 21/5/21.
//

import Foundation


class UserRepository {
    
    // ===================================
    // MARK: - Get users list
    // ===================================
    public func userList(action: @escaping (ReqStatus, UserModel?, Error?) -> Void) {
        
        action(ReqStatus.START, nil, nil)
        let mJson: [String: String] = [:]
        let urlReq = getUrlRequest(mUrl: AllApi.USERS_LIST, mMethod: ReqMethods.GET, json: mJson)
        URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            guard let data = data, error == nil else {
                action(ReqStatus.ERROR, nil, error)
                return
            }
            do {
                let responseModel = try JSONDecoder().decode(UserModel.self, from: data)
                NSLog("USER: \(responseModel)", "")
                action(ReqStatus.SUCCESS, responseModel, nil)
            } catch let err {
                print(err)
                action(ReqStatus.ERROR, nil, err)
            }
        }.resume()
        
    } // userList
    
}
