//
//  Utilities.swift
//  Agenda
//
//  Created by alumno on 11/03/15.
//  Copyright (c) 2015 Equipo. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

func loadPhoto(fileName: String) -> UIImage? {
    //NSLog("Intentamos recuperar la foto: \(fileName)")
    
    var photo: UIImage? = UIImage(named: fileName)
    
    if photo == nil {
        var docsURL: NSURL = appDelegate.applicationDocumentsDirectory
        var photoURL: NSURL = (docsURL.URLByAppendingPathComponent(fileName))
        photo = UIImage(contentsOfFile: photoURL.path!)
        //NSLog("La foto no está en el bundle, path: \(photoURL.path!)")
    }
    
    return photo
}