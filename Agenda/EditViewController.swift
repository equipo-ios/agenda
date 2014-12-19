//
//  EditViewController.swift
//  Agenda
//
//  Created by Fernando on 18/12/14.
//  Copyright (c) 2014 Equipo. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    
    @IBOutlet weak var photoButton: UIButton!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var score: UITextField!
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var notes: UITextField!
    
    @IBOutlet weak var geolocation: UITextField!
    
    
    @IBAction func selectPhoto(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
