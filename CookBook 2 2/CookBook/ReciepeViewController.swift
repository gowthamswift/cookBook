//
//  ReciepeViewController.swift
//  CookBook
//
//  Created by Lenovo on 25/02/21.
//  Copyright © 2021 Suda gowtham kumar reddy. All rights reserved.
//

import UIKit

class ReciepeViewController: UIViewController {
    @IBOutlet weak var durationLbl: UILabel!
    
    @IBOutlet weak var followStepsView: UIView!
    @IBOutlet weak var ingradientsLbl: UILabel!
    @IBOutlet weak var dishImgView: UIImageView!
    var stepsToFollowView = UIView()
    var details = [String]()
    var stepsToFollowLbl = UILabel()
    var swipeUpGstr = UISwipeGestureRecognizer()
    var swipeDownGstr = UISwipeGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        displayComponents()
        // Do any additional setup after loading the view.
    }
    //creating a function to display components
    func displayComponents(){
        //setting frame to view and adding to view
        stepsToFollowView.frame = CGRect(x: 30, y: 780, width: 360, height: view.frame.height)
        stepsToFollowView.backgroundColor = .systemRed
        stepsToFollowView.layer.cornerRadius = 50
        //adding swipe up guester to view
        swipeUpGstr.addTarget(self, action: #selector(swipeUpAction))
        swipeUpGstr.direction = .up
        stepsToFollowView.addGestureRecognizer(swipeUpGstr)
        //adding swipe down guester to view
        swipeDownGstr.addTarget(self, action: #selector(swipeDownAction))
        swipeDownGstr.direction = .down
        stepsToFollowView.addGestureRecognizer(swipeDownGstr)
        //view.addSubview(stepsToFollowView)
        //setting frame to label and adding label to stepsToFollowView
        stepsToFollowLbl.frame = CGRect(x: 30, y: 250, width: 400, height: 300)
        stepsToFollowLbl.numberOfLines = 0
        view.addSubview(stepsToFollowLbl)
        //displaying dish image
        dishImgView.image = UIImage(named: "\(details[3])")
        //displaying ingradeients in label
        ingradientsLbl.text = "Ingradients : \n\(details[0])".replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: "\n")
        //displaying steps to follow in label
        stepsToFollowLbl.text = "STeps to follow : \n\(details[1])".replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: "\n")
        //displaying duration time for reciepe
        durationLbl.text = "Duration time :\(details[2])".replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "\"", with: "")
    }
    //creating a function to swipe up guester
    @objc func swipeUpAction(){
        if swipeUpGstr.direction == .up{
            stepsToFollowView.frame = CGRect(x: 30, y: 200, width: 360, height: view.frame.height)
        }
    }
    //creating a function swipe down action
    @objc func swipeDownAction(){
        if swipeDownGstr.direction == .down{
            stepsToFollowView.frame = CGRect(x: 30, y: 780, width: 360, height: view.frame.height)
            
        }
    }
    
    @IBAction func backBtnACtion(_ sender: Any) {
        //going back on press of back buton
        dismiss(animated: true) {
            print("went back")
        }
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
