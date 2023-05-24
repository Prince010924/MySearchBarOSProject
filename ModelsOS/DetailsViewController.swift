//
//  DetailsViewController.swift
//  ModelsOS
//
//  Created by DA MAC M1 124 on 2023/05/24.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var theTitleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var numLabel: String?
    var titleLbl: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theTitleLabel.text = titleLbl
        numberLabel.text = numLabel
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
