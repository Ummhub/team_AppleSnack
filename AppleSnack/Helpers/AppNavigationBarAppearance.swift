//
//  AppNavigationBarAppearance.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/19.
//

import UIKit

final class AppNavigationBarAppearance: UIViewController {
    
    static func navigationBarSetting() {
        
        let navigationBarAppearance = UINavigationBarAppearance()
        
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00),NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Bold", size: 18)!]
        UINavigationBar.appearance().tintColor = UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00) //아이템색 변경
        
        

        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00),NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Bold", size: 18)!]
        navigationBarAppearance.backgroundColor = UIColor.white //배경색 조정
        navigationBarAppearance.shadowColor = .none
        
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barTintColor = UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00)
    }
}
