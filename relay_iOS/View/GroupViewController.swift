//
//  ViewController.swift
//  teamall
//
//  Created by 양진영 on 2023/02/13.
//

import UIKit

class GroupViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBAction func back(_ sender: UIButton) {
    _ = self.navigationController?.popViewController(animated: true) }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCell else {return UITableViewCell ()
            
        }
        cell.labelName.text = memoName[indexPath.row]
        cell.labelContent.text = memoContent[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

    
    class CustomCell : UITableViewCell {
        @IBOutlet weak var labelName: UILabel!
        @IBOutlet weak var labelContent: UILabel!
        @IBOutlet weak var UserProfile:UIImageView!
        
        
        
        
    }
    let memoName = ["리페", "야옹","혜콩","테오","설기","비카","샐리","솜"]
    let memoContent = ["저는 방장 리페입니다","달리기를 좋아하는 야옹이에요", "안녕하세요 혜콩입니다","달리기를 잘하는 테오입니다", "저는 운동을 좋아합니다", "저는 항상 학교까지 달려간답니다","먹는것보다 달리는게 좋아요", " 운동중에 달리기를 제일 좋아해요"]
