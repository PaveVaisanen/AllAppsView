//
//  MyApps.swift
//  CoremotionTest
//
//  Created by Pave Vaisanen on 23.8.2022.
//


@available(iOS 14, macOS 11.0, *)
public enum AppEnum {
    case sirittäjät,luontotilastot,lintunimistö,sähkönHinta,ruuvipenkki,pyöräasemat,linnunäänet
}


import Foundation
import SwiftUI

@available(iOS 14, macOS 11.0, *)
struct MyApp: Identifiable {
    
    let id: Int
    var appEnum: AppEnum
    var name: String
    var description: String
    var link: String
    var backgroundColor: Color
    var image: UIImage
    
    
    static let allApps: [MyApp] = [
        
        MyApp(id: 7,
              appEnum: .linnunäänet,
              name: NSLocalizedString("LinnunäänetName", bundle: Bundle.module, comment: ""),
              description: NSLocalizedString("LinnunÄänetText", bundle: Bundle.module, comment: ""),
              link: "https://apps.apple.com/fi/app/pohjolan-linnun%C3%A4%C3%A4net/id6449423520?l=fi",
              backgroundColor: Color(red: 212/255, green: 212/255, blue: 212/255),
              image: UIImage(named: "LinnunÄänet", in: .module, with: nil)!
             ),
        
        
        MyApp(id: 6,
              appEnum: .pyöräasemat,
              name: NSLocalizedString("PyöräasematName", bundle: Bundle.module, comment: ""),
              description: NSLocalizedString("PyöräasematText", bundle: Bundle.module, comment: ""),
              link: "https://apps.apple.com/fi/app/py%C3%B6r%C3%A4asemat/id1573151079?l=fi",
              backgroundColor: Color(red: 44/255, green: 158/255, blue: 255/255),
              image: UIImage(named: "Pyöräasemat", in: .module, with: nil)!
             ),
        
        MyApp(id: 5,
              appEnum: .ruuvipenkki,
              name: NSLocalizedString("RuuvipenkkiName", bundle: Bundle.module, comment: ""),
              description: NSLocalizedString("RuuvipenkkiText", bundle: Bundle.module, comment: ""),
              link: "https://apps.apple.com/fi/app/ruuvipenkki/id1660279964?l=fi",
              backgroundColor: Color(red: 168/255, green: 199/255, blue: 226/255),
              image: UIImage(named: "Ruuvipenkki", in: .module, with: nil)!
             ),
        
        MyApp(id: 4,
              appEnum: .sähkönHinta,
              name: NSLocalizedString("SähkönhintaName", bundle: Bundle.module, comment: ""),
              description: NSLocalizedString("SähkönhintaText", bundle: Bundle.module, comment: ""),
              link: "https://apps.apple.com/fi/app/s%C3%A4hk%C3%B6n-hintatiedot/id1643499107?l=fi",
              backgroundColor: .white,
              image: UIImage(named: "SähkönHintatiedot", in: .module, with: nil)!
             ),
        MyApp(id: 3,
              appEnum: .sirittäjät,
              name: NSLocalizedString("SirittäjätName", bundle: Bundle.module, comment: ""),
              description: NSLocalizedString("SirittäjätText", bundle: Bundle.module, comment: ""),
              link: "https://apps.apple.com/fi/app/siritt%C3%A4j%C3%A4t/id1612850740?l=fi",
              backgroundColor: .white,
              image: UIImage(named: "Sirittäjät", in: .module, with: nil)!
             ),
        MyApp(id: 2,
              appEnum: .luontotilastot,
              name: NSLocalizedString("LuontotilastotName", bundle: Bundle.module, comment: ""),
              description: NSLocalizedString("LuontotilastotText", bundle: Bundle.module, comment: ""),
              link: "https://apps.apple.com/fi/app/luontotilastot/id1552025977?l=fi",
              backgroundColor: Color(red: 210/255, green: 235/255, blue: 249/255),
              image: UIImage(named: "Luontotilastot", in: .module, with: nil)!
             ),
        MyApp(id: 1,
              appEnum: .lintunimistö,
              name: NSLocalizedString("LintunimistöName", bundle: Bundle.module, comment: ""),
              description: NSLocalizedString("LintunimistöText", bundle: Bundle.module, comment: ""),
              link: "https://apps.apple.com/fi/app/lintunimist%C3%B6/id1436321814?l=fi",
              backgroundColor: Color(red: 215/255, green: 223/255, blue: 28/255),
              image: UIImage(named: "Lintunimistö", in: .module, with: nil)!
             ),
    ]
}

