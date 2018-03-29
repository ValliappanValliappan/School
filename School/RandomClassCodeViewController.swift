//
//  RandomClassCodeViewController.swift
//  school
//
//  Created by Chettiar Valliappan, Valliappan on 12/26/16.
//  Copyright © 2016 Ratan. All rights reserved.
//

import UIKit

class RandomClassCodeViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet var codeView: UITextView!
    @IBOutlet var subjectPicker: UIPickerView!
    var codeForSubject:[String:String]!
    var subjectsArray:[String]!
    var teacherName:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        codeForSubject=NSDictionary(contentsOfFile: "/Users/valli/Desktop/Codes.txt") as! [String:String]
        subjectPicker.dataSource=self
        subjectPicker.delegate=self
            }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return subjectsArray[row]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return subjectsArray.count
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        codeView.text=codeForSubject["\(subjectsArray[row])_\(teacherName!)"]
    }
    @IBAction func goBack(_ button:UIButton){
        let back=CalenderForOneWeekViewController()
        back.subjectsTaught=subjectsArray
        back.teacherName=teacherName
        present(back, animated: true, completion: nil)
    }
}
