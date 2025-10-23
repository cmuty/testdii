import Foundation

struct User {
    let firstName: String
    let lastName: String
    let patronymic: String
    let birthDate: String
    let taxId: String
    let photoName: String
    
    // Создаём User из данных AuthManager
    init(from authManager: AuthManager, taxId: String = "4018401651") {
        // Парсим ФИО из full_name (формат: "Прізвище Ім'я По батькові")
        let nameParts = authManager.userFullName.components(separatedBy: " ")
        
        if nameParts.count >= 3 {
            self.lastName = nameParts[0]
            self.firstName = nameParts[1]
            self.patronymic = nameParts[2...].joined(separator: " ")
        } else if nameParts.count == 2 {
            self.lastName = nameParts[0]
            self.firstName = nameParts[1]
            self.patronymic = ""
        } else if nameParts.count == 1 {
            self.lastName = nameParts[0]
            self.firstName = ""
            self.patronymic = ""
        } else {
            // Fallback на username
            self.lastName = authManager.userName
            self.firstName = ""
            self.patronymic = ""
        }
        
        self.birthDate = authManager.userBirthDate
        self.taxId = taxId
        self.photoName = "user_photo"
    }
    
    // Direct initializer для тестов и fallback
    init(firstName: String, lastName: String, patronymic: String, birthDate: String, taxId: String, photoName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.patronymic = patronymic
        self.birthDate = birthDate
        self.taxId = taxId
        self.photoName = photoName
    }
    
    // Mock для превью и тестов
    static let mock = User(
        firstName: "Богдан",
        lastName: "Зарва",
        patronymic: "Олегович",
        birthDate: "07.01.2010",
        taxId: "4018401651",
        photoName: "user_photo"
    )
}

