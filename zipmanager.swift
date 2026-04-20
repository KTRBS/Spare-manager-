import Foundation

class ZipManager {
    static let shared = ZipManager()
    let signsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("signs")

    func processZip(at url: URL) -> String? {
        // signsフォルダ作成
        try? FileManager.default.createDirectory(at: signsFolder, withIntermediateDirectories: true)
        
        // ZIPの展開（実際にはZIPFoundationライブラリ等を使用）
        // 解凍後、readmeからパスワードを取得
        let readmePath = signsFolder.appendingPathComponent("readme")
        if let password = try? String(contentsOf: readmePath, encoding: .utf8) {
            return password.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return nil
    }
}
