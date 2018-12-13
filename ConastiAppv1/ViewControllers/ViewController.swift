//
//  ViewController.swift
//  ConastiAppv1
//
//  Created by Yanela Pachacama Quispe on 8/11/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth

class ViewController: UIViewController{
    
    
    @IBOutlet weak var logincustom: UIButton!
 
    
    //Login Custom here
    
    @IBAction func loginBtn(_ sender: Any) {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self)
        { (result, err) in
            if !(result?.isCancelled)!{
            
                if err == nil {
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                        if let error = error {
                            print(error)
                            return
                        }
                        let token = FBSDKAccessToken.current().tokenString
                        print(token!)
                        print("Inicio exitoso Facebook - Firebase")
                        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, first_name,last_name, email, picture.width(500).height(500),birthday"]).start(completionHandler: { (connection, result, err) in
                            if err != nil{
                                print("Error en el request", err!)
                                return
                            }
                            let userData = result as! NSDictionary
                            
                            User.email = userData["email"] as! String
                            print(User.email)
                            
                            User.nombre = userData["first_name"] as! String
                            print(User.nombre)
                            
                            User.apellido = userData["last_name"] as! String
                            print(User.apellido)
                            
                            //User.cumpleaños = userData["birthday"] as! String
                            //print(User.cumpleaños)
                            
                            User.uid = userData["id"] as! String
                            print(User.uid)
                            
                             print(userData)
                            
                          let pictureUser1 = (userData["picture"])! as! NSDictionary
                           let pictureUser2 = (pictureUser1["data"])! as! NSDictionary
                            
                         User.imagenURL = pictureUser2["url"] as! String
                            print(User.imagenURL)
                       
                            let post = [
                                "token" : token!,
                                "nombre" : userData["first_name"] as! String,
                                "email" : userData["email"] as! String ,
                                "profile_url" : pictureUser2["url"] as! String,
                                "apellido" : userData["last_name"] as! String
                            ]
                            
                            
                            Database.database().reference().child("usuarios").child(User.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                              
                                let value = snapshot.value as? NSDictionary
                                print("-----------------")
                                print(value)
                                print("-----------------")
                                if value == nil {
                                    Database.database().reference().child("usuarios").child(userData["id"] as! String).setValue(post)
                                }
                               
                            }) { (error) in
                                print(error.localizedDescription)
                            }
                             self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                            
                        }
                        )
                    }
                   
                   
                }
                
            }
            
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        logincustom.layer.cornerRadius = 10
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "fondo5.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        if (FBSDKAccessToken.current() != nil){
            print("usuario autenticado")
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    
    
}


