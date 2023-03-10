import SwiftUI

struct BannerModifier: ViewModifier {
    
    struct BannerData {
        var title:String
        var detail: String?
        var type: BannerType
    }
    
    enum BannerType {
        case Info
        case Warning
        case Success
        case Error
        
        var tintColor: Color {
            switch self {
            case .Info:
                return Color(.systemTeal)
            case .Success:
                return Color("sucess-toast-color")
            case .Warning:
                return Color.yellow
            case .Error:
                return Color.red
            }
        }
    }
    
    // Members for the Banner
    @Binding var data:BannerData
    @Binding var show:Bool?
    
    func body(content: Content) -> some View {
        
        ZStack {
            content
            if let showValue = show{
                if showValue {
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(data.title)
                                    .font(Font.system(size: 20, weight: Font.Weight.medium, design: Font.Design.default))
                                Text(data.detail ?? "" )
                                    .font(Font.system(size: 12, weight: Font.Weight.light, design: Font.Design.default))
                            }
                            Spacer()
                        }
                        .foregroundColor(Color.white)
                        .padding(12)
                        .background(data.type.tintColor)
                        .cornerRadius(15)
                        Spacer()
                    }
                    .padding()
                    .animation(.easeInOut)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .onTapGesture {
                        withAnimation {
                            self.show = false
                        }
                    }.onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                self.show = false
                            }
                        }
                    })
                }
            }
            
           
        }
    }

}

extension View {
    func banner(data: Binding<BannerModifier.BannerData>, show: Binding<Bool?>) -> some View {
        
        
        
        self.modifier(BannerModifier(data: data, show: show))
    }
}

struct ToastTestingView : View{
    @State var showBanner:Bool?
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "",  type: .Info)
    
    var body: some View{
       
        VStack{
            Button {
                self.bannerData.title = "Sucess"
                self.bannerData.detail = "Sucessfully send the dare to your child"
                self.bannerData.type = .Success
                self.showBanner = true
            } label: {
                Text("Toast View").foregroundColor(.green)
            }.banner(data: $bannerData, show: $showBanner)
        }
        
        

    }
}

struct ToastTestingView_Previews: PreviewProvider {
    static var previews: some View {
        ToastTestingView()
    }
}
