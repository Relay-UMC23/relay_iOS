//
//  CustomPopupView.swift
//  BottomPopup
//
//  Created by Apple on 03/09/21.
//

import UIKit

protocol CustomPopupViewDelegate: AnyObject
{
    func customPopupViewExtension(sender: CustomPopupView, didSelectNumber : Int)
}

class CustomPopupView: UIViewController {

    var rnum: Int?
    
    @IBOutlet weak var speedButton : UIButton!
    
    @IBOutlet weak var timeButton : UIButton!
    
    @IBOutlet weak var distanceButton :UIButton!
    
    weak var delegate: CustomPopupViewDelegate?
    static func instantiate() -> CustomPopupView? {
        return CustomPopupView(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if rnum == 1 {
            distanceButton.setTitleColor(UIColor.gray, for: .normal)
            timeButton.setTitleColor(UIColor.gray, for: .normal)
        }
        else if rnum == 2{
            timeButton.setTitleColor(UIColor.gray, for: .normal)
            speedButton.setTitleColor(UIColor.gray, for: .normal)
        }
        else if rnum == 3{
            distanceButton.setTitleColor(UIColor.gray, for: .normal)
            speedButton.setTitleColor(UIColor.gray, for: .normal)
        }
        speedButton.addTarget(self, action: #selector(speedButtonAction), for: .touchUpInside)
        distanceButton.addTarget(self, action: #selector(distanceButtonAction), for: .touchUpInside)
        timeButton.addTarget(self, action: #selector(timeButtonAction), for: .touchUpInside)
        
    }
    
    @objc func speedButtonAction() {
        delegate?.customPopupViewExtension(sender: self, didSelectNumber: 1)
    }
    @objc func distanceButtonAction() {
       delegate?.customPopupViewExtension(sender: self, didSelectNumber: 2)
   }
    @objc func timeButtonAction() {
       delegate?.customPopupViewExtension(sender: self, didSelectNumber: 3)
   }
   
}
