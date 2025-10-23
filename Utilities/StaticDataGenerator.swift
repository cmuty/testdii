import Foundation

class StaticDataGenerator {
    static let shared = StaticDataGenerator()
    
    private init() {}
    
    // Генерация РНОКПП один раз
    func getRNOKPP() -> String {
        if let saved = UserDefaults.standard.string(forKey: "userRNOKPP") {
            return saved
        }
        
        let rnokpp = generateRNOKPP()
        UserDefaults.standard.set(rnokpp, forKey: "userRNOKPP")
        return rnokpp
    }
    
    private func generateRNOKPP() -> String {
        var result = ""
        for _ in 0..<10 {
            result += String(Int.random(in: 0...9))
        }
        return result
    }
    
    // Генерация номера паспорта один раз
    func getPassportNumber() -> String {
        if let saved = UserDefaults.standard.string(forKey: "userPassportNumber") {
            return saved
        }
        
        let passportNumber = generatePassportNumber()
        UserDefaults.standard.set(passportNumber, forKey: "userPassportNumber")
        return passportNumber
    }
    
    private func generatePassportNumber() -> String {
        var result = ""
        for _ in 0..<9 {
            result += String(Int.random(in: 0...9))
        }
        return result
    }
    
    // Генерация УНЗР (дата рождения + 5 случайных цифр)
    func getUNZR(birthDate: String) -> String {
        if let saved = UserDefaults.standard.string(forKey: "userUNZR") {
            return saved
        }
        
        let unzr = generateUNZR(birthDate: birthDate)
        UserDefaults.standard.set(unzr, forKey: "userUNZR")
        return unzr
    }
    
    private func generateUNZR(birthDate: String) -> String {
        // birthDate в формате dd.MM.yyyy -> конвертируем в yyyyMMdd
        let components = birthDate.split(separator: ".")
        if components.count == 3 {
            let day = components[0]
            let month = components[1]
            let year = components[2]
            
            let dateString = "\(year)\(month)\(day)"
            
            // Генерируем 5 случайных цифр
            var randomPart = ""
            for _ in 0..<5 {
                randomPart += String(Int.random(in: 0...9))
            }
            
            return "\(dateString)-\(randomPart)"
        }
        
        return "00000000-00000"
    }
    
    // Дата выдачи паспорта (дата рождения + примерно 7 дней)
    func getPassportIssueDate(birthDate: String) -> String {
        if let saved = UserDefaults.standard.string(forKey: "userPassportIssueDate") {
            return saved
        }
        
        let issueDate = generatePassportIssueDate(birthDate: birthDate)
        UserDefaults.standard.set(issueDate, forKey: "userPassportIssueDate")
        return issueDate
    }
    
    private func generatePassportIssueDate(birthDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        guard let birth = formatter.date(from: birthDate) else {
            return "01.01.2020"
        }
        
        // Добавляем от 5 до 10 дней после 14-летия
        var components = DateComponents()
        components.year = 14
        components.day = Int.random(in: 5...10)
        
        guard let issueDate = Calendar.current.date(byAdding: components, to: birth) else {
            return "01.01.2020"
        }
        
        return formatter.string(from: issueDate)
    }
    
    // Дата истечения паспорта (дата выдачи + 4 года)
    func getPassportExpiryDate(issueDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        guard let issue = formatter.date(from: issueDate) else {
            return "01.01.2028"
        }
        
        var components = DateComponents()
        components.year = 4
        
        guard let expiryDate = Calendar.current.date(byAdding: components, to: issue) else {
            return "01.01.2028"
        }
        
        return formatter.string(from: expiryDate)
    }
    
    // Орган который выдал паспорт
    func getIssuingAuthority() -> String {
        if let saved = UserDefaults.standard.string(forKey: "userIssuingAuthority") {
            return saved
        }
        
        let authority = String(Int.random(in: 1000...9999))
        UserDefaults.standard.set(authority, forKey: "userIssuingAuthority")
        return authority
    }
    
    // Дата регистрации (рождение + 4 года + случайные месяцы)
    func getRegistrationDate(birthDate: String) -> String {
        if let saved = UserDefaults.standard.string(forKey: "userRegistrationDate") {
            return saved
        }
        
        let regDate = generateRegistrationDate(birthDate: birthDate)
        UserDefaults.standard.set(regDate, forKey: "userRegistrationDate")
        return regDate
    }
    
    private func generateRegistrationDate(birthDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        guard let birth = formatter.date(from: birthDate) else {
            return "01.01.2010"
        }
        
        // Добавляем 4 года + случайное количество месяцев (0-12)
        var components = DateComponents()
        components.year = 4
        components.month = Int.random(in: 0...12)
        components.day = Int.random(in: 1...28)
        
        guard let regDate = Calendar.current.date(byAdding: components, to: birth) else {
            return "01.01.2010"
        }
        
        return formatter.string(from: regDate)
    }
}

