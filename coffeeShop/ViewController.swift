//
//  ViewController.swift
//  coffeeShop
//
//  Created by Kenyan Houck on 4/29/19.
//  Copyright © 2019 Kenyan Houck. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import GoogleSignIn

class ViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var food = Food()
    var authUI: FUIAuth!
    var foodArray = ["ddd", "ssss"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        food.getFood {
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.sortBasedOnSegmentPressed()
    }
    
    func signIn(){
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth()
        ]
        
        if authUI.auth?.currentUser == nil {
            self.authUI.providers = providers
            present(authUI.authViewController(), animated: true, completion: nil)
        } else {
            tableView.isHidden = false
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowDetail"{
//            let destination = segue.destination as! DetailViewController
//            let selectedIndexPath = tableView.indexPathForSelectedRow!
//            destination.champDetail.name = champion.championArray[selectedIndexPath.row].name
//            destination.champDetail.apiURL = champion.apiURL
//        }else {
//            if let selectedPath = tableView.indexPathForSelectedRow {
//                tableView.deselectRow(at: selectedPath, animated: true)
//            }
//        }
//    }
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        do{
            try authUI.signOut()
            tableView.isHidden = true
            signIn()
        } catch {
            tableView.isHidden = true
            print("Couldnt sign out")
        }
        
    }
    func sortBasedOnSegmentPressed() {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // A-Z
            food.foodArray.sort(by: {$0.title < $1.title})
        case 1: // Z-A
            food.foodArray.sort(by: {$0.publisher < $1.publisher})
        case 2: // Difficulty
            food.foodArray.sort(by: {$0.social_rank > $1.social_rank })
        default:
            print("Default option")
        }
        tableView.reloadData()
    }
    
    @IBAction func sortSegmentPressed(_ sender: UISegmentedControl) {
        sortBasedOnSegmentPressed()
    }
    
    
    
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = foodArray[indexPath.row]
        return cell
    }
    
    
}

extension ViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if let user = user {
            tableView.isHidden = false
            print("WE SIGNED IN with \(user.email)")
        }
    }
    
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        let loginViewController = FUIAuthPickerViewController(authUI: authUI)
        loginViewController.view.backgroundColor = UIColor.black
        
        let marginInsets: CGFloat = 16
        let imageHeight: CGFloat = 225
        let imageY = self.view.center.y-imageHeight
        let logoFrame = CGRect(x: self.view.frame.origin.x + marginInsets, y: imageY, width: self.view.frame.width - (marginInsets*2), height: imageHeight)
        let logoImageView = UIImageView(frame: logoFrame)
        logoImageView.image = UIImage(named: "2nd-Logo")
        logoImageView.contentMode = .scaleAspectFit
        loginViewController.view.addSubview(logoImageView)
        return loginViewController
    }
}

