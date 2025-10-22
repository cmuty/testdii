# 📱 Дія - Native iOS App

Нативное iOS приложение на SwiftUI, копия приложения "Дія" 🇺🇦

## 🚀 Быстрый старт

### Требования
- macOS 13.0+
- Xcode 15.0+
- iOS 16.0+

### Локальная разработка

1. **Открой проект в Xcode:**
```bash
cd DiiaApp
open DiiaApp.xcodeproj
```

2. **Выбери симулятор или устройство**
3. **Нажми ⌘R (Command + R) для запуска**

---

## 📦 Структура проекта

```
DiiaApp/
├── DiiaApp.swift              # Точка входа
├── ContentView.swift          # Главный роутер
├── Managers/
│   └── AuthManager.swift      # Менеджер авторизации
├── Models/
│   └── User.swift             # Модель пользователя
├── Views/
│   ├── WelcomeView.swift      # Экран приветствия
│   ├── AuthView.swift         # Авторизация
│   ├── MainTabView.swift      # Tab навигация
│   ├── HomeView.swift         # Стрічка
│   └── DocumentsView.swift    # Документи (єДокумент)
├── Components/
│   ├── AnimatedGradientBackground.swift
│   ├── GlassmorphicCard.swift
│   └── DocumentCard.swift     # Карточка єДокумент
└── Utilities/
    └── Color+Hex.swift        # Расширения
```

---

## 🎨 Особенности дизайна

### Glassmorphism эффект
Используется нативный `.ultraThinMaterial` для идеального эффекта матового стекла:
```swift
.background(.ultraThinMaterial)
```

### Анимированный градиент
Плавная анимация фона с 4 цветами:
- `#d4a5d4` - розовый
- `#f0e0c0` - бежевый
- `#c0e0a0` - зелёный
- `#e0d0f0` - сиреневый

### Бегущая строка
Бесконечная анимация текста с песней "Червона калина" 🌺

---

## 🛠 Build через Codemagic

### 1. Настройка проекта

Создай файл `codemagic.yaml` (уже создан)

### 2. Подключи репозиторий

1. Зайди на [codemagic.io](https://codemagic.io)
2. Подключи GitHub/GitLab репозиторий
3. Выбери `DiiaApp` проект

### 3. Настрой сертификаты

В Codemagic → Settings → Code signing:
- Добавь iOS Distribution certificate
- Добавь Provisioning Profile

### 4. Запусти билд

```bash
# Локально (если установлен Codemagic CLI)
codemagic build --workflow ios-diia-workflow

# Или через Git
git push origin main
```

### 5. Получи IPA

После успешного билда:
- Скачай `.ipa` файл
- Установи через Xcode или TestFlight

---

## 📲 Установка на iPhone

### Через Xcode (для разработки)

1. Подключи iPhone к Mac
2. В Xcode выбери своё устройство
3. Нажми ⌘R
4. На iPhone: Settings → General → VPN & Device Management → Trust

### Через TestFlight (для тестирования)

1. Билд в Codemagic
2. Upload в App Store Connect
3. Добавь тестеров в TestFlight
4. Установи через TestFlight app

---

## 🎯 Функционал

### Готово ✅
- Экран приветствия
- Авторизация (сохраняется в UserDefaults)
- Анимированный градиентный фон
- Glassmorphism карточки
- єДокумент с бегущей строкой
- Нижняя навигация (4 таба)
- Экран "Стрічка" с сервисами

### Можно добавить 🚧
- Face ID / Touch ID для входа
- Камера для QR-кодов
- Push уведомления
- Офлайн режим (CoreData)
- Виджеты iOS 17+
- Live Activities

---

## 🔧 Кастомизация

### Изменить Bundle ID

В `Info.plist`:
```xml
<key>CFBundleIdentifier</key>
<string>com.yourcompany.diia</string>
```

### Добавить своё фото

1. Добавь изображение в Assets.xcassets
2. В `DocumentCard.swift` замени:
```swift
Image("user_photo")
    .resizable()
```

### Изменить цвета

В `AnimatedGradientBackground.swift`:
```swift
let colors: [Color] = [
    Color(hex: "твой_цвет"),
    // ...
]
```

---

## 📋 TODO для продакшна

- [ ] Добавить Face ID
- [ ] Интеграция с бэкендом
- [ ] QR-код сканер
- [ ] Кеширование данных
- [ ] Обработка ошибок
- [ ] Локализация (укр/англ)
- [ ] Dark mode
- [ ] iPad адаптация

---

## 🐛 Known Issues

1. **Бегущая строка** - может глючить на старых девайсах (iOS 15)
   - Решение: добавить проверку производительности

2. **Glassmorphism** - не работает на iOS 14
   - Решение: добавить fallback на обычный blur

---

## 📞 Помощь

Вопросы? Пиши issue или в Telegram!

---

Зроблено з ❤️ для України 🇺🇦

