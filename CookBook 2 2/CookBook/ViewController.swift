//
//  ViewController.swift
//  CookBook
//
//  Created by Suda gowtham kumar reddy on 23/02/21.
//  Copyright © 2021 Suda gowtham kumar reddy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class ViewController: UIViewController,LoginButtonDelegate {
    var detailsArr = [["dishesImg":["ROTI","RICE","BENDI FRY","DAL FRY","RAVA KESARI"],"dishesName":["Roti","Rice","Bendi fry","Dal","Rava kesari"]],
                      
["dishesImg":["Puerto Rico- Mofongo.","Antigua and Barbuda- Fungee and Pepperpot.-1","Bahamas- Conch Fritters.","Barbados- Coucou and Flying Fish.","Trinidad & Tobago- Crab & Callaloo."],"dishesName":["Mofongo","Fungee","Conch Fritters","Coucou & Fish","Crab & Callaloo"]],

["dishesImg":["Bratwurst (Grilled Sausage)","Sauerbraten","Kartoffelpuffer (Potato Pancake)","Rinderroulade (Beef Roll)","Schweinshaxe (Pork Knuckle)"],"dishesName":["Bratwurst","Sauerbraten","Kartoffelpuffer","Rinderroulade","Schweinshaxe"]],

["dishesImg":["Pho","Bun cha","Banh cuon","Banh mi","Goi cuon"],"dishesName":["Pho","Bun cha","Banh cuon","Banh mi","Goi cuon"]]]
    
    
    
    
    var cusineScrollView = UIScrollView()
    var signUpBtn = UIButton(type: UIButton.ButtonType.roundedRect)
    var cusineView:UIView!
    var cusineImgView:UIImageView!
    var cusineImgArr = ["IndianCusine","CaribbeanCusine","GermanCusine","vietnamese Cusinr"]
    var cusineArr = ["Indian Cusine","Caribbean Cusine","German Cusine","Vietnam Cusine"]
    var cusineViewTapGstr:UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayComponents()
            }
    //creating a function to display UI components
    func displayComponents(){
        //adding scroll to view and seting frame to scroll view
        cusineScrollView.frame = CGRect(x: 15, y: 90, width: view.frame.width-30, height: view.frame.height-240)
        cusineScrollView.backgroundColor = .lightGray
        cusineScrollView.layer.cornerRadius = 50
        view.addSubview(cusineScrollView)
        //adding signUpBtn to view and setting frame to signUpBtn
        signUpBtn.frame = CGRect(x: 15, y: 780, width: view.frame.width-30, height: 70)
        signUpBtn.layer.cornerRadius = 20
        signUpBtn.setTitle("Sign Up", for: UIControl.State.normal)
        signUpBtn.addTarget(self, action: #selector(signUpACtion), for: UIControl.Event.touchUpInside)
        signUpBtn.backgroundColor = .white
        view.addSubview(signUpBtn)
        //adding cusineView to scroll view
        var val = 0
        for i in 0..<detailsArr.count{
            //creating an instance of cusine view and adding frame to cusine view
           cusineView = UIView()
            cusineView.frame = CGRect(x: 15, y: 80+val+20, width: 330, height: 240)
            cusineView.backgroundColor = .white
            cusineView.clipsToBounds = true
            cusineView.layer.cornerRadius = 30
            cusineView.isUserInteractionEnabled = true
            cusineView.tag = i
            //adding tap guester to cusine view
            cusineViewTapGstr = UITapGestureRecognizer(target: self, action: #selector(cusineViewTapAction(sender:)))
            cusineView.addGestureRecognizer(cusineViewTapGstr)
            cusineScrollView.addSubview(cusineView)
            //creating a label to display movie title
            var cusineNameLbl = UILabel()
            cusineNameLbl.frame = CGRect(x: 180, y: 20, width: 150, height: 80)
            cusineNameLbl.font = UIFont(name: "Rockwell-Bold", size: 22)
            cusineNameLbl.text = "\(cusineArr[i])"
            cusineNameLbl.textColor = .black
            cusineNameLbl.numberOfLines = 0
            cusineView.addSubview(cusineNameLbl)
            
           //creating an instance of cusineImgView annd adding frame to cusine button
             cusineImgView = UIImageView(image: UIImage(named: "\(cusineImgArr[i])"))
            cusineImgView.frame = CGRect(x: 15, y: 60+val, width: 150, height: 240)
            cusineImgView.clipsToBounds = true
            cusineImgView.layer.cornerRadius = 30
            cusineScrollView.addSubview(cusineImgView)
            cusineScrollView.contentSize = CGSize(width: view.frame.width-40, height: cusineView.frame.maxY+20)
            val+=320
        }
        //adding button to cusineCsrollview
        
    }
    @objc func signUpACtion(){
        if let token = AccessToken.current,!token.isExpired {
               let token = token.tokenString
               
               let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
               
               request.start(completionHandler: { connection, result, error in
                   print("\(result)")
               })
            }
            else{
                let loginButton = FBLoginButton()
                loginButton.frame = CGRect(x: 15, y: 780, width: view.frame.width-30, height: 70)
                loginButton.delegate = self
                
                loginButton.permissions = ["public_profile", "email"]
                
                view.addSubview(loginButton)
            }
        
            let loginButton = FBLoginButton()
            loginButton.frame = CGRect(x: 15, y: 780, width: view.frame.width-30, height: 70)
            loginButton.delegate = self
            
            view.addSubview(loginButton)

    }
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
     let token = result?.token?.tokenString
     
     let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email,name"], tokenString: token, version: nil, httpMethod: .get)
     
     request.start(completionHandler: { connection, result, error in
         print("\(result)")
     })
     
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    

    //creating a function to add tap action to cusine view
    @objc func cusineViewTapAction(sender:UITapGestureRecognizer){
        var dishesVC = storyboard?.instantiateViewController(identifier: "dvc") as! DishesViewController
        dishesVC.modalTransitionStyle = .coverVertical
        print("taped\(detailsArr[0]["dishesImg"])")
        dishesVC.cusineNameArr = cusineArr[sender.view!.tag]
        dishesVC.cusineImageArr = cusineImgArr[sender.view!.tag]
        dishesVC.displayDishes = detailsArr[sender.view!.tag]
        navigationController?.pushViewController(dishesVC, animated: true)
    }

}

