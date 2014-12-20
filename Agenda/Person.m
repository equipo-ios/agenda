//
//  Person.m
//  Agenda
//
//  Created by Fernando on 18/12/14.
//  Copyright (c) 2014 Equipo. All rights reserved.
//

#import "Person.h"


@implementation Person

@dynamic name;
@dynamic phone;
@dynamic photo;
@dynamic score;
@dynamic notes;
@dynamic latitude;
@dynamic longitude;


/*class Person: NSObject {
    var name: String = String()
    var phone: String = String()
    var photo: String = String()
    var score: String = String()
    var notes: String = String()
    var latitude: float = float()
    var longitude: float = float()
}
*/
// Creacion de la base de datos.
class func copyFile(Person: NSString){
var dbPath: NSString = getPath(Person)
    var fileManager = NSFileManager,defaultManager()
    if !fileManager.fileExistsAtPath(dbPath){
        var fromPath: NSString = NSBundle.mainBundle().resourcePath.stringByAppendingPathComponent(fileManager.copyItemAtPath(fromPath, toPath: debPath, error: nil))
    }
}

// Iniciar el objeto Database

let sharedInstance = ModelManager()

var database: FMDatabase? = nil

class var instance: ModelManager {
    sharedInstance.database = FMDatabase(path: Util.getPath("DataBaseDemo.sqlite"))
    var path = Util.getPath("DataBaseDemo.sqlite")
    println("path : \(path)")
    return sharedInstance
}

// Consulta de la Base de Datos.
//INSERT

func addPersonData(personInfo: PersonInfo) -> Bool {
    sharedInstance.database!.open()
    let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO Person (name, phone, photo, score, notes, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?)", withArgumentsInArray: [person.name, person.phone, person.photo, person.score, person.notes, person.latitude, person.longitude])
    
    sharedInstance.database!.close()
    return isInserted
}


@IBAction func btnInsertClicked(sender: AnyObject) {
    var person: Person = Person()
    person.name = txtname.text
    person.phone = txtphone.text
    person.photo = txtphoto.text
    person.score = txtscore.text
    person.notes = txtnotes.text
    person.latitude = txtlatitude.text
    person.longitude = txtlongitude.text
    
    var isInserted = ModelManager.instance.addStudentData(studentInfo)
    if isInserted {
        Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
    } else {
        Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
    }
    txtname.text = ""
    txtphoto.text = ""
    txtphone.text = ""
    
    txtscore.text = ""
    txtnotes.text = ""
    txtlatitude.text = ""
    txtlongitude.text = ""
    txtname.becomeFirstResponder()
}

// ACTUALIZACION

func updatePersonData(personInfo: PersonInfo) -> Bool {
    sharedInstance.database!.open()
    let isUpdated = sharedInstance.database!.executeUpdate("UPDATE PersonInfo SET name=? WHERE photo=?", withArgumentsInArray: [personInfo.name, personInfo.phone, personInfo.photo, personInfo.score, personInfo.notes, personInfo.latitude, personInfo.longitude])
    sharedInstance.database!.close()
    return isUpdated
}



@IBAction func btnUpdateClicked(sender: AnyObject) {
    var studentInfo: StudentInfo = StudentInfo()
    studentInfo.studentRollNo = txtRollNo.text
    studentInfo.studentName = txtName.text
    
    var isUpdated = ModelManager.instance.updateStudentData(studentInfo)
    if isUpdated {
        Util.invokeAlertMethod("", strBody: "Record updated successfully.", delegate: nil)
    } else {
        Util.invokeAlertMethod("", strBody: "Error in updating record.", delegate: nil)
    }
    txtRollNo.text = ""
    txtName.text = ""
    txtRollNo.becomeFirstResponder()
}

// BORRAR

func deleteStudentData(studentInfo: StudentInfo) -> Bool {
    sharedInstance.database!.open()
    let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM StudentInfo WHERE student_rollno=?", withArgumentsInArray: [studentInfo.studentRollNo])
    sharedInstance.database!.close()
    return isDeleted
}

@IBAction func btnDeleteClicked(sender: AnyObject) {
    var studentInfo: StudentInfo = StudentInfo()
    studentInfo.studentRollNo = txtRollNo.text
    studentInfo.studentName = txtName.text
    
    var isDeleted = ModelManager.instance.deletePersontData(personInfo)
    if isDeleted {
        Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
    } else {
        Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
    }
    txtname.text = ""
    txtphone.text = ""
    txtphoto.text = ""
    txtscore.text = ""
    txtnotes.text = ""
    txtlatitude.text = ""
    txtlongitude.text = ""
    
    txtname.becomeFirstResponder()
}

//PANTALLA

func getAllPersonData() {
    sharedInstance.database!.open()
    var resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM PersonInfo", withArgumentsInArray: nil)
    var nameColumn: String = "name"
    var phoneColumn: String = "phone"
    var photoColumn: String = "photo"
    var scoreColumn: String = "score"
    var notesColumn: String = "notes"
    var latitudeColumn: String = "latitude"
    var longitudeColumn: String = "longitude"
    if resultSet {
        while resultSet.next() {
            println("name : \(resultSet.stringForColumn(nameColumn))")
            println("phone : \(resultSet.stringForColumn(phoneColumn))")
            println("photo : \(resultSet.stringForColumn(photoColumn))")
            println("score : \(resultSet.stringForColumn(scoreColumn))")
            println("notes : \(resultSet.stringForColumn(notesColumn))")
            println("latitude : \(resultSet.stringForColumn(latitudeColumn))")
            println("longitude : \(resultSet.stringForColumn(longitudeColumn))")
        }
    }
    sharedInstance.database!.close()
}

@IBAction func btnDisplayRecordClicked(sender: AnyObject) {
    ModelManager.instance.getAllPersonData()
}
@end
