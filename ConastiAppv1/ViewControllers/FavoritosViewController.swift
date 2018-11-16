//
//  FavoritosViewController.swift
//  ConastiAppv1
//
//  Created by Yanela Pachacama Quispe on 16/11/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit

class FavoritosViewController: BaseViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
       
    }

   
}
