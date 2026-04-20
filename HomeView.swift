import SwiftUI
import UniformTypeIdentifiers

struct HomeView: View {
    @State private var isImportingZip = false
    @State private var statusMessage = "証明書がありません！"
    @State private var hasCertificate = false

    var body: some View {
        VStack(spacing: 30) {
            if !hasCertificate {
                Text(statusMessage)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                
                Button(action: { isImportingZip = true }) {
                    VStack {
                        Image(systemName: "archivebox.fill")
                            .font(.system(size: 50))
                        Text("署名用ZIPをインポート")
                            .font(.title2, weight: .bold)
                    }
                    .frame(maxWidth: .infinity, minHeight: 200)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                }
                .padding()
            } else {
                Text("準備完了")
                    .font(.title)
                Button("IPAをサインする") { /* IPA選択ロジックへ */ }
                    .buttonStyle(.borderedProminent)
            }
        }
        .fileImporter(isPresented: $isImportingZip, allowedContentTypes: [.zip]) { result in
            handleImport(result: result)
        }
    }

    func handleImport(result: Result<URL, Error>) {
        switch result {
        case .success(let url):
            // ZIP展開ロジック（後述）を呼び出し
            print("Imported: \(url.path)")
            self.hasCertificate = true // 実際は展開成功時にtrueにする
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}
