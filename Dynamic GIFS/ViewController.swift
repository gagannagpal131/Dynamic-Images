//
//  ViewController.swift
//  Dynamic GIFS
//
//  Created by Gagandeep Nagpal on 03/06/17.
//  Copyright © 2017 Gagandeep Nagpal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    var image_url :String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }
    
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        
        //TO check which button has been pressed using button tags
       let image_no = (sender as AnyObject).tag
        
        var ref: DatabaseReference!
        var refHandle:DatabaseHandle
        
        ref = Database.database().reference()
        
        //to geneate the final image string that will be used to receive data from firebase
        let image_str = "image" + String(describing: image_no!)
        print(image_str)
        
        
        //fetching URl of image from firebase
        refHandle = ref.child("images").observe(DataEventType.value, with: { (snapshot) in
            let image_url1 = snapshot.value as? NSDictionary
            
            //final string that will be used
            self.image_url = (image_url1?[image_str] as! String)
            print(self.image_url)
            
            
            //converting the string to url
            let PictureURL = URL(string: self.image_url)!
            let pic_data = try? Data(contentsOf: PictureURL)
           // print(pic_data ?? "none")
            self.image.image = UIImage(data: pic_data!)

            
        })
        
        
        /*
        let PictureURL = URL(string: image_url)!
        let pic_data = try? Data(contentsOf: PictureURL)
        print(pic_data ?? "none")
        image.image = UIImage(data: pic_data!)
        */
 
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

