import SwiftUI
import SafariServices




@available(iOS 14, macOS 11.0, *)
public struct MyAppsListView<S>: View where S: ListStyle {
    
    var listStyle: S
    @StateObject private var motion = MotionManager()
    let allApps = MyApp.allApps
    var appList: [AppEnum] = []
    @State private var orientationCorrectedX = 0.0
    @State private var orientationCorrectedY = 0.0
    
    public init(listStyle: S, appList: [AppEnum]) {
        self.listStyle = listStyle
        self.appList = appList
    }
    
    public var body: some View {
        
        List {
            ForEach(appList, id: \.self) { app in
                if let correctApp = allApps.filter({ $0.appEnum == app }).first {
                    MyAppView(orientationCorrectedX: $orientationCorrectedX, orientationCorrectedY: $orientationCorrectedY, app: correctApp)
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
    let allApps = MyApp.allApps
    var appList: [AppEnum] = []
    @State private var orientationCorrectedX = 0.0
    @State private var orientationCorrectedY = 0.0
    
    public init(appList: [AppEnum]) {
        self.appList = appList
    }
    
    public var body: some View {
        
        Section(header:
                    Text("\(NSLocalizedString("Muut kehittäjän sovellukset", bundle: Bundle.module, comment: ""))")
                
        ) {
            ForEach(appList, id: \.self) { app in
                if let correctApp = allApps.filter({ $0.appEnum == app }).first {
                    MyAppView(orientationCorrectedX: $orientationCorrectedX, orientationCorrectedY: $orientationCorrectedY, app: correctApp)
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
        
        HStack(alignment: .top) {
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
