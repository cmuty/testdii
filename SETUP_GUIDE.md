# 🚀 Гайд по запуску iOS проекта

## Шаг 1: Создание проекта в Xcode

1. **Открой Xcode** → `File` → `New` → `Project`

2. **Выбери шаблон:**
   - iOS → App
   - Нажми Next

3. **Настрой проект:**
   - **Product Name**: `DiiaApp`
   - **Team**: Выбери свой Apple Developer аккаунт
   - **Organization Identifier**: `com.yourname`
   - **Bundle Identifier**: `com.yourname.DiiaApp`
   - **Interface**: SwiftUI
   - **Language**: Swift
   - **Storage**: None
   - Убери галочки с Core Data, CloudKit, Tests

4. **Сохрани проект** в папку `DiiaApp`

---

## Шаг 2: Добавление файлов

### Создай структуру папок в Xcode:

```
DiiaApp/
├── Managers/
├── Models/
├── Views/
├── Components/
├── Utilities/
└── Info.plist
```

**Как создать группу (папку):**
1. ПКМ на `DiiaApp` в Project Navigator
2. `New Group`
3. Назови (например, `Managers`)

### Перенеси файлы:

1. **Найди все `.swift` файлы** из моего кода
2. **Перетащи в соответствующие папки** в Xcode
3. **Замени содержимое** существующих файлов

---

## Шаг 3: Настройка Info.plist

1. Найди `Info.plist` в Project Navigator
2. Замени содержимое на мой код
3. Или добавь вручную:
   - Display Name: `Дія`
   - Bundle Display Name: `Дія`
   - Supported Interface Orientations: только Portrait

---

## Шаг 4: Запуск на симуляторе

1. В Xcode выбери **iPhone 15 Pro** (или любой)
2. Нажми **⌘R** (Command + R)
3. Подожди компиляции (~30 сек)
4. Приложение запустится! 🎉

---

## Шаг 5: Запуск на реальном iPhone

### Подключи устройство:

1. Подключи iPhone к Mac через USB
2. На iPhone: разреши подключение
3. В Xcode выбери своё устройство вместо симулятора

### Настрой Signing:

1. Выбери проект `DiiaApp` в Project Navigator
2. Выбери Target `DiiaApp`
3. Вкладка **Signing & Capabilities**
4. Включи **Automatically manage signing**
5. Выбери свой **Team** (Apple ID)

### Запусти:

1. Нажми **⌘R**
2. На iPhone появится ошибка "Untrusted Developer"
3. **На iPhone:**
   - Settings → General → VPN & Device Management
   - Нажми на свой Apple ID
   - Нажми **Trust**
4. Запусти снова из Xcode

Готово! Приложение работает на iPhone! 📱

---

## Шаг 6: Build через Codemagic

### Создай GitHub репозиторий:

```bash
cd DiiaApp
git init
git add .
git commit -m "Initial commit - Дія iOS app"
git branch -M main
git remote add origin https://github.com/yourname/diia-ios.git
git push -u origin main
```

### Настрой Codemagic:

1. Зайди на [codemagic.io](https://codemagic.io)
2. Sign in с GitHub
3. Нажми **Add application**
4. Выбери репозиторий `diia-ios`
5. Выбери `DiiaApp` проект
6. Codemagic автоматически найдёт `codemagic.yaml`

### Настрой Code Signing:

1. В Codemagic → **Settings** → **Code signing**
2. iOS code signing:
   - **Automatic** (если есть Apple Developer аккаунт)
   - Или **Manual** (загрузи сертификаты)
3. Выбери свой **Team ID**

### Запусти билд:

1. Вкладка **Builds**
2. Нажми **Start new build**
3. Выбери `ios-diia-workflow`
4. Нажми **Start build**

Ждём 5-10 минут...

### Скачай IPA:

1. После успешного билда
2. Artifacts → скачай `.ipa` файл
3. Установи через Xcode или TestFlight

---

## 🎨 Кастомизация

### Добавить иконку приложения:

1. В Xcode: Assets.xcassets → AppIcon
2. Перетащи иконки всех размеров:
   - 20pt, 29pt, 40pt, 60pt, 76pt, 83.5pt (для iPad)
   - Используй [appicon.co](https://appicon.co) для генерации

### Изменить Launch Screen:

1. В Assets.xcassets создай новый Color Set
2. Назови `LaunchScreenBackground`
3. Установи цвет `#f0e0c0` (бежевый)

---

## ❓ Частые проблемы

### "No account for team" при signing
**Решение:**
1. Xcode → Settings → Accounts
2. Добавь свой Apple ID
3. Download Manual Profiles

### "Command PhaseScriptExecution failed"
**Решение:**
1. Build Phases → удали лишние скрипты
2. Clean Build Folder (⌘⇧K)
3. Rebuild (⌘B)

### Приложение крашится на запуске
**Решение:**
1. Проверь все import'ы
2. Убедись что все файлы добавлены в Target
3. Проверь консоль в Xcode (⌘⇧C)

### Codemagic не находит проект
**Решение:**
1. Проверь что `codemagic.yaml` в корне репозитория
2. Проверь что `.xcodeproj` загружен в Git
3. Попробуй Trigger build manually

---

## 📞 Нужна помощь?

Я здесь! Спрашивай что угодно по коду или настройке! 

---

Успехів! 🇺🇦

