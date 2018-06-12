//
//  AllowViewController.swift
//  Produvar
//
//  Created by Олеся Максакова on 15.05.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class AllowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func allowClick(_ sender: Any) {
        self.performSegue(withIdentifier: "mainControllerSegue", sender: self)
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
