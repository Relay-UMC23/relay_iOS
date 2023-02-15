//
//  popupviewcontroller.swift
//  new
//
//  Created by 양진영 on 2023/02/12.
//

import UIKit

class popupviewcontroller : UIViewController {
    
    @IBOutlet var contentView: UIView!

    @IBOutlet var cancel: UIButton!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 30
    }
    
    @IBAction func cancelclicked(_ sender: UIButton) {
        self.dismiss(animated: true,completion: nil)
    }
    
    
}




