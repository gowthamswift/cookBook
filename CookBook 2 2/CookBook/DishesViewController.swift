//
//  DishesViewController.swift
//  CookBook
//
//  Created by Lenovo on 23/02/21.
//  Copyright © 2021 Suda gowtham kumar reddy. All rights reserved.
//

import UIKit

class DishesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        var predicateObj = NSPredicate(format: "self contains[c] %@", searchBarInt.text! )
        
        filterdArr = ([displayDishes] as NSArray).filtered(using: predicateObj) as! [String]
         
        
        
    }
    
    var reciepeDetails = [["ingradientsArr":["3 cup wheat flour","tsp salt","warm water","oil"],"stepsToFollow":["After you rinse your rice, pour fresh water (for every cup of rice, use 1¾ cups of water) into a large saucepan with a tight-fitting lid. Bring to a boil. Mix 1 teaspoon salt into the water."],"duration":["20 minutes"]],["ingradientsArr":["Measuring cup","Water","Saucepan with lid","Salt","Rice","Wooden spoon","Fork"],"stepsToFollow":["After you rinse your rice, pour fresh water (for every cup of rice, use 1¾ cups of water) into a large saucepan with a tight-fitting lid. Bring to a boil. Mix 1 teaspoon salt into the water.","Add the rice to the boiling water.","Use a wooden spoon to separate any clumps. Don’t over-stir: That can cause the rice to become sticky.","Be sure the lid fits tightly on the pan. Turn down the heat to its lowest setting. Let rice simmer for about 18 minutes, then remove from heat and allow the rice to steam in the pan for another 5 minutes."],"":["firstly, put the rolled dough over hot tawa.","cook on medium flame until the base is fully cooked.","once the base is fully cooked turn over. the roti will start to puff up.","once the roti puffs up press gently to puff uniformly.","finally, roti is ready."],"duration":["18 min"]],["ingradientsArr":["3 tbsp oil 10 okra bhindi","chopped ½ tsp cumin","tsp ginger-garlic paste","green chilli, slit","onion, thinly sliced"],"stepsToFollow":["firstly, in a large kadai heat oil.","further add chopped okra.","coat well with oil and spread the bhindi.","stir occasionally, making sure the bhindi gets cooked well from all the sides.","stir occasionally, making sure the bhindi gets cooked well from all the sides.","also fry till the bhindi turn slight golden brown.","transfer to a plate and keep aside.","further saute cumin and hing till they turn aromatic."],"duration":"20 minutes"],["ingradientsArr":["tablespoon salad oil","teaspoon cumin seeds","¼ teaspoon ground cardamom","1 quart vegetable or fat-skimmed chicken broth","1 ½ cups dried Red Chief lentils (12 oz.; see notes), sorted and rinsed","1 cup chopped onion","About 1/4 cup chopped fresh cilantro","Salt"],"stepsToFollow":["In a 5- to 6-quart pan over medium-high heat, frequently stir oil, cumin, and cardamom just until spices are fragrant, 1 to 1 1/2 minutes. Add broth, lentils, onion, 1/4 cup cilantro, ginger, chilies, garlic, and turmeric. Bring to a boil over high heat; reduce heat, cover, and simmer, stirring often, until lentils fall apart, about 15 minutes."],"duration":["25 minutes"]],["ingradientsArr":[" 2 tbsp + ¼ cup ghee / clarified butter","10 cashews / kaju, halves"," tbsp raisins / kishmish / dry grapes"," ½ cup bombay rava / sooji / semolina, fine"," 1 cup water"," cup sugar, add ½-1 cup depending on your choice"],"stepsToFollow":["firstly, heat 2 tbsp ghee / clarified butter and roast 10 cashews, 1 tbsp raisins on low flame.","once the cashews turn golden brown, keep aside.","now in the same ghee roast ½ cup bombay rava. use fine / coarse variety rava.","roast on low flame for 5 minutes or till it turns aromatic. keep aside.","in a large kadai boil 1 cup water."],"duration":["40 minutes"]]]
    @IBOutlet weak var searchBarInt: UISearchBar!
    var displayDishes = [String:[String]]()
    @IBOutlet weak var cusineImg: UIImageView!
    var cusineNameArr:String?
    var cusineImageArr:String?
    @IBOutlet weak var dishNameLbl: UILabel!
    @IBOutlet weak var dishesTV: UITableView!
    var filterdArr = [String]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        displayComponentsOfDishes()
        // Do any additional setup after loading the view.
    }
    
    //creating a function to display components in UI
    func displayComponentsOfDishes(){
        dishesTV.separatorStyle = .none
        //adding delegates to didhesTV
        dishesTV.delegate = self
        dishesTV.dataSource = self
        //registering resuable cell
        dishesTV.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let dishNibId = UINib(nibName: "DishesTableViewCell", bundle: nil)
        dishesTV.register(dishNibId, forCellReuseIdentifier: "Cell")
        //cusineImg.image = UIImage(named: "\(displayDishes["dishesImg"]![0])")
        //display dish name
        //dishNameLbl.text = "\(displayDishes["dishesName"]![0])"
        cusineImg.layer.cornerRadius = 20
        cusineImg.image = UIImage(named: "\(cusineImageArr!)")
        dishNameLbl.text = cusineNameArr!+"\nDishes"
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayDishes["dishesName"]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //creating an instance of tableview resuable cell
        let cell = dishesTV.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DishesTableViewCell
        //thread error handling
        DispatchQueue.main.async {
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 20
            //displaying dish image in cell image
            cell.dishImg?.image = UIImage(named: "\(self.displayDishes["dishesImg"]![indexPath.row])")
            //displaying dish name in cell label
            cell.dishName?.text = "\(self.displayDishes["dishesName"]![indexPath.row])"
            cell.dishName.textColor = .white
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    //adding action to cell if cell is taped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("taped on cell")
        var reciepeVC = storyboard?.instantiateViewController(identifier: "rvc") as! ReciepeViewController
        reciepeVC.details.append("\(reciepeDetails[indexPath.row]["ingradientsArr"]!)")
        reciepeVC.details.append("\(reciepeDetails[indexPath.row]["stepsToFollow"]!)")
        reciepeVC.details.append("\(reciepeDetails[indexPath.row]["duration"]!)")
        reciepeVC.details.append("\(displayDishes["dishesImg"]![indexPath.row])")
        //going to ReciepeViewController on click of cell
        present(reciepeVC, animated: true) {
            print("ReciepeViewController")
            reciepeVC.displayComponents()
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
