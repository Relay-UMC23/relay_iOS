//
//  TimeTableViewController.swift
//  Pods
//
//  Created by 혜원 on 2023/01/28.
//

import UIKit
import Elliotable

class TimeTableViewController: UIViewController, ElliotableDelegate, ElliotableDataSource {
    
    let course_1 = ElliottEvent(courseId: "c0001", courseName: "리페", roomName: " ", professor: " ", courseDay: .tuesday, startTime: "12:00", endTime: "13:00", backgroundColor: UIColor.systemPink)
    
    let course_2 = ElliottEvent(courseId: "c0001", courseName: "리페", roomName: " ", professor: " ", courseDay: .thursday, startTime: "20:00", endTime: "21:00", backgroundColor: UIColor.systemPink)
    
    let course_3 = ElliottEvent(courseId: "c0001", courseName: "리페", roomName: " ", professor: " ", courseDay: .friday, startTime: "10:00", endTime: "12:00", backgroundColor: UIColor.systemPink)
    
    
    let course_5 = ElliottEvent(courseId: "c0002", courseName: "라나", roomName: " ", professor: " ", courseDay: .thursday, startTime: "8:00", endTime: "8:30", textColor: UIColor.white, backgroundColor: UIColor.systemYellow)
    
    let course_6 = ElliottEvent(courseId: "c0002", courseName: "라나", roomName: " ", professor: " ", courseDay: .tuesday, startTime: "07:00", endTime: "07:30", textColor: UIColor.white, backgroundColor: UIColor.systemYellow)
    
    
    let course_9 = ElliottEvent(courseId: "c0004", courseName: "노창", roomName: " ", professor: " ", courseDay: .friday, startTime: "07:00", endTime: "07:20", textColor: UIColor.white, backgroundColor: UIColor.systemGreen)
    
    let course_10 = ElliottEvent(courseId: "c0005", courseName: "노창", roomName: " ", professor: " ", courseDay: .wednesday, startTime: "07:00", endTime: "07:20", textColor: UIColor.white, backgroundColor: UIColor.systemGreen)
    
    let course_11 = ElliottEvent(courseId: "c0006", courseName: "노창", roomName: " ", professor: " ", courseDay: .monday, startTime: "07:00", endTime: "07:20", textColor: UIColor.white, backgroundColor: UIColor.systemGreen)
    
    let course_12 = ElliottEvent(courseId: "c0007", courseName: "샐리", roomName: " ", professor: " ", courseDay: .monday, startTime: "13:00", endTime: "15:00", textColor: UIColor.white, backgroundColor: UIColor.systemBrown)
    
    let course_13 = ElliottEvent(courseId: "c0007", courseName: "샐리", roomName: " ", professor: " ", courseDay: .friday, startTime: "15:00", endTime: "16:00", textColor: UIColor.white, backgroundColor: UIColor.systemBrown)
    
    let course_14 = ElliottEvent(courseId: "c0007", courseName: "샐리", roomName: " ", professor: " ", courseDay: .thursday, startTime: "09:00", endTime: "10:00", textColor: UIColor.white, backgroundColor: UIColor.systemBrown)
    
    
    
    let course_15 = ElliottEvent(courseId: "c0003", courseName: "야옹", roomName: " ", professor: " ", courseDay: .monday, startTime: "14:00", endTime: "15:00", textColor: UIColor.white, backgroundColor: UIColor.systemCyan)
    
    let course_16 = ElliottEvent(courseId: "c0003", courseName: "야옹", roomName: " ", professor: " ", courseDay: .wednesday, startTime: "10:30", endTime: "12:00", textColor: UIColor.white, backgroundColor: UIColor.systemCyan)
    
    let course_17 = ElliottEvent(courseId: "c0003", courseName: "야옹", roomName: " ", professor: " ", courseDay: .thursday, startTime: "12:00", endTime: "14:00", textColor: UIColor.white, backgroundColor: UIColor.systemCyan)
    
    let course_18 = ElliottEvent(courseId: "c0003", courseName: "야옹", roomName: " ", professor: " ", courseDay: .friday, startTime: "14:00", endTime: "15:00", textColor: UIColor.white, backgroundColor: UIColor.systemCyan)
    
