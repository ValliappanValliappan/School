//
//  TableViewCell.swift
//  school
//
//  Created by Chettiar Valliappan, Valliappan on 12/23/16.
//  Copyright © 2016 Ratan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell,UITextFieldDelegate{
    @IBOutlet var period: UITextField!
    @IBOutlet var subject: UITextField!
    var periodSelectedOrNot=false
    var subjectSelectedOrNot=false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        subject.delegate=self
        period.delegate=self
    }
    override func setSelected(_ selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
            }
    public func textFieldDidEndEditing(_ textField: UITextField){
        setSelected(false, animated: true)
    }
    func dismiss(){
        period.resignFirstResponder()
        subject.resignFirstResponder()
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        subject.resignFirstResponder()
        period.resignFirstResponder()
        return true
    }
    
}
