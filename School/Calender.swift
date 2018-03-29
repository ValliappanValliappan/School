//
//  CalenderForOneWeekViewController.swift
//  school
//
//  Created by Chettiar Valliappan, Valliappan on 11/26/16.
//  Copyright © 2016 Ratan. All rights reserved.
//
import UIKit
import AWSDynamoDB
import AWSCore
//This is the teacher's calender
class Calender:UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet var datePicker:UIDatePicker!
    @IBOutlet var texView:UILabel!
    @IBOutlet var subjectPeriodRoller:UIPickerView!
    var teacherName:String!
    var subjectsTaught:[String]!
    var schedule:String!
    //var codes=NSDictionary.init(contentsOfFile:"/Users/valli/Desktop/Codes.txt") as! [String:String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        texView.text="Roll through the subjects to read data from them"
        datePicker.minimumDate=Date()
        datePicker.maximumDate=Date().addingTimeInterval(26298000)//number of seconds in one school year or 10 months
        datePicker.isSelected=true
        subjectPeriodRoller.delegate=self
        subjectPeriodRoller.dataSource=self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return subjectsTaught[row]
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return subjectsTaught.count
    }
    @IBAction func writeForDay(button:UIButton){
        let date=datePicker.date
        let writeView=TeacherWrite()
        writeView.date=date
        writeView.schedule=""
        writeView.className=subjectsTaught[subjectPeriodRoller.selectedRow(inComponent: 0)]
        writeView.subjectsTaught=subjectsTaught
        writeView.teacherName=teacherName
        present(writeView, animated: true, completion:nil)
    }
   
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        read()
    }
    @IBAction func datePickerValueChanged(){
        read()
    }
    func read(){
        let objectMapper=AWSDynamoDBObjectMapper.default()
        let a="\(self.teacherName!)_\(self.subjectsTaught[self.subjectPeriodRoller.selectedRow(inComponent: 0)])_\((self.datePicker.date.description as NSString).substring(to:10) as String)"
        objectMapper.load(Schedules.self, hashKey: a, rangeKey: nil).continueOnSuccessWith { (res:AWSTask<AnyObject>) -> Any? in
            self.schedule = (res.result as? Schedules)?.Schedule
            DispatchQueue.main.sync {//Doesn't matter if its async or sync. It is the last this that's executing but having it in bg thread slows app down...
            if let i = self.schedule{
            self.texView.text=i
            
        }
        else{
            self.texView.text="Nothing to display"
        }
            }
        
        return nil
        }
    }
}

