//
//  Schedules.swift
//  School
//
//  Created by Chettiar Valliappan, Valliappan on 5/23/17.
//  Copyright © 2017 Ratan. All rights reserved.
//

import AWSDynamoDB
class Schedules:AWSDynamoDBObjectModel, AWSDynamoDBModeling{
    var Schedule:String!
    var TeacherName_ClassName_Date:String!
    public static func dynamoDBTableName() -> String{
        return "SchoolDB"
    }
    public static func hashKeyAttribute() -> String{
        return "TeacherName_ClassName_Date"
    }
    
    
}
