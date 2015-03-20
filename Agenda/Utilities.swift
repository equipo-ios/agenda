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
    var thumbnailSize: CGSize = CGSizeMake(size, size)
    var widthScale: CGFloat
    var heightScale: CGFloat
    var newWidth: CGFloat
    var newHeight: CGFloat
    var originX: CGFloat
    var originY: CGFloat
    var thumbnail: UIImage
    
    // calculamos los factores de escalado
    if image.size.width > image.size.height {
        // imagen apaiasada
        widthScale = 1.0
        heightScale = image.size.height / image.size.width
    } else {
        // imagen vertical
        widthScale = image.size.width / image.size.height
        heightScale = 1.0
    }
    
    // calculamos el nuevo tamaño de la imagen
    newWidth = thumbnailSize.width * widthScale
    newHeight = thumbnailSize.height * heightScale
    
    // calculamos las coordenadas para dibujar la imagen centrada
    originX = (thumbnailSize.width / 2) - (newWidth) / 2
    originY = (thumbnailSize.height / 2) - (newHeight) / 2
    
    UIGraphicsBeginImageContext(thumbnailSize)
    // dibujamos la imagen escalada
    image.drawInRect(CGRectMake(originX, originY, newWidth, newHeight))
    thumbnail = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return thumbnail
}