import Foundation

struct User {
    let firstName: String
    let lastName: String
    let patronymic: String
    let birthDate: String
    let taxId: String
    let photoName: String
    
    static let mock = User(
        firstName: "Богдан",
        lastName: "Зарва",
        patronymic: "Олегович",
        birthDate: "07.01.2010",
        taxId: "4018401651",
        photoName: "user_photo"
    )
}

