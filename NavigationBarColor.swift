//
//  NavigationBarColor.swift
//  Concierge Services
//
//  Created by mac on 2023/05/03.
//

import Foundation
import UIKit

public class NavigationBarColorChange{
    private init(){
        
    }
    public static func changeNavigationBarColor(barTintColor:UIColor, tintColor:UIColor,
                                                forgroundColor: UIColor, isTranslucent: Bool,
                                                backIndicatorImage: UIImage?, backButtonTitle: String?, barStyle: UIBarStyle){
        
        UINavigationBar.appearance().barTintColor = barTintColor
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: forgroundColor]
        UINavigationBar.appearance().isTranslucent = isTranslucent
        UINavigationBar.appearance().barStyle = barStyle
        
        
        let backImage = backIndicatorImage?.withRenderingMode(.alwaysOriginal)
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImage, for: .normal, barMetrics: .default)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -10, vertical: 0), for: .default)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: forgroundColor], for: .normal)
        
        
        if let backButtonTitle = backButtonTitle {
            let backButton = UIBarButtonItem()
            backButton.title = backButtonTitle
            UINavigationBar.appearance().topItem?.backBarButtonItem = backButton
            
            NavigationBarColorChange.changeNavigationBarColor(barTintColor: .white, tintColor: .black,
                                                              forgroundColor: .black, isTranslucent: false,
                                                              backIndicatorImage: nil, backButtonTitle: nil,
                                                              barStyle: .black) //shadowImage: UIImage() //backgroundColor: .black)
            
    
          //  UINavigationBar.appearance().setBackgroundImage(backgroundImage, for: .default)
            //    UINavigationBar.appearance().backgroundColor = backgroundColor

        }
    }
}
