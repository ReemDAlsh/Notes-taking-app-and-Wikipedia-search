//
//  NoteTakingViewController.swift
//  TheWikipediaSearch
//
//  Created by Reem alsharif on 9/7/17.
//  Copyright © 2017 Reem alsharif. All rights reserved.
//

import UIKit

class NoteTakingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
   
    var mydata: [String] = []
    var selectedRow: Int = -1
    var newRowText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set title for the page 
        self.title = "My qoutes "
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddNew))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        load()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        mydata[selectedRow] = newRowText
        if newRowText == "" {
            mydata.remove(at: selectedRow)
        }
        table.reloadData()
        save()
    }
    
    func AddNew(){
        
        if (table.isEditing){
            return
        }
        let name:String = ""
        mydata.insert(name, at: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "details", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mydata.count
        
        
    }
   
   
  
    // to select a specifc row in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //self.performSegue(withIdentifier: "details", sender: nil)
        print("\(mydata[indexPath.row])")
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = mydata[indexPath.row]
        return cell
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        mydata.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .automatic)
        
        save()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailView:DetailsViewController = segue.destination as! DetailsViewController
        selectedRow = table.indexPathForSelectedRow!.row
        detailView.masterView = self
        detailView.setText(t: mydata[selectedRow])
        
    }
    func save() {
    UserDefaults.standard.set(mydata, forKey: "notes")
   // UserDefaults.standard.synchronize()
    
    }
    
    func load()
    {
        if let loadedData = UserDefaults.standard.value(forKey: "notes") as? [String]{
           
            mydata = loadedData
            table.reloadData()
        }
        
     
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
