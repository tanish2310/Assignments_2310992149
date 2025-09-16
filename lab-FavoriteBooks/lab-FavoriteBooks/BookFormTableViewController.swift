//
//  BookFormTableViewController.swift
//  lab-FavoriteBooks
//
//  Created by Himanshi Godara on 26/08/25.
//

import UIKit

class BookFormTableViewController: UITableViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    
    @IBOutlet weak var authorTextField: UITextField!
    
    
    
    @IBOutlet weak var genreTextField: UITextField!
    

    @IBOutlet weak var lengthTextField: UITextField!
    
   
    var createdBook: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Book"
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        guard let title = titleTextField.text, !title.isEmpty,
                      let author = authorTextField.text, !author.isEmpty,
                      let genre = genreTextField.text, !genre.isEmpty,
                      let length = lengthTextField.text, !length.isEmpty else {
                    return
                }

                createdBook = Book(title: title, author: author, genre: genre, length: length)
                performSegue(withIdentifier: "UnwindToBookTable", sender: self)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
