

import SwiftUI
import CoreMotion
import SafariServices

@available(iOS 14, macOS 11.0, *)
class MotionManager: ObservableObject {
    
    private let motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    
    init() {
        
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.05
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else { return }
            
            var x = motion.roll / Double.pi
            let y = motion.pitch / Double.pi
            
            if x > 0.5 {
                x = 1 - x
            } else if x < -0.5 {
                x = -1 - x
            }
            
            self?.x = x
            self?.y = y
        }
    }
}


@available(iOS 14, macOS 11.0, *)
public struct AllAppsView<S>: View where S: ListStyle {
    
    var listStyle: S
    @StateObject private var motion = MotionManager()
    let apps = MyApp.allApps
    var excludedAppId: Int?
    @State private var orientationCorrectedX = 0.0
    @State private var orientationCorrectedY = 0.0
    
    public init(listStyle: S, excludedAppId: Int?) {
        self.listStyle = listStyle
        self.excludedAppId = excludedAppId
    }
    
   public var body: some View {
        
        List {
            ForEach(apps) { app in
                if app.id != excludedAppId {
                    MyAppView(orientationCorrectedX: $orientationCorrectedX, orientationCorrectedY: $orientationCorrectedY, app: app)
                }
            }
        }
        .listStyle(listStyle)
       
        .onChange(of: motion.x) { _ in
            correctXForDeviceOrientation()
        }
        
        .onChange(of: motion.y) { _ in
            correctYForDeviceOrientation()
        }
    }
    
    
    func correctXForDeviceOrientation() {
        guard let orientation = getOrientation() else { return }
        withAnimation {
            switch orientation {
            case .portrait:
                orientationCorrectedX = motion.x
            case .portraitUpsideDown:
                orientationCorrectedX = -motion.x
            case .landscapeLeft:
                orientationCorrectedX = -motion.y
            case .landscapeRight:
                orientationCorrectedX = motion.y
            default:
                orientationCorrectedX = 0
            }
        }
    }
    
    func correctYForDeviceOrientation() {
        guard let orientation = getOrientation() else { return }
        withAnimation {
            switch orientation {
            case .portrait:
                orientationCorrectedY = motion.y
            case .portraitUpsideDown:
                orientationCorrectedY = -motion.y
            case .landscapeLeft:
                orientationCorrectedY = motion.x
            case .landscapeRight:
                orientationCorrectedY = -motion.x
            default:
                orientationCorrectedY = 0
            }
        }
    }
    
    func getOrientation() -> UIInterfaceOrientation? {
        let scenes = UIApplication.shared.connectedScenes
        let scene = scenes.first as? UIWindowScene
        return scene?.interfaceOrientation
    }
}



@available(iOS 14, macOS 11.0, *)
struct MyAppView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var orientationCorrectedX: Double
    @Binding var orientationCorrectedY: Double
    var app: MyApp
    
    var body: some View {
        
        HStack(alignment: .center) {
            ZStack {
                Rectangle()
                    .frame(width: 80, height: 80)
                    .foregroundColor(app.backgroundColor)
                    .cornerRadius(18)
                
                    .shadow(
                        color: colorScheme == .dark ? .yellow.opacity(0.2) : .black.opacity(0.15),
                        radius: 4,
                        x: orientationCorrectedX * 20,
                        y: orientationCorrectedY * 20
                    )
                    .rotation3DEffect(
                        .degrees(orientationCorrectedX * 20),
                        axis: (x: 0, y: -1, z: 0)
                    )
                    .rotation3DEffect(
                        .degrees(orientationCorrectedY * 20),
                        axis: (x: 1, y: 0, z: 0)
                    )
                
                Image(app.imageName)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .shadow(
                        color:.black.opacity(0.2),
                        radius: 4,
                        x: orientationCorrectedX * 20,
                        y: orientationCorrectedY * 20
                    )
                
            }
            
            VStack(alignment: .leading) {
                Text(app.name)
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 1)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(app.description)
                    .font(.footnote)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .padding(.bottom, 5)
                
                Link("Näytä App Storessa", destination: URL(string: app.link)!)
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .buttonStyle(BorderlessButtonStyle())
            }
            .padding(.horizontal, 10)
        }
        .padding(.vertical, 5)
    }
}


//struct ContentView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ContentView()
//    }
//
//}





