//
//  DashboardViewController.swift
//  ConastiAppv1
//
//  Created by Yanela Pachacama Quispe on 8/11/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//
//---------------------------------------------
//
//FUNCIÓN PARA CONECTAR API
/*func fetchUserData(){
 DispatchQueue.main.async {
 Alamofire.request("https://conasti-app-v3-sebasraureyes.c9users.io/test").responseJSON(completionHandler: {(response) in
 switch response.result{
 case .success(let value):
 let json = JSON(value)
 print(json)
 case .failure(let error):
 print(error.localizedDescription)
 }
 })
 }
 }*/

/*
 func card(){
 let card = CardHighlight(frame: CGRect(x: 10, y: 100, width: 350 , height: 200))
 card.backgroundImage = UIImage(named:"fondo7.jpg")
 card.icon = UIImage(named: "Icon-v1.png")
 card.title = "Welcome \nto \nCards !"
 card.itemTitle = "Flappy Bird"
 card.itemSubtitle = "Flap That !"
 card.textColor = UIColor.white
 
 
 card.hasParallax = true
 
 let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "CardContent")
 card.shouldPresent(cardContentVC, from: self, fullscreen: false)
 view.addSubview(card)
 
 }
 */
//
//---------------------------------------------


import UIKit
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit
import Cards
import Player
import Alamofire
import SwiftyJSON

class DashboardViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var collectionView: UICollectionView?
    
    @IBAction func SalirBTN(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print("Saliendo")
        User.email = ""
        User.nombre = ""
        User.imagenURL = ""
        FBSDKLoginManager().logOut()
    }

    var data = [[String : AnyObject]]()
    
    var ids : [String] = []
    var titulos : [String] = []
    var contenidos : [String] = []
    var categorias : [Any] = []
    var fondos : [String] = []
    var fechas : [String] = []
    var horas : [String] = []
    var eventos : [String] = []
    var iconos : [String] =  []
    
    var refrescar = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        /*let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.backgroundColor = UIColor.white
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)*/
        addSlideMenuButton()
        //card()
        print("USER ID \(User.uid)")
        fetchUserData(User.uid)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(titulos.count)
        
        return titulos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //----------------
        let card = CardHighlight(frame: CGRect(x: 10, y: 10, width: 350 , height: 200))
        card.backgroundImage = UIImage(named:self.fondos[indexPath.item])
        card.icon = UIImage(named: iconos[indexPath.item])
        card.title = self.titulos[indexPath.item]
        card.itemTitle = self.fechas[indexPath.item]
        card.itemSubtitle = self.horas[indexPath.item]
        card.textColor = UIColor.white
        card.hasParallax = true

        let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "CardContent") as! ContenidoViewController
    
            cardContentVC.stringContent = self.contenidos[indexPath.item]
            cardContentVC.stringEvento = self.eventos[indexPath.item]
            cardContentVC.stringUUID = self.ids[indexPath.item]
       
        
        card.shouldPresent(cardContentVC, from: self, fullscreen: false)
        
        cell.addSubview(card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 100, heigth: 100)
        let width = (UIScreen.main.bounds.size.width * 10)
        let height = width
        return CGSize(width: width, height: height)
    }
    
    
    func fetchUserData(_ uuid:String){
        DispatchQueue.main.async {
            Alamofire.request("https://conasti-app-v3-sebasraureyes.c9users.io/noticia/usuario/\(uuid)").responseJSON(completionHandler: {(response) in
                switch response.result{
                case .success(let value):
                var json = JSON(value)
                //print(json)
                
                for (key, subJson) in json["noticias"] {
                    if let titulo = subJson["titulo"].string {
                        self.titulos.append(titulo)
                    }
                    if let contenido = subJson["contenido"].string {
                        self.contenidos.append(contenido)
                    }
                    if let fecha = subJson["fecha"].string {
                        self.fechas.append(fecha)
                    }
                    if let hora = subJson["hora"].string {
                        self.horas.append(hora)
                    }
                    if let id = subJson["id"].string {
                        self.ids.append(id)
                    }
                    if let evento = subJson["evento"].string {
                        var eventoTipo = "Noticia"
                        var eventoFondo = "fondo-noticia.jpg"
                        var eventoIcono = "noticiaiOS.png"
                        if evento == "true"{
                            eventoTipo = "Evento"
                            eventoFondo = "fondo-evento.jpg"
                            eventoIcono = "eventoiOS.png"
                        }
                        self.eventos.append(eventoTipo)
                        self.fondos.append(eventoFondo)
                        self.iconos.append(eventoIcono)
                        
                    }
                    
                }
                
                print(self.titulos)
                print(self.eventos)
                self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            
        }
    }


}
