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
    
    //var appDelegate: AppDelegate
    var person: Person?
    var photoName: String?
    var photoNew: UIImage? //guarda la foto seleccionada
    
    //Accion al pinchar la foto -> permite selccionar otra foto
    @IBAction func selectPhoto(sender: AnyObject) {
        NSLog("Botón seleccionar foto")
        var imag = UIImagePickerController()
        //Si hay camara abre la app para sacar foto
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imag.sourceType = UIImagePickerControllerSourceType.Camera
            imag.showsCameraControls = true
        } //si no hay camara abre la galeria para seleccionar una foto
        else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } //si no hay camara y photoLibrary no está disponible
        else {
            var alert = UIAlertController(title: "Aviso", message: "Galeria de fotos no disponible", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        imag.delegate = self
        //imag.mediaTypes = [kUTTypeImage];
        imag.allowsEditing = false
        presentViewController(imag, animated: true, completion: nil)
    }
    
    //Si ha seleccionado una foto, la carga en el boton
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        photoNew = info[UIImagePickerControllerOriginalImage] as? UIImage
        photoButton.imageView?.image = photoNew
        //si la foto fue sacada con la camara la guarda en photolibray
        /*if picker.sourceType == UIImagePickerControllerSourceType.Camera {
            UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage] as? UIImage, nil, nil, nil)
        }*/
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        //var tempImage:UIImage = editingInfo[UIImagePickerControllerOriginalImage] as UIImage
        photoButton.imageView?.image=image
        photoNew = image
        //si la foto fue sacada con la camara, la guarda en photolibray
        /*if picker.sourceType == UIImagePickerControllerSourceType.Camera {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }*/
        
        
        //cojo el nombre de la foto
        /*var imagePath: NSURL = editingInfo[UIImagePickerControllerReferenceURL] as NSURL
        photoName = imagePath.lastPathComponent*/
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (person!.name != "") {
            title = "Editar"
            photoButton.imageView?.image = UIImage(named: person!.photo)
            name.text = person?.name
            phone.text = person?.phone
            score.text = "\(person?.score)"
            geolocation.text = "\(person?.latitude),  \(person?.longitude)"
            notes.text = person?.notes
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePerson(sender: UIBarButtonItem) {
        if name.text != "" {
            //guardar foto en el sandbox
            
            //coge los datos y los guarda en el modelo
            person?.name = name.text
            person?.phone = phone.text
            person?.score = score.text.toInt()
            person?.notes = notes.text
            getCoordinates(geolocation.text)
            person?.photo = photoName
            
        }
        else {
            var alert = UIAlertController(title: "Aviso", message: "El campo debe estar relleno", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    //función para dar nombres a las fotos
    func newPhotoName(name: String) -> String {
        name = name.stringByTrimmingCharactersInSet()
        return name
    }
    
    func getCoordinates(coordenate:String){
        //person?.latitude =
        //person?.longitude =
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
