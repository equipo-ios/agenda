//
//  DetalleViewController.swift
//  Agenda
//
//  Created by Fernando on 18/12/14.
//  Copyright (c) 2014 Equipo. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {

 
    @IBOutlet weak var photo: UIImageView!
   
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var geolocation: UILabel!
    
    @IBOutlet weak var notes: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
