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
    var imageName: String
    var name: String
    var description: String
    var link: String
    var backgroundColor: Color
    
    static let allApps: [MyApp] = [
    
        MyApp(id: 3,
              imageName: "Sirittäjät",
              name: "Sirittäjät",
              description: "Opi tunnistamaan Suomen heinäsirkkojejen ja hepokattien äänet. Sovellus tehty yhteistyössä lajiasiantuntija Sami Karjalaisen kanssa.",
              link: "https://apps.apple.com/fi/app/siritt%C3%A4j%C3%A4t/id1612850740?l=fi",
              backgroundColor: .white
             ),
        MyApp(id: 2,
              imageName: "Luontotilastot",
              name: "Luontotilastot",
              description: "Historialliset havaintotiedot kaikista suomalaisista eliöistä. Tilastot perustuvat Lajitietokeskuksen havaintotietokantaan.",
              link: "https://apps.apple.com/fi/app/luontotilastot/id1552025977?l=fi",
              backgroundColor: Color(red: 210/255, green: 235/255, blue: 249/255)
             ),
        MyApp(id: 1,
              imageName: "Lintunimistö",
              name: "Lintunimistö",
              description: "Maailman lintulajien nimet yli 20 eri kielellä.",
              link: "https://apps.apple.com/fi/app/lintunimist%C3%B6/id1436321814?l=fi",
              backgroundColor: Color(red: 215/255, green: 223/255, blue: 28/255)
             ),
    ]
}

