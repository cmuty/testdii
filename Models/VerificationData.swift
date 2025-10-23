import Foundation

struct VerificationData {
    let datePart: String
    let verifyPart: String
    let barcodeNumber: String
    
    init() {
        // Generate date part (format: YYYYMMDD-XXXXX-YYYY-MM-DD)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: Date())
        
        let randomNum = Int.random(in: 10000...99999)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fullDate = dateFormatter.string(from: Date())
        
        self.datePart = "\(dateString)-\(randomNum)-\(fullDate)"
        
        // Generate verify UUID
        self.verifyPart = UUID().uuidString.lowercased()
        
        // Generate barcode number (13 digits)
        let part1 = Int.random(in: 1000...9999)
        let part2 = Int.random(in: 1000...9999)
        let part3 = Int.random(in: 10000...99999)
        self.barcodeNumber = "\(part1)\(part2)\(part3)"
    }
    
    var url: String {
        "https://diia.app/documents/internal-passport/\(datePart)/verify/\(verifyPart)"
    }
    
    var barcodeFormatted: String {
        let part1 = String(barcodeNumber.prefix(4))
        let part2 = String(barcodeNumber.dropFirst(4).prefix(4))
        let part3 = String(barcodeNumber.dropFirst(8))
        return "\(part1)  \(part2)  \(part3)"
    }
}

