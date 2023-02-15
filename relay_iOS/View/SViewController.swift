//
//  ViewController.swift
//  new
//
//  Created by 양진영 on 2023/01/27.
//

import UIKit

class SViewController: UIViewController {

    
    
    @IBOutlet var createpopup: UIButton!
    
    @IBOutlet var userProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfile.layer.cornerRadius = 30
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func oncreatepopupclicked(_ sender: UIButton) {
        
        let storyboard = UIStoryboard.init(name: "popup", bundle: nil)
        let alertPopUpVc = storyboard.instantiateViewController(withIdentifier: "alertpopupvc")
        alertPopUpVc.modalPresentationStyle = .overCurrentContext
        alertPopUpVc.modalTransitionStyle = .crossDissolve
        
        self.present(alertPopUpVc,animated: true, completion: nil)
    }
    
}


