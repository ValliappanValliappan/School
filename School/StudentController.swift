//
//  StudentViewController.swift
//  school
//
//  Created by Chettiar Valliappan, Valliappan on 12/29/16.
//  Copyright © 2016 Ratan. All rights reserved.
//

import UIKit
class StudentController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var classNames: [UITextField]!
    //@IBOutlet var classKeys: [UITextField]!
    override func viewDidLoad(){
        super.viewDidLoad()
        for i in classNames {
            i.delegate=self
        }
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        var i=9
        while i >= 0{
            if classNames[i].text == ""{
                classNames.remove(at: i)
                //classKeys.remove(at: i)
            }
            i-=1
        }
        let forward=StudentRead()
        print(classNames)
        //print(classKeys)
        forward.subjectsTaught=classNames
        //forward.keys=classKeys
        present(forward, animated: false, completion: nil)}
    
    @IBAction func cancelProcess(button:UIButton) {
        let forwardStoryBoard=UIStoryboard.init(name: "Main", bundle: nil)
        let forward=forwardStoryBoard.instantiateViewController(withIdentifier: "teacherOrStudent") as! TeacherOrStudentViewController
        present(forward, animated: true, completion: nil)
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
}
