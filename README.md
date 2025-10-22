# Дія - iOS App 🇺🇦

Копія українського додатку "Дія" з сучасним UI/UX дизайном для iOS.

## 📱 Опис

Це SwiftUI версія популярного українського додатку для роботи з електронними документами та державними послугами.

### Функціонал:
- 🔐 Аутентифікація (Face ID / Touch ID)
- 📄 Електронні документи (паспорт, ID-карта, водійське посвідчення)
- 🎨 Сучасний дизайн з glassmorphic ефектами
- 🌈 Анімовані градієнти
- 📱 Адаптивний інтерфейс

## 🚀 Швидкий старт

### Простий процес (3 кроки):

#### 1️⃣ Білд в Codemagic
- Зайди на [codemagic.io](https://codemagic.io) → Sign in with GitHub
- Додай цей репозиторій
- Start new build → `ios-diia-workflow`
- Скачай `.ipa` з Artifacts (7-10 хвилин)

#### 2️⃣ Встановлення через Sideloadly або AltStore
- **Sideloadly** (найпростіше):
  - Скачай [sideloadly.io](https://sideloadly.io)
  - Підключи iPhone → Відкрий Sideloadly
  - Вибери `.ipa` → Введи Apple ID → Start
  - Готово! ✅

- **AltStore** (з автооновленням):
  - Скачай [altstore.io](https://altstore.io)
  - Встанови AltStore на iPhone
  - Відкрий `.ipa` через AltStore
  - Автоматично оновлює підпис кожні 7 днів! 🔄

#### 3️⃣ Запусти Дію на iPhone! 🇺🇦

> 📖 **Детальні інструкції**: Дивись [SIDELOADLY_GUIDE.md](SIDELOADLY_GUIDE.md)

---

### Що потрібно?
- ✅ Безкоштовний Apple ID (не потрібен платний Developer аккаунт!)
- ✅ Комп'ютер (Windows/Mac)
- ✅ USB кабель для iPhone
- ✅ 10 хвилин часу

### Що НЕ потрібно?
- ❌ Jailbreak
- ❌ Платний Apple Developer ($99/рік)
- ❌ Складні налаштування
- ❌ Mac (працює і на Windows!)

### Варіант 2: Локальна розробка

#### Вимоги:
- macOS 13.0+
- Xcode 15.0+
- iOS 15.0+ (для тестування)

#### Інсталяція:

1. **Clone репозиторій**
   ```bash
   git clone https://github.com/YOUR_USERNAME/DiiaApp.git
   cd DiiaApp
   ```

2. **Відкрий проект**
   ```bash
   open DiiaApp.xcodeproj
   ```

3. **Налаштуй Bundle ID**
   - Відкрий проект в Xcode
   - Обери target "DiiaApp"
   - Signing & Capabilities
   - Змінь Bundle Identifier на свій (наприклад: `com.yourname.diia`)
   - Обери свою Team

4. **Запусти**
   - Обери симулятор або реальний пристрій
   - Натисни ⌘R або кнопку Run

## 📁 Структура проекту

```
DiiaApp/
├── DiiaApp.swift              # App entry point
├── ContentView.swift          # Main content view
├── Info.plist                 # App configuration
├── Assets.xcassets/           # Images and colors
├── Components/                # Reusable UI components
│   ├── AnimatedGradientBackground.swift
│   ├── DocumentCard.swift
│   └── GlassmorphicCard.swift
├── Views/                     # App screens
│   ├── WelcomeView.swift
│   ├── AuthView.swift
│   ├── HomeView.swift
│   ├── MainTabView.swift
│   └── DocumentsView.swift
├── Managers/                  # Business logic
│   └── AuthManager.swift
├── Models/                    # Data models
│   └── User.swift
├── Utilities/                 # Helper functions
│   └── Color+Hex.swift
└── DiiaApp.xcodeproj/         # Xcode project
```

## 🔧 Конфігурація Codemagic

Файл `codemagic.yaml` вже налаштований для автоматичної збірки:

```yaml
workflows:
  ios-diia-workflow:
    name: Дія iOS Build
    instance_type: mac_mini_m1
    xcode: 15.0
```

### Автоматичні білди при push:

```yaml
triggering:
  events:
    - push
  branch_patterns:
    - pattern: '*'
```

### Артефакти:
- `.ipa` файл для встановлення
- `.xcarchive` для дебагу
- Email нотифікації

## 📲 Встановлення на iPhone

### 🌟 Рекомендовано: Sideloadly (найпростіше)
1. Скачай [Sideloadly](https://sideloadly.io)
2. Підключи iPhone до комп'ютера (USB)
3. Відкрий Sideloadly → вибери `DiiaApp.ipa`
4. Введи свій Apple ID (безкоштовний)
5. Натисни **Start**
6. Готово! Додаток на iPhone ✅

**Переваги:**
- ⚡ Швидко (1-3 хвилини)
- 🆓 Безкоштовно
- 🪟 Працює на Windows і Mac
- ✅ Не потрібен платний Developer аккаунт

### 🔄 Альтернатива: AltStore (з автооновленням)
1. Встанови [AltStore](https://altstore.io) на комп'ютер та iPhone
2. Скопіюй `.ipa` на iPhone
3. Відкрий через AltStore → Install
4. Автоматично оновлює підпис через Wi-Fi! 🎉

**Переваги:**
- 🔄 Автооновлення підпису (кожні 7 днів)
- 📦 Власний App Store для sideloaded додатків
- 📱 Менше залежність від комп'ютера

> 📖 **Повний гід**: [SIDELOADLY_GUIDE.md](SIDELOADLY_GUIDE.md)

### Інші методи:

<details>
<summary>Через Xcode (потрібен Mac)</summary>

1. Підключи iPhone до Mac
2. Window → Devices and Simulators
3. Перетягни `.ipa` на пристрій
</details>

<details>
<summary>Через Diawi (швидкий тест)</summary>

1. Зайди на [diawi.com](https://diawi.com)
2. Upload `.ipa`
3. Отримай посилання
4. Відкрий на iPhone в Safari
</details>

## 🎨 Дизайн

### Кольори:
- Primary: `#3D7EFF` (синій)
- Success: `#00C853` (зелений)
- Background: Градієнт від `#1A1F3A` до `#2D3561`

### Компоненти:
- **GlassmorphicCard**: Скляний ефект з розмиттям
- **AnimatedGradientBackground**: Анімований градієнт
- **DocumentCard**: Картка документа з анімацією

## 🔐 Bundle ID

За замовчуванням: `com.nutipov.diia`

> **Для Sideloadly/AltStore**: Bundle ID можна не міняти! 
> Sideloadly автоматично підпише IPA твоїм Apple ID.

Якщо все ж хочеш змінити:
```yaml
# У codemagic.yaml
vars:
  BUNDLE_ID: "com.yourname.diia"
```

## 📝 Вимоги

### Мінімальні:
- iOS 15.0+
- Swift 5.0+
- Xcode 15.0+

### Frameworks:
- SwiftUI
- LocalAuthentication (Face ID / Touch ID)

## 🐛 Troubleshooting

### Codemagic:

#### "Build failed"
**Рішення:**
1. Подивись логи в Codemagic (детальний вивід)
2. Перевір що всі файли в Git
3. Спробуй повторний білд

### Sideloadly/AltStore:

#### "Could not install" / "Maximum apps"
**Рішення:**
1. Безкоштовний Apple ID: максимум 3 додатки
2. Видали старі sideloaded додатки
3. Settings → General → iPhone Storage

#### "Untrusted Developer"
**Рішення:**
1. Settings → General → VPN & Device Management
2. Знайди свій Apple ID
3. Trust

#### Додаток працює тільки 7 днів
**Рішення:**
- Це обмеження безкоштовного Apple ID
- **Sideloadly**: переустанови кожні 7 днів (2 хвилини)
- **AltStore**: автоматично оновлює через Wi-Fi! ✅

> 📖 **Більше рішень**: [SIDELOADLY_GUIDE.md](SIDELOADLY_GUIDE.md)

## 📧 Контакт

Email: nutipovottakvot@gmail.com

## 📄 Ліцензія

Цей проект створений для навчальних цілей.

## 🙏 Подяка

Натхнення: Офіційний додаток "Дія" від Міністерства цифрової трансформації України

---

**Made with ❤️ in Ukraine 🇺🇦**
