import UIKit

class TeacherWriteViewController: UIViewController{
@IBOutlet var writeBox:UITextView!
    var date:Date!
    var className:String!
    var manager:FileManager!
    var originalDateEventDictionary:NSDictionary!
    var subjectsTaught:[String]!//required because, I dont want to store it in a file
    var teacherName:String!
    var codes:[String:String]!=NSDictionary.init(contentsOfFile: "/Users/valli/Desktop/Codes.txt") as! [String : String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        writeBox.textContainer.maximumNumberOfLines=20
        }
    @IBAction func write(_ button:UIButton){
    let path="/Users/valli/Desktop/\(date.description.substring(to:date.description.index(date.description.startIndex, offsetBy: 10)))/\(className!)_\(codes!["\(className!)_\(teacherName!)"]!).txt"
        manager=FileManager()
        if manager.fileExists(atPath:"/Users/valli/Desktop/\(date.description.substring(to:date.description.index(date.description.startIndex, offsetBy: 10)))") == false{
                try? manager.createDirectory(atPath: "/Users/valli/Desktop/\(date.description.substring(to:date.description.index(date.description.startIndex, offsetBy: 10)))", withIntermediateDirectories: false, attributes: nil)
        }
    let scheduleToEnter=writeBox?.text
    var trimmedSchedule=(scheduleToEnter as! NSString).replacingOccurrences(of: " ", with: "")
    if trimmedSchedule != ""{
        if manager.fileExists(atPath: path) == false{
            manager.createFile(atPath: path, contents: nil, attributes: nil)
        
        }
        try! (scheduleToEnter as! NSString).write(toFile: path, atomically: false, encoding:String.Encoding.utf8.rawValue)
        }
        let previousView=CalenderForOneWeekViewController()
        previousView.subjectsTaught=subjectsTaught
        previousView.teacherName=teacherName
    present(previousView, animated: false, completion: nil)
    }
    @IBAction func goBack(_ button:UIButton){
        let back=CalenderForOneWeekViewController()
        back.subjectsTaught=subjectsTaught
        back.teacherName=teacherName
        present(back, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
}
