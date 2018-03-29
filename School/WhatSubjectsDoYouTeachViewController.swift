//
//  WhatSubjectsDoYouTeachViewController.swift
//  school
//
//  Created by Chettiar Valliappan, Valliappan on 12/21/16.
//  Copyright © 2016 Ratan. All rights reserved.
//
import UIKit
import AWSDynamoDB
import AWSCore
class WhatSubjectsDoYouTeachViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var teacherName: UITextField!
    var arrayOfPeriods:[String]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        //Query test
        var superi=DynamoDBObjectFormat()
        superi?.Classcode_Month="123456-Jan"
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
        dynamoDBObjectMapper.save(superi!).continueWith(block: { (task:AWSTask<AnyObject>!) -> Any? in
            if let error = task.error as? NSError {
                print("The request failed. Error: \(error)")
            } else {
                print("Dandanakka")
            }
            return nil
        })
        
        //Ends here
        tableView.delegate=self
        tableView.dataSource=self
    }
    @IBAction func done(button:UIButton){
        let areYouSure:UIAlertController=UIAlertController(title: "Sure?", message: "Are you sure about the subjects you have entered?", preferredStyle:UIAlertControllerStyle.alert)
        areYouSure.addAction(UIAlertAction.init(title: "No", style: UIAlertActionStyle.default, handler: nil))
        areYouSure.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {(UIAlertAction) in
            let calenderView=CalenderForOneWeekViewController()
            for i in 0..<10{
                if self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) != nil{
                let cell:TableViewCell=self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! TableViewCell
                var c:NSString=cell.subject.text! as NSString
                c=c.replacingOccurrences(of: " ", with: "") as NSString
                if (cell.period.text as! NSString).replacingOccurrences(of: " ", with: "") != "" && c as String != ""{
                    self.arrayOfPeriods.append("\(c) \((cell.period.text)!)")
                }
                }
            }
            if self.arrayOfPeriods.isEmpty == false && self.teacherName.text?.replacingOccurrences(of: " ", with: "") != ""{
                var codeForSubject=NSDictionary.init(contentsOfFile:"/Users/valli/Desktop/Codes.txt") as! [String:String]
                for i in self.arrayOfPeriods{
                        var random=arc4random_uniform(1000001)
                        var code="\(random)"
                        codeForSubject["\(i)_\(self.teacherName!.text!)"]=code
                }
            calenderView.subjectsTaught=self.arrayOfPeriods
            var a=codeForSubject as NSDictionary
            a.write(toFile: "/Users/valli/Desktop/Codes.txt", atomically: false)
            calenderView.teacherName=self.teacherName.text!
            self.present(calenderView, animated: true, completion: nil)
            }
        }))
        present(areYouSure, animated: false, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1:UITableViewCell=tableView.dequeueReusableCell(withIdentifier: "cell1")!
        cell1.prepareForReuse()
        return cell1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
