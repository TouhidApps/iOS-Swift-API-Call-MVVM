//
//  DetailViewController.swift
//  iOS Task
//
//  Created by Touhid on 21/5/21.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController {
    
    @IBOutlet var ivPhoto: UIImageView!
    
    @IBOutlet var labelName    : UILabel!
    @IBOutlet var labelAddress : UILabel!
    @IBOutlet var labelEmail   : UILabel!
    @IBOutlet var labelCellNo  : UILabel!
    
    public var user : Result? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // View Decoration
        ivPhoto.layer.borderWidth   = 1
        ivPhoto.layer.borderColor   = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ivPhoto.layer.cornerRadius  = 15
        ivPhoto.layer.masksToBounds = true
        
        // Set data to view
        if let usr = user {
            if let mUrl = URL(string: usr.picture.large) {
                ivPhoto.load(url: mUrl)
            }
            labelName   .text = "\(usr.name.first) \(usr.name.last)"
            labelAddress.text = "\(usr.location.city), \(usr.location.state), \(usr.location.country)"
            labelEmail  .text = "\(usr.email)"
            labelCellNo .text = "\(usr.cell)"
            
            // Enable click event for email
            let recognizer = MyTapGestureRecognizer(target: self, action: #selector(self.emailAction(recognizer:)))
            recognizer.myEmail = "\(usr.email)"
            recognizer.myName  = "\(usr.name.first)"
            labelEmail.isUserInteractionEnabled = true
            labelEmail.addGestureRecognizer(recognizer)
            labelEmail.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            
        } // if
     
        
    } // viewDidLoad
    

    // Send email by clicking on email label
    // May not work in simulator, use real device
   @objc func emailAction(recognizer: MyTapGestureRecognizer) {

    let email = recognizer.myEmail ?? ""
    let name = recognizer.myName ?? ""
    
    if MFMailComposeViewController.canSendMail() {
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients([email])
        mail.setMessageBody("<p>Hello \(name), </p>", isHTML: true)
        
        present(mail, animated: true)
        
    } else {
        print("Can't send email. (Simulator may not work)")
    }
        
    } // emailAction
   
    
} // DetailViewController

// To pass data after click
class MyTapGestureRecognizer: UITapGestureRecognizer {
    var myEmail: String?
    var myName: String?
}

// Email view controller manage
extension DetailViewController : MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
