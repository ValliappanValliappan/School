//
//  DynamoDBObjectFormatForClassCodes.swift
//  school
//
//  Created by Chettiar Valliappan, Valliappan on 3/4/17.
//  Copyright © 2017 Ratan. All rights reserved.
//

import UIKit
import AWSDynamoDB
import AWSCore
class DynamoDBObjectFormatForClassCodes:  AWSDynamoDBObjectModel,AWSDynamoDBModeling {
    var ClassNamePeriod_TeacherName:String!
    class func dynamoDBTableName() -> String {
        return "ClassCodes"
    }
    
    class func hashKeyAttribute() -> String {
        return "ClassName Period_TeacherName"
    }
}
