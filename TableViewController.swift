//
//  TableViewController.swift
//  Agenda
//
//  Created by Fernando on 18/12/14.
//  Copyright (c) 2014 Equipo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    typealias fakePerson = (
        name: String,
        phone: String,
        photo: String,
        score: Int,
        notes: String,
        latitude: Double,
        longitude: Double
    )
    
    var fakePersons = [fakePerson]() // datos de prueba
    //var persons = [fakePerson]() // datos de prueba
    var persons: [NSManagedObject] = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.persons = self.appDelegate.loadData()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        // MUY IMPORTANTE: si no se especifica la siguiente propiedad no se pueden seleccionar celdas en el modo de edición
        self.tableView.allowsSelectionDuringEditing = true
        
        // no mostramos los separadores de las celdas vacías
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        
        //self.populateFakeData() // cargar datos de prueba
        //self.persons = [] // para probar que se muestra el mensaje de no hay datos
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Auxiliary functions
    
    func populateFakeData() {
        for (var i = 0; i < 10; i++) {
            var person: fakePerson = fakePerson(
                name: "Persona \(i)",
                phone: "55500\(i)",
                photo: "hombre01.png",
                score: 10 - i,
                notes: "Una nota para la persona \(i)",
                latitude: 12.5 + Double(i),
                longitude: 9.8 + Double(i)
            )
            
            self.fakePersons.append(person)
        }
    }
    
    func makePhoneCall(phone: String) {
        NSLog("Llamando a \(phone)")
        let phoneURL = "tel://\(phone)"
        let url: NSURL = NSURL(string: phoneURL)! // PELIGRO: si phone no es un número válido "casca"
        UIApplication.sharedApplication().openURL(url)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if (persons.count == 0) { // No hay datos, mostramos un mensaje
            let messageLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            messageLabel.text = "No hay contactos"
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.font = UIFont(name: "Palatino-Italic", size: 20)
            messageLabel.sizeToFit()
            
            self.tableView.backgroundView = messageLabel
        }
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return persons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Celda", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let person = persons[indexPath.row] as Person
        cell.textLabel.text = person.name
        cell.detailTextLabel?.text = "☎︎ \(person.phone) 😘 \(person.score)"
        cell.imageView.image = UIImage(named: person.photo)

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
        
        let person = self.persons[indexPath.row] as Person
        
        if editingStyle == .Delete {
            // Borramos los datos
            
            var refreshAlert = UIAlertController(title: "Eliminar", message: "Se eliminará el contacto \(person.name).", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Borrar", style: .Default, handler: { (action: UIAlertAction!) in
                // TODO: hacer la llamada al modelo
                //self.persons.removeAtIndex(indexPath.row)
                self.appDelegate.deleteObject(person)
                self.persons = self.appDelegate.loadData()
                
                // Delete the row from the data source
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .Default, handler: { (action: UIAlertAction!) in
                NSLog("Borrado cancelado")
                // Ocultamos el botón de borrado
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // pintamos las celdas de colores alternos
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(white: 0.7, alpha: 0.1)
            tableView.backgroundView = nil // quitamos el aviso de no hay datos porque se "transparenta"
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
            var person = self.appDelegate.createObject("Person") as Person
            person.name = ""
            vc.person = person
        }
        
        if (segue.identifier == "Edit") {
            NSLog("Vamos al segue Edit")
            var vc: EditViewController = segue.destinationViewController as EditViewController
            // Pasarle la person de la Celda
            var person = persons[tableView.indexPathForSelectedRow()!.row] as Person
            vc.person = person
        }
        
        if (segue.identifier == "Detail") {
            NSLog("Vamos al segue Detail")
            var vc: DetalleViewController = segue.destinationViewController as DetalleViewController
            // Pasarle la person de la Celda
            //var p = self.persons.objectAtIndex(tableView.indexPathForSelectedRow()!.row) as Person
            var index = tableView.indexPathForSelectedRow()!.row
            
            NSLog("Vamos a recuperar la celda: \(index)")
            var person = self.persons[index] as Person
            NSLog("Vamos a mostrar a: \(person.name)")
            vc.person = person
        }
        
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        NSLog("Tap en el accesorio de la celda con índice: \(indexPath.row)")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // esto nos permite realizar el segue condicional
        // en función del modo de la tabla (editar - normal)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if cell.reuseIdentifier == "Celda" {
            if self.tableView.editing {
                self.performSegueWithIdentifier("Edit", sender: cell)
            } else {
                let person = self.persons[tableView.indexPathForSelectedRow()!.row] as Person
                NSLog("Vamos a llamar a: %@", person.name)
                makePhoneCall(person.phone)
            }
        }
    }
    
}
