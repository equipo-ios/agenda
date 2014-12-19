//
//  TableViewController.swift
//  Agenda
//
//  Created by Fernando on 18/12/14.
//  Copyright (c) 2014 Equipo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //var appController: AppDelegate?
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var persons: NSMutableArray = ["Uno", "Dos", "Tres", "Cuatro"] // datos de prueba
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //appController = UIApplication.sharedApplication().delegate as AppDelegate
        //persons = appDelegate.persons
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        // MUY IMPORTANTE: si no se especifica la siguiente propiedad no se pueden seleccionar celdas en el modo de edición
        tableView.allowsSelectionDuringEditing = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makePhoneCall(phone: String) {
        NSLog("Llamando")
        let phone = "tel://982374234"
        let url: NSURL = NSURL(string:phone)!
        UIApplication.sharedApplication().openURL(url)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return persons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Celda", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let person = persons[indexPath.row] as String
        cell.textLabel.text = person
        cell.detailTextLabel?.text = person

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        /*
        //Comenzamos
        [tableView beginUpdates];
        // Borramos los objetos desde el datasource
        [self.appDelegate deleteObject:[self.fetchedRecordsArray objectAtIndex:indexPath.row]];
        
        // cogemos otra vez los registros
        
        self.fetchedRecordsArray=[self.appDelegate cogeDatos];
        // borramos los registros de la tabla
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //  terminamos la edición
        [self.tableView endUpdates];
        */
        
        if editingStyle == .Delete {
            // Borramos los datos
            
            var refreshAlert = UIAlertController(title: "Eliminar", message: "Se eliminará el contacto.", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Borrar", style: .Default, handler: { (action: UIAlertAction!) in
                // TODO: hacer la llamada al modelo
                self.persons.removeObjectAtIndex(indexPath.row)
                
                // Delete the row from the data source
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .Default, handler: { (action: UIAlertAction!) in
                NSLog("Borrar cancelado")
                // Ocultamos el botón de borrado
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "Add") {
            NSLog("Vamos al segue Add")
            var vc: EditViewController = segue.destinationViewController as EditViewController
            // Pasarle una nueva Person
            //var p = Person()
            //vc.person = p
        }
        
        if (segue.identifier == "Edit") {
            NSLog("Vamos al segue Edit")
            var vc: EditViewController = segue.destinationViewController as EditViewController
            // Pasarle la person de la Celda
            //var p = persons.objectAtIndex(tableView.indexPathForSelectedRow()!.row) as Person
            //vc.person = p
        }
        
        if (segue.identifier == "Detail") {
            NSLog("Vamos al segue Detail")
            var vc: DetalleViewController = segue.destinationViewController as DetalleViewController
            // Pasarle la person de la Celda
            //var p = persons.objectAtIndex(tableView.indexPathForSelectedRow()!.row) as Person
            //vc.person = p
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // esto nos permite realizar el segue condicional
        // en función del modo de la tabla (editar - normal)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if cell.reuseIdentifier == "Celda" {
            if self.tableView.editing {
                self.performSegueWithIdentifier("Edit", sender: cell)
            } else {
                let person = persons.objectAtIndex(tableView.indexPathForSelectedRow()!.row) as String
                NSLog("Vamos a llamar a: %@", person)
                makePhoneCall(person)
            }
        }
    }
    
}
