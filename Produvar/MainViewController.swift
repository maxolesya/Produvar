//
//  MainViewController.swift
//  Produvar
//
//  Created by Олеся Максакова on 15.05.18.
//  Copyright © 2018 HSEProject. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func authClick(_ sender: Any) {
         self.performSegue(withIdentifier: "authSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 10, height: 40))
        imageView.contentMode = .scaleAspectFit
        // 4
        let image = UIImage(named: "produvar_name_logo.png")
        imageView.image = image
        if image==nil{print("nil")}
        // 5
        navigationItem.titleView = imageView
        
print("here")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