    let course_19 = ElliottEvent(courseId: "c0003", courseName: "테오", roomName: " ", professor: " ", courseDay: .wednesday, startTime: "15:00", endTime: "15:30", textColor: UIColor.white, backgroundColor: UIColor.systemIndigo)
    
    
    let course_20 = ElliottEvent(courseId: "c0003", courseName: "테오", roomName: " ", professor: " ", courseDay: .saturday, startTime: "09:00", endTime: "11:00", textColor: UIColor.white, backgroundColor: UIColor.systemIndigo)

    let course_22 = ElliottEvent(courseId: "c0003", courseName: "혜콩", roomName: " ", professor: " ", courseDay: .monday, startTime: "10:00", endTime: "10:30", textColor: UIColor.white, backgroundColor: UIColor.systemPurple)
    
    let course_23 = ElliottEvent(courseId: "c0003", courseName: "혜콩", roomName: " ", professor: " ", courseDay: .tuesday, startTime: "09:00", endTime: "09:30", textColor: UIColor.white, backgroundColor: UIColor.systemPurple)
    
    let course_24 = ElliottEvent(courseId: "c0003", courseName: "혜콩", roomName: " ", professor: " ", courseDay: .wednesday, startTime: "10:00", endTime: "10:30", textColor: UIColor.white, backgroundColor: UIColor.systemPurple)
    
    let course_25 = ElliottEvent(courseId: "c0003", courseName: "혜콩", roomName: " ", professor: " ", courseDay: .friday, startTime: "09:00", endTime: "09:30", textColor: UIColor.white, backgroundColor: UIColor.systemPurple)
    
    let course_27 = ElliottEvent(courseId: "c0003", courseName: "채리", roomName: " ", professor: " ", courseDay: .saturday, startTime: "07:00", endTime: "09:00", textColor: UIColor.white, backgroundColor: UIColor.systemRed)
    
    let course_28 = ElliottEvent(courseId: "c0003", courseName: "채리", roomName: " ", professor: " ", courseDay: .wednesday, startTime: "20:00", endTime: "20:30", textColor: UIColor.white, backgroundColor: UIColor.systemRed)
    
    
    
    private let daySymbol = ["일", "월", "화", "수", "목","금", "토"]
    
    @IBOutlet weak var elliotable: Elliotable!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           // Delegate Pattern
           elliotable.delegate = self
           elliotable.dataSource = self
           
           // Table Item Properties
           elliotable.elliotBackgroundColor = UIColor.white
           elliotable.borderWidth        = 1
           elliotable.borderColor        = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)

           // Course Item Properties
           elliotable.textEdgeInsets = UIEdgeInsets(top: 2, left: 3, bottom: 2, right: 10)
           elliotable.courseItemMaxNameLength = 18
           elliotable.courseItemTextSize      = 12.5
           elliotable.courseTextAlignment     = .left
           // 시간표 강의 아이템 라운드
           elliotable.borderCornerRadius = 24
           elliotable.roomNameFontSize        = 8

           // courseItemHeight - default : 60.0
           elliotable.courseItemHeight       = 60.0

           // Day Symbol & Leftside Time Symbol Properties
           elliotable.symbolFontSize = 14
           elliotable.symbolTimeFontSize = 12
           elliotable.symbolFontColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
           elliotable.symbolTimeFontColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
           elliotable.symbolBackgroundColor = UIColor(named: "main_bg") ?? .white

           // Do any additional setup after loading the view.
       }
       
       func elliotable(elliotable: Elliotable, didSelectCourse selectedCourse: ElliottEvent) {
           
       }
       
       func elliotable(elliotable: Elliotable, didLongSelectCourse longSelectedCourse: ElliottEvent) {
           
       }
       
       func elliotable(elliotable: Elliotable, at dayPerIndex: Int) -> String {
           self.daySymbol[dayPerIndex]
       }
       
       func numberOfDays(in elliotable: Elliotable) -> Int {
           self.daySymbol.count
       }
       
       func courseItems(in elliotable: Elliotable) -> [ElliottEvent] {
           return [course_1, course_2, course_3,course_5, course_6, course_9, course_10, course_11, course_12,course_13, course_14, course_15, course_16, course_17, course_18, course_19, course_20, course_22, course_23, course_24, course_25, course_27, course_28]
       }
       
       

       /*
       // MARK: - Navigation
       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
       }
       */

   }
