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
    
    if photo == nil { // La foto no está en el bundle, buscarla en Documents
        var photoPath: String = getDocumentPathForPhoto(named: fileName)
        photo = UIImage(contentsOfFile: photoPath)
        //NSLog("La foto no está en el bundle, path: \(photoPath)")
    }
    
    return photo
}

func getDocumentPathForPhoto(named fileName: String) -> String {
    var docsURL: NSURL = appDelegate.applicationDocumentsDirectory
    var photoURL: NSURL = (docsURL.URLByAppendingPathComponent(fileName))
    return photoURL.path!
}

func squareThumbnailFromImage(#image: UIImage, #size: CGFloat) -> UIImage {
    var newSize: CGSize = CGSizeMake(size, size)
    UIGraphicsBeginImageContext(newSize)
    image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
    var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}