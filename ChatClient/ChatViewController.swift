//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Anisha Jain on 4/12/17.
//  Copyright © 2017 Anisha Jain. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messageObject = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendButton(_ sender: Any) {
        var chatMessage = PFObject(className:"Message")
        chatMessage["text"] = chatText.text
        chatMessage.saveInBackground { (success: Bool, error: Error?) in
            if (success) {
                print("Saved message")
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: "onTimer", userInfo: nil, repeats: true)

            } else {
                print(" There was a problem, check error.description", error?.localizedDescription)
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messageObject != nil {
            print("count: ", messageObject.count)
            return messageObject.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        print("messageObject", messageObject[indexPath.row]["text"])
        cell.messageBoardLabel.text = messageObject[indexPath.row]["text"] as? String
        return cell
    }
    
    func onTimer() {
        var query = PFQuery(className:"Message")
        query.whereKey("text", equalTo:"")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                    }
                    self.tableView.reloadData()
                    self.messageObject = objects
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.localizedDescription)")
            }

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
