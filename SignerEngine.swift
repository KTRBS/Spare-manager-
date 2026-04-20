import Foundation

class SignerEngine {
    static let shared = SignerEngine()
    
    func runZSign(ipa: URL, p12: URL, prov: URL, pass: String) -> URL? {
        let fileManager = FileManager.default
        let tempOutput = fileManager.temporaryDirectory.appendingPathComponent("signed_output.ipa")
        
        // Bundle内のzsignバイナリのパスを取得
        guard let zsignBinary = Bundle.main.path(forResource: "zsign", ofType: nil) else {
            print("zsign binary not found")
            return nil
        }
        
        // 実行権限の付与（野良アプリなら必要）
        chmod(zsignBinary, 0o755)
        
        let task = Process() // 注意：iOS実機ではNSTask/Processの使用に制限がある場合があります
        task.executableURL = URL(fileURLWithPath: zsignBinary)
        task.arguments = [
            "-k", p12.path,
            "-p", pass,
            "-m", prov.path,
            "-o", tempOutput.path,
            ipa.path
        ]
        
        do {
            try task.run()
            task.waitUntilExit()
            return tempOutput
        } catch {
            print("Sign error: \(error)")
            return nil
        }
    }
}
