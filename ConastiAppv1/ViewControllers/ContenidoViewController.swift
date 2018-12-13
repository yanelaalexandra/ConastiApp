//
//  ContenidoViewController.swift
//  ConastiAppv1
//
//  Created by Yanela Pachacama Quispe on 11/12/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit
import Cards
import Player
import Alamofire
import SwiftyJSON

class ContenidoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var contenidoLabel: UILabel!
    
    @IBOutlet weak var viewcontenido: UIView!
    
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var viewcategoria: UIView!

    var stringContent = ""
    
    var stringEvento = ""
    
    var stringUUID = ""
    
    var stringNoticiaUUID = ""
    
    var nombres:[String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contenidoLabel.text! = stringContent
        viewcontenido.layer.cornerRadius = 10
        viewcontenido.clipsToBounds = true
        viewcategoria.layer.cornerRadius = 10
        viewcategoria.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        favBtn.layer.cornerRadius = 15
        favBtn.clipsToBounds = true
        fetchUserData2(stringUUID)
    
    }
    
    
    @IBAction func favoritoTapped(_ sender: Any) {
        fetchUserData(User.uid, stringUUID)
    }
    
    
    
    func fetchUserData(_ uuid:String,_ id:String){
        DispatchQueue.main.async {
            Alamofire.request("https://conasti-app-v3-sebasraureyes.c9users.io/noticia/setfavorito/\(uuid)/\(id)").responseJSON(completionHandler: {(response) in
                switch response.result{
                case .success(let value):
                    //var json = JSON(value)
                    print("Success")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            
        }
    }
    
    var jsonString:JSON = []
    
    func fetchUserData2(_ uuid:String){
        DispatchQueue.main.async {
            Alamofire.request("https://conasti-app-v3-sebasraureyes.c9users.io/noticia/categorias/\(uuid)").responseJSON(completionHandler: {(response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    for (key, subJson) in json["categoria"] {
                        if let titulo = subJson["nombre"].string {
                            self.nombres.append(titulo)
                        }
                    }
                self.tableView.reloadData()
                print(self.nombres)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nombres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nombres[indexPath.row]
        
        return cell
    }
    
    
    
    
   
}
