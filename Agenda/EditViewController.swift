//
//  EditViewController.swift
//  Agenda
//
//  Created by Fernando on 18/12/14.
//  Copyright (c) 2014 Equipo. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var score: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var geolocation: UITextField!
    
    var person: Person?
    //var photo: UIImage
    
    @IBAction func selectPhoto(sender: AnyObject) {
        //?? SavedPhotosAlbum o PhotoLibrary
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            NSLog("Button capture")
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            //imag.mediaTypes = [kUTTypeImage];
            imag.allowsEditing = false
            presentViewController(imag, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        //var tempImage:UIImage = editingInfo[UIImagePickerControllerOriginalImage] as UIImage
        photoButton.imageView?.image=selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (person != nil) {
            title = "Editar"
            //photo.
            //photoButton.imageView?.image = person.p
            name.text = person?.name
            phone.text = person?.phone
            score.text = "\(person?.score)"
            geolocation.text = "Latitude: \(person?.latitude),  Longitude: \(person?.longitude)"
            notes.text = person?.notes
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePerson(sender: UIBarButtonItem) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
