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
    
    func getOrientation() -> UIInterfaceOrientation? {
        let scenes = UIApplication.shared.connectedScenes
        let scene = scenes.first as? UIWindowScene
        return scene?.interfaceOrientation
    }
    
    func correctXForDeviceOrientation() -> Double {
        guard let orientation = getOrientation() else { return 0 }
        switch orientation {
        case .portrait:
            return x
        case .portraitUpsideDown:
            return -x
        case .landscapeLeft:
            return -y
        case .landscapeRight:
            return y
        default:
            return 0
        }
    }
    
    func correctYForDeviceOrientation() -> Double {
        guard let orientation = getOrientation() else { return 0 }
        switch orientation {
        case .portrait:
            return y
        case .portraitUpsideDown:
            return -y
        case .landscapeLeft:
            return x
        case .landscapeRight:
            return -x
        default:
            return 0
        }
    }
    
}


@available(iOS 14, macOS 11.0, *)
public struct MyAppsListView<S>: View where S: ListStyle {
    
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
            withAnimation {
                orientationCorrectedX = motion.correctXForDeviceOrientation()
            }
        }
        .onChange(of: motion.y) { _ in
            withAnimation {
                orientationCorrectedY = motion.correctYForDeviceOrientation()
            }
        }
    }
    
}

@available(iOS 14, macOS 11.0, *)
public struct MyAppsSectionView: View {
    
    @StateObject private var motion = MotionManager()
    let apps = MyApp.allApps
    var excludedAppId: Int?
    @State private var orientationCorrectedX = 0.0
    @State private var orientationCorrectedY = 0.0
    
    public init(excludedAppId: Int?) {
        self.excludedAppId = excludedAppId
    }
    
    public var body: some View {
        
        Section(header:
                    Text("\(NSLocalizedString("Muut Luontosovellukset", bundle: Bundle.module, comment: ""))")
                
        ) {
            ForEach(apps) { app in
                if app.id != excludedAppId {
                    MyAppView(orientationCorrectedX: $orientationCorrectedX, orientationCorrectedY: $orientationCorrectedY, app: app)
                }
            }
        }
        
        .onChange(of: motion.x) { _ in
            withAnimation {
                orientationCorrectedX = motion.correctXForDeviceOrientation()
            }
        }
        .onChange(of: motion.y) { _ in
            withAnimation {
                orientationCorrectedY = motion.correctYForDeviceOrientation()
            }
        }
    }
}

@available(iOS 14, macOS 11.0, *)
struct MyAppView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var orientationCorrectedX: Double
    @Binding var orientationCorrectedY: Double
    let linkText = NSLocalizedString("linkText", bundle: Bundle.module, comment: "")
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
                
                Image(uiImage: app.image)
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
                
                Link(linkText, destination: URL(string: app.link)!)
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .buttonStyle(BorderlessButtonStyle())
            }
            .padding(.horizontal, 10)
        }
        .padding(.vertical, 5)
    }
}
