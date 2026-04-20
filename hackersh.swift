import SwiftUI

struct ContentView: View {
    @State private var hasCertificate = false // p12が存在するかチェック
    
    var body: some View {
        TabView {
            HomeView(hasCertificate: $hasCertificate)
                .tabItem { Label("ホーム", systemImage: "house") }
            
            SignedAppsView()
                .tabItem { Label("サイン済み", systemImage: "doc.badge.gearshape") }
        }
    }
}

struct HomeView: View {
    @Binding var hasCertificate: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            if !hasCertificate {
                Text("証明書がありません！")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.red)
                
                Button(action: importZip) {
                    Text("署名用ZIPをインポート")
                        .font(.title)
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .padding()
            } else {
                // 通常のインポートボタン
                Button("IPAを選択") { /* IPAインポート処理 */ }
                Button("証明書を再インポート") { /* ZIPインポート */ }
            }
        }
    }
    
    func importZip() {
        // UIDocumentPickerViewController を呼び出してZIPを選択
    }
}
