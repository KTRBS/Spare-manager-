import Foundation

class SignerEngine {
    func sign(ipaPath: String, p12Path: String, provPath: String, password: String) {
        let outputIpa = NSTemporaryDirectory() + "signed.ipa"
        
        // アプリ内に同梱した zsign 実行ファイルのパスを取得
        guard let zsignBinary = Bundle.main.path(forResource: "zsign", ofType: nil) else { return }
        
        // 実行コマンドの構築
        let task = Process()
        task.executableURL = URL(fileURLWithPath: zsignBinary)
        task.arguments = [
            "-k", p12Path,
            "-p", password,
            "-m", provPath,
            "-o", outputIpa,
            ipaPath
        ]
        
        // 実行
        try? task.run()
        task.waitUntilExit()
        
        // 成功したら「サイン済み」フォルダへ移動
    }
}
