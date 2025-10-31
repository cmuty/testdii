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
        // Используем только цифры 0, 1, 2, 3
        for _ in 0..<9 {
            result += String(Int.random(in: 0...3))
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
    
    // Дата выдачи паспорта (дата рождения + 14 лет)
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
        
        // Добавляем ровно 14 лет
        var components = DateComponents()
        components.year = 14
        
        guard let issueDate = Calendar.current.date(byAdding: components, to: birth) else {
            return "01.01.2020"
        }
        
        return formatter.string(from: issueDate)
    }
    
    // Дата истечения паспорта (дата выдачи + 8 лет)
    func getPassportExpiryDate(issueDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        guard let issue = formatter.date(from: issueDate) else {
            return "01.01.2032"
        }
        
        var components = DateComponents()
        components.year = 8
        
        guard let expiryDate = Calendar.current.date(byAdding: components, to: issue) else {
            return "01.01.2032"
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
    
    // Дата регистрации (рождение + 2 года)
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
        
        // Добавляем ровно 2 года
        var components = DateComponents()
        components.year = 2
        
        guard let regDate = Calendar.current.date(byAdding: components, to: birth) else {
            return "01.01.2010"
        }
        
        return formatter.string(from: regDate)
    }
    
    // Генерация места рождения (один раз при входе)
    func getBirthPlace() -> String {
        if let saved = UserDefaults.standard.string(forKey: "userBirthPlace") {
            return saved
        }
        
        let birthPlace = generateBirthPlace()
        UserDefaults.standard.set(birthPlace, forKey: "userBirthPlace")
        return birthPlace
    }
    
    private func generateBirthPlace() -> String {
        let regions = [
            "Харківська область",
            "Київська область",
            "Львівська область",
            "Дніпропетровська область",
            "Одеська область",
            "Запорізька область",
            "Полтавська область",
            "Вінницька область",
            "Чернігівська область",
            "Хмельницька область"
        ]
        
        let cities = [
            "Харків",
            "Київ",
            "Львів",
            "Дніпро",
            "Одеса",
            "Запоріжжя",
            "Полтава",
            "Вінниця",
            "Чернігів",
            "Хмельницький"
        ]
        
        let randomIndex = Int.random(in: 0..<regions.count)
        return "Україна, \(regions[randomIndex]),\nмісто \(cities[randomIndex])"
    }
    
    // Структура адреса проживания
    struct ResidenceAddress {
        let region: String
        let city: String
        let district: String
        let streetType: String // провулок, вулиця, бульвар, проспект
        let streetName: String
        let buildingNumber: String
    }
    
    // Генерация адреса проживания (один раз при входе)
    func getResidenceAddress() -> ResidenceAddress {
        if let savedRegion = UserDefaults.standard.string(forKey: "userResidenceRegion"),
           let savedCity = UserDefaults.standard.string(forKey: "userResidenceCity"),
           let savedDistrict = UserDefaults.standard.string(forKey: "userResidenceDistrict"),
           let savedStreetType = UserDefaults.standard.string(forKey: "userResidenceStreetType"),
           let savedStreetName = UserDefaults.standard.string(forKey: "userResidenceStreetName"),
           let savedBuildingNumber = UserDefaults.standard.string(forKey: "userResidenceBuildingNumber") {
            return ResidenceAddress(
                region: savedRegion,
                city: savedCity,
                district: savedDistrict,
                streetType: savedStreetType,
                streetName: savedStreetName,
                buildingNumber: savedBuildingNumber
            )
        }
        
        let address = generateResidenceAddress()
        UserDefaults.standard.set(address.region, forKey: "userResidenceRegion")
        UserDefaults.standard.set(address.city, forKey: "userResidenceCity")
        UserDefaults.standard.set(address.district, forKey: "userResidenceDistrict")
        UserDefaults.standard.set(address.streetType, forKey: "userResidenceStreetType")
        UserDefaults.standard.set(address.streetName, forKey: "userResidenceStreetName")
        UserDefaults.standard.set(address.buildingNumber, forKey: "userResidenceBuildingNumber")
        return address
    }
    
    private func generateResidenceAddress() -> ResidenceAddress {
        // Взаимосвязанные данные по областям
        let regionsData: [(region: String, city: String, districts: [String], streets: [(type: String, name: String)])] = [
            (
                region: "Харківська",
                city: "Харків",
                districts: ["Харківський", "Салтівський", "Немишлянський", "Холодногірський"],
                streets: [
                    (type: "пров.", name: "Білостоцький"),
                    (type: "пров.", name: "Грушевський"),
                    (type: "вул.", name: "Сумська"),
                    (type: "вул.", name: "Московський проспект"),
                    (type: "пров.", name: "Шевченка"),
                    (type: "вул.", name: "Полтавський шлях")
                ]
            ),
            (
                region: "Київська",
                city: "Київ",
                districts: ["Київський", "Печерський", "Шевченківський", "Подільський"],
                streets: [
                    (type: "вул.", name: "Хрещатик"),
                    (type: "вул.", name: "Майдан Незалежності"),
                    (type: "пров.", name: "Тарасів"),
                    (type: "вул.", name: "Золотоворітська"),
                    (type: "пров.", name: "Михайлівський"),
                    (type: "бул.", name: "Шевченка")
                ]
            ),
            (
                region: "Львівська",
                city: "Львів",
                districts: ["Львівський", "Залізничний", "Франківський", "Сихівський"],
                streets: [
                    (type: "вул.", name: "Проспект Свободи"),
                    (type: "вул.", name: "Стрийська"),
                    (type: "пров.", name: "Ринок"),
                    (type: "вул.", name: "Грушевського"),
                    (type: "пров.", name: "Дорошенка"),
                    (type: "вул.", name: "Городоцька")
                ]
            ),
            (
                region: "Дніпропетровська",
                city: "Дніпро",
                districts: ["Дніпровський", "Соборний", "Шевченківський", "Центральний"],
                streets: [
                    (type: "просп.", name: "Дмитра Яворницького"),
                    (type: "вул.", name: "Січеславська"),
                    (type: "пров.", name: "Грушевського"),
                    (type: "вул.", name: "Карла Маркса"),
                    (type: "пров.", name: "Михайла Грушевського"),
                    (type: "вул.", name: "Набережна Перемоги")
                ]
            ),
            (
                region: "Одеська",
                city: "Одеса",
                districts: ["Одеський", "Приморський", "Малиновський", "Суворовський"],
                streets: [
                    (type: "вул.", name: "Дерибасівська"),
                    (type: "пров.", name: "Приморський"),
                    (type: "вул.", name: "Пушкінська"),
                    (type: "пров.", name: "Морський"),
                    (type: "вул.", name: "Італійська"),
                    (type: "пров.", name: "Грецький")
                ]
            )
        ]
        
        let randomIndex = Int.random(in: 0..<regionsData.count)
        let regionData = regionsData[randomIndex]
        
        let randomDistrictIndex = Int.random(in: 0..<regionData.districts.count)
        let district = regionData.districts[randomDistrictIndex]
        
        let randomStreetIndex = Int.random(in: 0..<regionData.streets.count)
        let street = regionData.streets[randomStreetIndex]
        
        let buildingNumber = String(Int.random(in: 1...150))
        
        return ResidenceAddress(
            region: regionData.region,
            city: regionData.city,
            district: district,
            streetType: street.type,
            streetName: street.name,
            buildingNumber: buildingNumber
        )
    }
    
    // Форматированный адрес для єДокумента
    func getFormattedResidenceAddress() -> String {
        let address = getResidenceAddress()
        return "Україна, область \(address.region), місто \(address.city), \(address.streetType) \(address.streetName), буд \(address.buildingNumber)"
    }
    
    // Форматированный адрес места рождения для паспорта (капс, две строки)
    func getFormattedBirthPlaceForPassport() -> (line1: String, line2: String) {
        let birthPlace = getBirthPlace()
        // Парсим место рождения (формат: "Україна, Харківська область,\nмісто Харків")
        let cleaned = birthPlace.replacingOccurrences(of: "\n", with: " ")
        let components = cleaned.components(separatedBy: ", ")
        if components.count >= 2 {
            // components[0] = "Україна"
            // components[1] = "Харківська область"
            // components[2] = "місто Харків" (если есть)
            let regionFull = components[1]
            let regionName = regionFull.replacingOccurrences(of: " область", with: "").uppercased()
            
            var cityName = "ХАРКІВ" // fallback
            if components.count >= 3 {
                cityName = components[2].replacingOccurrences(of: "місто ", with: "").uppercased()
            } else {
                // Если города нет в третьей части, попробуем извлечь из региона (для некоторых форматов)
                // Можно использовать первую часть города из базы
                cityName = "ХАРКІВ" // fallback
            }
            
            return ("М. \(cityName) \(regionName)", "ОБЛАСТЬ УКРАЇНА")
        }
        // Fallback
        return ("М. ХАРКІВ ХАРКІВСЬКА", "ОБЛАСТЬ УКРАЇНА")
    }
    
    // Форматированный адрес проживания для паспорта (капс, многострочный)
    func getFormattedResidenceForPassport() -> [String] {
        let address = getResidenceAddress()
        return [
            "УКРАЇНА \(address.region.uppercased()) ОБЛАСТЬ",
            "\(address.district.uppercased()) РАЙОН М. \(address.city.uppercased())",
            "\(address.streetType.uppercased()) \(address.streetName.uppercased()) БУД \(address.buildingNumber)"
        ]
    }
    
    // Структура для родительских данных
    struct ParentData {
        let fullName: String // ПІБ
        let rnokpp: String? // РНОКПП (только для отца)
        let birthDate: String // Дата народження
    }
    
    // Генерация данных отца
    func getFatherData() -> ParentData {
        if let savedFullName = UserDefaults.standard.string(forKey: "fatherFullName"),
           let savedRnokpp = UserDefaults.standard.string(forKey: "fatherRNOKPP"),
           let savedBirthDate = UserDefaults.standard.string(forKey: "fatherBirthDate") {
            return ParentData(fullName: savedFullName, rnokpp: savedRnokpp, birthDate: savedBirthDate)
        }
        
        let fatherData = generateFatherData()
        UserDefaults.standard.set(fatherData.fullName, forKey: "fatherFullName")
        // РНОКПП уже сохраняется в getFatherRNOKPP()
        UserDefaults.standard.set(fatherData.birthDate, forKey: "fatherBirthDate")
        return fatherData
    }
    
    private func generateFatherData() -> ParentData {
        // Мужские имена
        let firstNames = ["Олег", "Андрій", "Володимир", "Михайло", "Сергій", "Іван", "Олександр", "Дмитро", "Василь", "Петро"]
        let lastNames = ["Іваненко", "Петренко", "Коваленко", "Шевченко", "Мельник", "Кравченко", "Бондаренко", "Мороз", "Козлов", "Ткаченко"]
        let patronymics = ["Олегович", "Володимирович", "Михайлович", "Сергійович", "Іванович", "Олександрович", "Дмитрович", "Васильович", "Петрович", "Андрійович"]
        
        let firstName = firstNames.randomElement() ?? "Олег"
        let lastName = lastNames.randomElement() ?? "Іваненко"
        let patronymic = patronymics.randomElement() ?? "Олегович"
        let fullName = "\(lastName) \(firstName) \(patronymic)"
        
        // Отдельный РНОКПП для отца
        let rnokpp = getFatherRNOKPP()
        let birthDate = generateBirthDate(yearRange: 1977...1994)
        
        return ParentData(fullName: fullName, rnokpp: rnokpp, birthDate: birthDate)
    }
    
    // Отдельный генератор РНОКПП для отца
    private func getFatherRNOKPP() -> String {
        if let saved = UserDefaults.standard.string(forKey: "fatherRNOKPP") {
            return saved
        }
        
        let rnokpp = generateRNOKPP()
        UserDefaults.standard.set(rnokpp, forKey: "fatherRNOKPP")
        return rnokpp
    }
    
    // Генерация данных матери
    func getMotherData() -> ParentData {
        if let savedFullName = UserDefaults.standard.string(forKey: "motherFullName"),
           let savedBirthDate = UserDefaults.standard.string(forKey: "motherBirthDate") {
            return ParentData(fullName: savedFullName, rnokpp: nil, birthDate: savedBirthDate)
        }
        
        let motherData = generateMotherData()
        UserDefaults.standard.set(motherData.fullName, forKey: "motherFullName")
        UserDefaults.standard.set(motherData.birthDate, forKey: "motherBirthDate")
        return motherData
    }
    
    private func generateMotherData() -> ParentData {
        // Женские имена
        let firstNames = ["Оксана", "Наталія", "Тетяна", "Олена", "Марина", "Ірина", "Вікторія", "Юлія", "Анна", "Марія"]
        let lastNames = ["Іваненко", "Петренко", "Коваленко", "Шевченко", "Мельник", "Кравченко", "Бондаренко", "Мороз", "Козлов", "Ткаченко"]
        let patronymics = ["Олегівна", "Володимирівна", "Михайлівна", "Сергіївна", "Іванівна", "Олександрівна", "Дмитрівна", "Василівна", "Петрівна", "Андріївна"]
        
        let firstName = firstNames.randomElement() ?? "Оксана"
        let lastName = lastNames.randomElement() ?? "Іваненко"
        let patronymic = patronymics.randomElement() ?? "Олегівна"
        let fullName = "\(lastName) \(firstName) \(patronymic)"
        
        let birthDate = generateBirthDate(yearRange: 1977...1994)
        
        return ParentData(fullName: fullName, rnokpp: nil, birthDate: birthDate)
    }
    
    private func generateBirthDate(yearRange: ClosedRange<Int>) -> String {
        let year = Int.random(in: yearRange)
        let month = Int.random(in: 1...12)
        let day = Int.random(in: 1...28) // 28 для безопасности
        return String(format: "%02d.%02d.%d", day, month, year)
    }
    
    // Генерация номера запису (10-77)
    func getBirthRecordNumber() -> String {
        if let saved = UserDefaults.standard.string(forKey: "birthRecordNumber") {
            return saved
        }
        
        let number = String(Int.random(in: 10...77))
        UserDefaults.standard.set(number, forKey: "birthRecordNumber")
        return number
    }
    
    // Генерация органа державної реєстрації (зависит от области рождения)
    func getRegistrationBody() -> String {
        let birthPlace = getBirthPlace()
        // Парсим область из места рождения
        let cleaned = birthPlace.replacingOccurrences(of: "\n", with: " ")
        let components = cleaned.components(separatedBy: ", ")
        
        if components.count >= 2 {
            let regionFull = components[1] // "Харківська область"
            let regionName = regionFull.replacingOccurrences(of: " область", with: "")
            
            // Маппинг названий областей
            let regionMapping: [String: String] = [
                "Харківська": "Харківського міського управління юстиції\nХарківської області",
                "Київська": "Київського міського управління юстиції\nКиївської області",
                "Львівська": "Львівського міського управління юстиції\nЛьвівської області",
                "Дніпропетровська": "Дніпропетровського міського управління юстиції\nДніпропетровської області",
                "Одеська": "Одеського міського управління юстиції\nОдеської області",
                "Запорізька": "Запорізького міського управління юстиції\nЗапорізької області",
                "Полтавська": "Полтавського міського управління юстиції\nПолтавської області",
                "Вінницька": "Вінницького міського управління юстиції\nВінницької області",
                "Чернігівська": "Чернігівського міського управління юстиції\nЧернігівської області",
                "Хмельницька": "Хмельницького міського управління юстиції\nХмельницької області"
            ]
            
            return regionMapping[regionName] ?? "Харківського міського управління юстиції\nХарківської області"
        }
        
        return "Харківського міського управління юстиції\nХарківської області"
    }
    
    // Генерация даты складання (дата народження + 14 дней)
    func getCompilationDate(birthDate: String) -> String {
        if let saved = UserDefaults.standard.string(forKey: "birthCompilationDate") {
            return saved
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale(identifier: "uk_UA")
        
        if let birth = formatter.date(from: birthDate) {
            let compilationDate = Calendar.current.date(byAdding: .day, value: 14, to: birth) ?? birth
            let dateString = formatter.string(from: compilationDate)
            UserDefaults.standard.set(dateString, forKey: "birthCompilationDate")
            return dateString
        }
        
        return formatter.string(from: Date())
    }
    
    // Генерация номера свідоцтва (I-КИ XXXXXX)
    func getCertificateNumber() -> String {
        if let saved = UserDefaults.standard.string(forKey: "birthCertificateNumber") {
            return saved
        }
        
        let randomNumber = String(format: "%06d", Int.random(in: 100000...999999))
        let certificateNumber = "I-КИ \(randomNumber)"
        UserDefaults.standard.set(certificateNumber, forKey: "birthCertificateNumber")
        return certificateNumber
    }
    
    // Дата видачі (такая же как дата складання)
    func getIssueDate(birthDate: String) -> String {
        return getCompilationDate(birthDate: birthDate)
    }
    
    // Генерация статі (пола)
    func getGender() -> String {
        // Можно сделать рандом или всегда "Чоловіча", или использовать из других данных
        // Для простоты сделаем "Чоловіча", но можно изменить логику
        return "Чоловіча"
    }
}

