//
//  StudentReadViewController.swift
//  school
//
//  Created by Chettiar Valliappan, Valliappan on 1/7/17.
//  Copyright © 2017 Ratan. All rights reserved.
//

import UIKit
import AWSDynamoDB
import AWSCore
class StudentRead: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate{
    @IBOutlet var textView:UILabel!
    @IBOutlet var datePicker:UIDatePicker!
    @IBOutlet var subjectPeriodRoller:UIPickerView!
    var subjectsTaught:[UITextField]!
    var schedule:String!
    //var keys:[UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectPeriodRoller.dataSource=self
        subjectPeriodRoller.delegate=self
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return subjectsTaught.count
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return subjectsTaught[row].text
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func read(){
        let objectMapper=AWSDynamoDBObjectMapper.default()
        let a="\(subjectsTaught[subjectPeriodRoller.selectedRow(inComponent: 0)].text!)_\((datePicker.date.description as NSString).substring(to:10) as String)"
        //print(a)
        objectMapper.load(Schedules.self, hashKey: a, rangeKey: nil).continueOnSuccessWith { (res:AWSTask<AnyObject>) -> Any? in
            print("Step2 \(Date())")
            self.schedule = (res.result as? Schedules)?.Schedule
            DispatchQueue.main.sync {//Doesn't matter if its async or sync. It is the last this that's executing but having it in bg thread slows app down...
                print("step1 \(Date())")
                if let i = self.schedule{
                    self.textView.text=i
                    
                }
                else{
                    self.textView.text="Nothing to display"
                }
            }
            
            return nil
        }

    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        read()
    }
    @IBAction func datePickerValueChanged(){
        read()
    }
    
    
}

