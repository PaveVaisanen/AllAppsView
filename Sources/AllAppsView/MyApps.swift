//
//  MyApps.swift
//  CoremotionTest
//
//  Created by Pave Vaisanen on 23.8.2022.
//

import Foundation
import SwiftUI

@available(iOS 14, macOS 11.0, *)
struct MyApp: Identifiable {
    
    let id: Int
    var name: String
    var description: String
    var link: String
    var backgroundColor: Color
    var image: UIImage
    
    static let allApps: [MyApp] = [
    
        MyApp(id: 3,
              name: NSLocalizedString("SirittäjätName", bundle: Bundle.module, comment: ""),
              description: NSLocalizedString("SirittäjätText", bundle: Bundle.module, comment: ""),
              link: "https://apps.apple.com/fi/app/siritt%C3%A4j%C3%A4t/id1612850740?l=fi",
              backgroundColor: .white,
              image: UIImage(named: "Sirittäjät", in: .module, with: nil)!
             ),
        MyApp(id: 2,
              name: NSLocalizedString("LuontotilastotName", bundle: Bundle.module, comment: ""),
              description: NSLocalizedString("LuontotilastotText", bundle: Bundle.module, comment: ""),
              link: "https://apps.apple.com/fi/app/luontotilastot/id1552025977?l=fi",
              backgroundColor: Color(red: 210/255, green: 235/255, blue: 249/255),
              image: UIImage(named: "Luontotilastot", in: .module, with: nil)!
             ),
        MyApp(id: 1,
              name: NSLocalizedString("LintunimistöName", bundle: Bundle.module, comment: ""),
              description: NSLocalizedString("LintunimistöText", bundle: Bundle.module, comment: ""),
              link: "https://apps.apple.com/fi/app/lintunimist%C3%B6/id1436321814?l=fi",
              backgroundColor: Color(red: 215/255, green: 223/255, blue: 28/255),
              image: UIImage(named: "Lintunimistö", in: .module, with: nil)!
             ),
    ]
}

