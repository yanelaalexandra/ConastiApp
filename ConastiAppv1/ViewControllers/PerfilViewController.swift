//
//  PerfilViewController.swift
//  ConastiAppv1
//
//  Created by Yanela Pachacama Quispe on 9/11/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import SDWebImage

class PerfilViewController: BaseViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.backgroundColor = UIColor.white
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        emailUser.text? = User.email
        print(User.email)
        nameUser.text? = User.nombre
        print(User.nombre)
        pictureUser.sd_setImage(with: URL(string : User.imagenURL))
        pictureUser.layer.cornerRadius = pictureUser.frame.height/2
        pictureUser.layer.masksToBounds = true
    }

    @IBOutlet weak var nameUser: UILabel!
    
    @IBOutlet weak var emailUser: UILabel!
    
    @IBOutlet weak var pictureUser: UIImageView!
    
    
    

}
