//
//  ViewController.swift
//  cafe_mini_app
//
//  Created by MILES RICHMOND on 9/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var menuItemList: UITextView!
    @IBOutlet weak var menuPriceList: UITextView!
    
    @IBOutlet weak var cartItemList: UITextView!
    @IBOutlet weak var cartPriceList: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet weak var cartAdd: UITextField!
    
    @IBOutlet weak var adminPassword: UITextField!
    let adminPass: String = "Extremely Unsafe"
    @IBOutlet weak var adminButton: UIButton!
    var admin: Bool = false;
    
    var menuItems: [String] = ["1 lb of Butter", "3 oz Flour","Salt Rock","Chicken Bucket","Nachos with Cod Fillet"]
    var menuPrices: [Double] = [3.18,0.04,4.31,25.99,21.99]
    
    var cart: [String : Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func cartAddAction(_ sender: UIButton) {
        if(cartAdd.text! == "" || ( !menuItems.contains(cartAdd.text!) && !admin)) {
            invalidLabel.isHidden = false
        } else {
            invalidLabel.isHidden = true
            if let index = menuItems.firstIndex(of: cartAdd.text!) {
                cart[menuItems[index]] = menuPrices[index]
            } else if (admin) {
                if(Double(adminPassword.text!) == nil) {
                    invalidLabel.isHidden = false
                } else {
                    menuItems.append(cartAdd.text!)
                    menuPrices.append(Double(adminPassword.text!)!)
                }
            } else {
                invalidLabel.isHidden = false
            }
        }
        
        update(sorting: false)
    }
    
    @IBAction func cartRemoveAction(_ sender: UIButton) {
        if(cartAdd.text! == "" || ( !menuItems.contains(cartAdd.text!) && !admin)) {
            invalidLabel.isHidden = false
        } else {
            invalidLabel.isHidden = true
            if(!admin) {
                cart.removeValue(forKey: cartAdd.text!)
            } else if let index = menuItems.firstIndex(of: cartAdd.text!) {
                menuItems.remove(at: index)
                menuPrices.remove(at: index)
            } else {
                invalidLabel.isHidden = false
            }
        }
        
        update(sorting: false)
    }
    
    @IBAction func adminLogIn(_ sender: UIButton) {
        if(adminPassword.text == adminPass) {
            admin = true
            adminButton.backgroundColor = UIColor.red
        } else {
            admin = false
            adminButton.backgroundColor = UIColor.lightGray
        }
        adminPassword.text = ""
    }
    
    func update(sorting: Bool) {
        var itemString: String = ""
        var priceString: String = ""
        
        if(admin || sorting) {
            for item in menuItems {
                itemString.append("\(item)\n")
            }
            
            for price in menuPrices {
                priceString.append("$\(price)\n")
            }
            
            menuItemList.text = "Item:\n\(itemString)"
            menuPriceList.text = "Price:\n\(priceString)"
            return
        }
        
        for (item, price) in cart {
            itemString.append("\(item)\n")
            priceString.append("$\(price)\n")
        }
        cartItemList.text = "Item:\n\(itemString)"
        cartPriceList.text = "Price:\n\(priceString)"
        
        
        
        var sum: Double = 0
        for (_,price) in cart {
            sum += price
        }
        priceLabel.text = "$\(sum)"
    }
    
    @IBAction func sortPrice(_ sender: UIButton) {
        var tempDict: [Double : String] = [:]
        for i in menuPrices {
            tempDict[i] = menuItems[menuPrices.firstIndex(of: i)!]
        }
        menuPrices.sort()
        
        for i in menuPrices.indices {
            let index = menuPrices[i]
            menuItems[i] = tempDict[index]!
        }
        
        update(sorting: true)
    }
    
    @IBAction func sortName(_ sender: UIButton) {
        var tempDict: [String : Double] = [:]
        for i in menuItems {
            tempDict[i] = menuPrices[menuItems.firstIndex(of: i)!]
        }
        
        menuItems.sort()
        
        for i in menuItems.indices {
            let index = menuItems[i]
            menuPrices[i] = tempDict[index]!
        }
        
        update(sorting: true)
    }
}


