# 📱 Дія - Native iOS App 🇺🇦

Полноценное нативное iOS приложение на SwiftUI - точная копия "Дія"

## ✅ Что готово

### Экраны
- 👋 Welcome (Привіт)
- 🔐 Авторизация
- 📄 Документи (єДокумент)
- 📰 Стрічка (Home)
- ⚡ Сервіси
- 👤 Меню

### Фичи
- ✨ Glassmorphism эффект (нативный)
- 🌈 Анимированный градиент фона
- 📜 Бегущая строка "Червона калина"
- 🎨 Точный дизайн как в Дії
- 💾 Сохранение авторизации (UserDefaults)
- 📱 Черный Tab Bar как в оригинале

---

## 🚀 Быстрый старт

### 1. Открой в Xcode

```
File → Open → Выбери DiiaApp.xcodeproj
```

### 2. Настрой Signing

1. Выбери проект `DiiaApp`
2. Target `DiiaApp`
3. Signing & Capabilities
4. Включи **Automatically manage signing**
5. Выбери свой **Team**

### 3. Запусти

- Выбери симулятор (iPhone 15 Pro)
- Нажми **⌘R** (Command + R)
- Готово! 🎉

---

## 📂 Структура проекта

```
DiiaApp/
├── DiiaApp.swift                 # Main
├── ContentView.swift             # Роутинг
├── Managers/
│   └── AuthManager.swift         # Авторизация
├── Models/
│   └── User.swift                # Модель юзера
├── Views/
│   ├── WelcomeView.swift
│   ├── AuthView.swift
│   ├── MainTabView.swift
│   ├── HomeView.swift
│   └── DocumentsView.swift
├── Components/
│   ├── AnimatedGradientBackground.swift
│   ├── GlassmorphicCard.swift
│   └── DocumentCard.swift
└── Utilities/
    └── Color+Hex.swift
```

---

## 🎨 Дизайн

### Цвета градиента
- `#d4a5d4` - Розовый
- `#f0e0c0` - Бежевый  
- `#c0e0a0` - Зелёный
- `#e0d0f0` - Сиреневый

### Бегущая строка
- `#a4eb97` → `#9addb0` → `#8ed1cc`

---

## 🔧 Codemagic Build

1. Создай GitHub репо
2. Загрузи код:
```bash
cd DiiaApp
git init
git add .
git commit -m "Initial commit"
git push
```
3. Подключи к [codemagic.io](https://codemagic.io)
4. Настрой Code Signing
5. Запусти билд!

---

## 📲 Установка на iPhone

### Через Xcode
1. Подключи iPhone
2. Выбери устройство
3. ⌘R
4. Trust на iPhone

### Через TestFlight
1. Build в Codemagic
2. Upload в App Store Connect
3. Добавь тестеров
4. Скачай через TestFlight

---

## 🛠 Дальнейшее развитие

- [ ] Face ID
- [ ] QR сканер (Camera)
- [ ] Push уведомления
- [ ] CoreData (offline)
- [ ] Dark mode
- [ ] Локализация
- [ ] iPad support

---

Зроблено з ❤️ для України 🇺🇦
