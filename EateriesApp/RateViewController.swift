//
//  RateViewController.swift
//  EateriesApp
//
//  Created by Dev Apps4Selling on 14/01/2019.
//  Copyright © 2019 Dev Apps4Selling. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {

    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var badRate: UIButton!
    @IBOutlet weak var midRate: UIButton!
    @IBOutlet weak var highRate: UIButton!
    var restRating : String?
    @IBAction func rateRestaraunt (sender: UIButton) {
        switch sender.tag {
        case 0: restRating = "smile_3"
        case 1: restRating = "smile_2"
        case 2: restRating = "smile_1"
        default:
            break
        }
        performSegue(withIdentifier: "unwindSegueToDVC", sender: sender)
    }
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 0.4) {
//            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        }
        let buttonArray = [badRate, midRate, highRate]
        for (index, button) in buttonArray.enumerated() {
            let delay = Double(index) * 0.2
            UIView.animate(withDuration: 0.3, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                button?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        badRate.transform = CGAffineTransform(scaleX: 0, y: 0)
        midRate.transform = CGAffineTransform(scaleX: 0, y: 0)
        highRate.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.view.insertSubview(blurEffectView, at: 1)
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
