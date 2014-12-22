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
    //@IBOutlet weak var geolocation: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    
    var appDelegate: AppDelegate?
    var person: Person?
    var photoNew: UIImage? //guarda la foto seleccionada
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "muestraTeclado:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "escondeTeclado:", name: UIKeyboardWillHideNotification, object: nil)
        /*
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(muestraTeclado:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(escondeTeclado:) name:UIKeyboardWillHideNotification object:nil];
        */

        appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if (person!.name != "") {
            title = "Editar"
            //photoButton.imageView?.image = UIImage(named: person!.photo)
            photoButton.setBackgroundImage(UIImage(named: person!.photo), forState: .Normal)
            name.text = person!.name
            phone.text = person!.phone
            score.text = "\(person!.score)"
//            geolocation.text = "\(person!.latitude),  \(person!.longitude)"
            latitude.text = "\(person!.latitude)"
            longitude.text = "\(person!.longitude)"
            notes.text = person?.notes
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
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
        photoButton.setBackgroundImage(photoNew, forState: .Normal)
        //si la foto fue sacada con la camara la guarda en photolibray
        /*if picker.sourceType == UIImagePickerControllerSourceType.Camera {
            UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage] as? UIImage, nil, nil, nil)
        }*/
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //????
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        //var tempImage:UIImage = editingInfo[UIImagePickerControllerOriginalImage] as UIImage
//        photoButton.setBackgroundImage(image, forState: .Normal)
//        photoNew = image
        //si la foto fue sacada con la camara, la guarda en photolibray
        /*if picker.sourceType == UIImagePickerControllerSourceType.Camera {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }*/
        
        //cojo el nombre de la foto
        /*var imagePath: NSURL = editingInfo[UIImagePickerControllerReferenceURL] as NSURL
        photoName = imagePath.lastPathComponent*/
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
    //
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func savePerson(sender: UIBarButtonItem) {
        if name.text != "" {
            //guardar foto en el sandbox
            if photoNew != nil {
                savePhotoToSandBox()
            }
            //coge los datos y los guarda en el modelo
            person?.name = name.text
            person?.phone = phone.text
            person?.score = score.text.toInt()
            person?.notes = notes.text
            //getCoordinates(geolocation.text)
            person?.latitude = (latitude.text as NSString).doubleValue
            person?.longitude = (longitude.text as NSString).doubleValue
            
            //actualiza base de datos
            appDelegate!.saveContext()
            
            //vuelve a la tableView
            navigationController?.popToRootViewControllerAnimated(true)
        }
        else {
            var alert = UIAlertController(title: "Aviso", message: "El campo debe estar relleno", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    //función para guardar la foto en el sandbox
    func savePhotoToSandBox(){
        NSLog("SavePhotoToSandBox")
        var photoData: NSData = UIImageJPEGRepresentation(photoNew, 0.4)
        //??????var imageURL: NSURL = appDelegate.imageURL
        var imageURL: NSURL = appDelegate!.applicationDocumentsDirectory
        var fileName: String
        //verifica si es Añadir
        var hayFoto = person?.photo
        NSLog(hayFoto!)
        if(hayFoto != nil){
            fileName = person!.photo
        }else {
            fileName = uniqueFileName()
        }
        NSLog(fileName)
        imageURL.URLByAppendingPathComponent(fileName)
        person?.photo = imageURL.absoluteString
        NSLog(imageURL.absoluteString!)
        photoData.writeToURL(imageURL, atomically: true)
    }
    
    
    //crea un nombre unico para cada imagen <nombre del contacto>_<fecha instantanea ddMMyyHHmmss>.jpg
    func uniqueFileName()-> String {
        NSLog("uniqueFileName")
        var photoName = name.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        var ddMMyyHHmmss: NSDateFormatter = NSDateFormatter()
        ddMMyyHHmmss.dateFormat = "ddMMyyHHmmss"
        var photoFileName: String = "\(photoName)_\(ddMMyyHHmmss.stringFromDate(NSDate())).jpg"
        return photoFileName
    }

    
    func getCoordinates(coordenate:String){
        person?.latitude = (coordenate.componentsSeparatedByString(", ")[0] as NSString).floatValue
        person?.longitude = (coordenate.componentsSeparatedByString(", ")[1] as NSString).floatValue
    }

/*
-(void) muestraTeclado:(NSNotification*)aNotification
{
    NSLog(@"Keyboard was shown");
    NSDictionary* info = [aNotification userInfo];
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y- keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
    [UIView commitAnimations];
    
}
*/

    func muestraTeclado(aNotification: NSNotification) {
        
    }

/*
-(void) escondeTeclado:(NSNotification*)aNotification
{
    NSLog(@"Keyboard will hide");
    NSDictionary* info = [aNotification userInfo];
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
    [UIView commitAnimations];
}
*/

    func escondeTeclado(aNotification: NSNotification) {

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
