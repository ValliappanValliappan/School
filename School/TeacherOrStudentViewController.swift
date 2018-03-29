//
//  TeacherOrStudentViewController.swift
//  School
//
//  Created by Chettiar Valliappan, Valliappan on 5/25/17.
//  Copyright © 2017 Ratan. All rights reserved.
//

//
//  TeacherOrStudentViewController.swift
//  school
//
//  Created by Chettiar Valliappan, Valliappan on 12/29/16.
//  Copyright © 2016 Ratan. All rights reserved.
//
import UIKit

class TeacherOrStudentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func goToStudentView() {
        let studentView=StudentController()
        present(studentView, animated: true, completion: nil)
    }
    
    @IBAction func teacherView(){
        let storyBoardToPresent:UIStoryboard=UIStoryboard(name: "WhatSubjectYouTeach", bundle: nil)
        let teacherView=storyBoardToPresent.instantiateViewController(withIdentifier: "TeacherView") as! WhatSubjectsYouTeachViewController
        teacherView.tableView=UITableView()
        present(teacherView, animated: false, completion: nil)
    }
}
