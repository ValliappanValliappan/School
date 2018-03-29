//
//  CalenderForOneWeekViewController.swift
//  school
//
//  Created by Chettiar Valliappan, Valliappan on 11/26/16.
//  Copyright © 2016 Ratan. All rights reserved.
//
import UIKit

//This is the teacher's calender
class CalenderForOneWeekViewController:UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet var datePicker:UIDatePicker!
    @IBOutlet var textView:UITextView!
    @IBOutlet var subjectPeriodRoller:UIPickerView!
    var teacherName:String!
    var subjectsTaught:[String]!
    var codes=NSDictionary.init(contentsOfFile:"/Users/valli/Desktop/Codes.txt") as! [String:String]!
    override func viewDidLoad() {
        textView.textContainer.maximumNumberOfLines=20
        super.viewDidLoad()
        textView.text="Roll through the subjects to read data from them"
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
    
    @IBAction func showClassCodesView(button:UIButton){
        let classCodes=RandomClassCodeViewController()
        classCodes.subjectsArray=subjectsTaught
        classCodes.teacherName=teacherName
        present(classCodes, animated: false, completion: nil)
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return subjectsTaught.count
    }
    @IBAction func writeForDay(button:UIButton){
        let date=datePicker.date
        let writeView=TeacherWriteViewController()
        writeView.date=date
        writeView.className=subjectsTaught[subjectPeriodRoller.selectedRow(inComponent: 0)]
        writeView.subjectsTaught=subjectsTaught
        writeView.teacherName=teacherName
        present(writeView, animated: true, completion:nil)
   }
    @IBAction func goBackOneViewController(){
        let back=WhatSubjectsDoYouTeachViewController()
        present(back, animated: true, completion: nil)
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        read()
    }
    @IBAction func datePickerValueChanged(){
        read()
    }
    func read(){
        var codes=NSDictionary.init(contentsOfFile:"/Users/valli/Desktop/Codes.txt") as! [String:String]!
        let path="/Users/valli/Desktop/\(datePicker.date.description.substring(to: datePicker.date.description.index(datePicker.date.description.startIndex, offsetBy: 10)))/\(subjectsTaught[subjectPeriodRoller.selectedRow(inComponent: 0)])_\(codes!["\(subjectsTaught[subjectPeriodRoller.selectedRow(inComponent: 0)])_\(teacherName!)"]!).txt"
        let manager=FileManager()
        if manager.fileExists(atPath: path){
        var schedule=try! NSString(contentsOfFile: path, encoding: UInt.init())
        textView.text=schedule as String
        }
        else{
            textView.text="Nothing to display"
        }
        }
   }
