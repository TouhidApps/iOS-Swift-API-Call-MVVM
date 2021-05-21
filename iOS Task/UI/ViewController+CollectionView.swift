//
//  ViewController+CollectionView.swift
//  iOS Task
//
//  Created by Touhid on 21/5/21.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.myCV.frame.size.width) / 5
        let height = width // * 1.05 //ratio
        return CGSize(width: width-10, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsCell", for: indexPath) as! FriendsCell

        // Decoration
        cell.layer.borderWidth   = 1
        cell.layer.borderColor   = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.layer.cornerRadius  = 15
        cell.layer.masksToBounds = true
        
        cell.imageView.layer.borderWidth   = 1
        cell.imageView.layer.borderColor   = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.imageView.layer.cornerRadius  = 55
        cell.imageView.layer.masksToBounds = true
        
        let user = self.users[indexPath.row]
        
        cell.labelName.text = "\(user.name.first) \(user.name.last)"
        cell.labelCountry.text = user.location.country
        
        if let mUrl = URL(string: user.picture.large) {
            cell.imageView.load(url: mUrl)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.user = self.users[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    

}
