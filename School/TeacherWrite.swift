import UIKit
import AWSDynamoDB
import AWSCore
class TeacherWrite: UIViewController{
    @IBOutlet var writeBox:UITextView!
    
    var schedule:String!
    var date:Date!
    var className:String!
    var manager:FileManager!
    var originalDateEventDictionary:NSDictionary!
    var subjectsTaught:[String]!
    var teacherName:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        writeBox.textContainer.maximumNumberOfLines=20
        //testing
        let key="\(teacherName!)_\(className!)_\((date.description as NSString).substring(to:10) as String)"
        let objectMapper=AWSDynamoDBObjectMapper.default()
        objectMapper.load(Schedules.self, hashKey: key, rangeKey: nil).continueOnSuccessWith { (res:AWSTask<AnyObject>) -> Any? in
            self.schedule = (res.result as? Schedules)?.Schedule
            print("c")
            DispatchQueue.main.sync {//Doesn't matter if its async or sync. It is the last this that's executing but having it in bg thread slows app down...
                if let i = self.schedule{
                    self.writeBox.text=i
                }
        }
            return nil
        }
    }

    @IBAction func goBack(_ button:UIButton){
        let back=Calender()
        back.subjectsTaught=subjectsTaught
        back.teacherName=teacherName
        present(back, animated: true, completion: nil)
    }
    
    @IBAction func write(){
        let key="\(teacherName!)_\(className!)_\((date.description as NSString).substring(to:10) as String)"
        let scheduleToEnter=writeBox?.text
        var trimmedSchedule=(scheduleToEnter as! NSString).replacingOccurrences(of: " ", with: "")
        if trimmedSchedule != ""{
            let objectToUploadToDB=Schedules()
            objectToUploadToDB?.Schedule=scheduleToEnter
            objectToUploadToDB?.TeacherName_ClassName_Date=key
            let dynamoDBObjectMapper=AWSDynamoDBObjectMapper.default()
            dynamoDBObjectMapper.save(objectToUploadToDB!)
            let previousView=Calender()
                    previousView.subjectsTaught=subjectsTaught
                    previousView.teacherName=teacherName
                    present(previousView, animated: false, completion: nil)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
