import UIKit

class WhatSubjectsYouTeachViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var teacherName: UITextField!
    var arrayOfPeriods:[String]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
    }
    @IBAction func cancel(button:UIButton) {
        let forwardStoryBoard=UIStoryboard.init(name: "Main", bundle: nil)
        let forward=forwardStoryBoard.instantiateViewController(withIdentifier: "teacherOrStudent") as! TeacherOrStudentViewController
        present(forward, animated: true, completion: nil)
    }
    @IBAction func done(button:UIButton){
        let areYouSure:UIAlertController=UIAlertController(title: "Sure?", message: "Are you sure about the subjects you have entered?", preferredStyle:UIAlertControllerStyle.alert)
        areYouSure.addAction(UIAlertAction.init(title: "No", style: UIAlertActionStyle.default, handler: nil))
        areYouSure.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {(UIAlertAction) in
            let calenderView=Calender()
            for i in 0..<10{
                if self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) != nil{
                    let cell:TableviewCell=self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! TableviewCell
                    var c:NSString=cell.subject.text! as NSString
                    c=c.replacingOccurrences(of: " ", with: "") as NSString
                    if (cell.period.text as! NSString).replacingOccurrences(of: " ", with: "") != "" && c as String != ""{
                        self.arrayOfPeriods.append("\(c) \((cell.period.text)!)")
                    }
                }
            }
                calenderView.subjectsTaught=self.arrayOfPeriods
                calenderView.teacherName=self.teacherName.text!
                self.present(calenderView, animated: true, completion: nil)
            
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
