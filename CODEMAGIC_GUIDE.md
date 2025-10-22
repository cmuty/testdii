# 🚀 Гайд по билду через Codemagic

## 📋 Подготовка (5 минут)

### 1. Создай Xcode проект локально

Нужен только для того чтобы Codemagic знал структуру:

```
1. Открой Xcode
2. File → New → Project
3. iOS → App
4. Product Name: DiiaApp
5. Team: выбери свой Apple ID
6. Bundle Identifier: com.nutipov.diia
   (можешь свой, например com.ТВОЕИМЯ.diia)
7. Interface: SwiftUI
8. Language: Swift
9. Сохрани в папку DiiaApp
```

### 2. Добавь все файлы в проект

1. В Xcode создай группы:
   - ПКМ на DiiaApp → New Group
   - Создай: `Managers`, `Models`, `Views`, `Components`, `Utilities`

2. Перетащи файлы из Desktop в соответствующие группы:
   - `DiiaApp.swift` → корень
   - `ContentView.swift` → корень
   - `AuthManager.swift` → Managers/
   - И т.д.

3. Замени `Info.plist` содержимым из файла

### 3. Проверь что работает локально

```
⌘B (Build)
⌘R (Run на симуляторе)
```

Если работает - идём дальше! ✅

---

## 🌐 Настройка GitHub

### 1. Создай репозиторий

```bash
cd DiiaApp
git init
git add .
git commit -m "Initial commit - Дія iOS app"
```

### 2. Создай GitHub репо

1. Зайди на [github.com](https://github.com)
2. New Repository
3. Name: `diia-ios`
4. Public или Private (на выбор)
5. Create

### 3. Загрузи код

```bash
git remote add origin https://github.com/ТВОЙНИК/diia-ios.git
git branch -M main
git push -u origin main
```

Готово! Код на GitHub ✅

---

## ⚙️ Настройка Codemagic

### 1. Регистрация

1. Зайди на [codemagic.io](https://codemagic.io)
2. Sign in with GitHub
3. Разрешить доступ к репозиториям

### 2. Добавление приложения

1. **Applications** → **Add application**
2. Выбери репозиторий `diia-ios`
3. **Set up build configuration**
4. Codemagic автоматически найдёт `codemagic.yaml` ✅

### 3. Code Signing (ВАЖНО!)

#### Вариант A: Automatic (проще)

1. **Settings** → **Code signing identities**
2. iOS code signing → **Automatic code signing**
3. Войди в Apple ID
4. Выбери Team
5. Codemagic сам создаст сертификаты

#### Вариант B: Manual (если нужен контроль)

1. На Mac создай сертификаты:
   ```bash
   # В Xcode
   Xcode → Settings → Accounts → Manage Certificates
   → + → Apple Development
   ```

2. Экспортируй:
   ```bash
   Keychain Access → Certificates → Экспорт .p12
   ```

3. Загрузи в Codemagic:
   - **Settings** → **Code signing**
   - Upload certificate (.p12)
   - Upload provisioning profile

### 4. Environment Variables (опционально)

В `codemagic.yaml` уже настроено:
```yaml
BUNDLE_ID: "com.nutipov.diia"
```

Если хочешь свой Bundle ID:
1. Измени в `codemagic.yaml`
2. Commit & Push

---

## 🎬 Запуск билда

### 1. Первый билд

1. В Codemagic → **Start new build**
2. Выбери workflow: `ios-diia-workflow`
3. Branch: `main`
4. Нажми **Start build**

### 2. Процесс билда (~5-10 минут)

```
✓ Cloning repository
✓ Installing Xcode
✓ Building iOS app
✓ Exporting IPA
✓ Uploading artifacts
```

### 3. Получение IPA

После успешного билда:

1. **Artifacts** → скачай `.ipa` файл
2. Или получишь на email: `nutipovottakvot@gmail.com`

---

## 📲 Установка на iPhone

### Способ 1: Через Xcode

```
1. Подключи iPhone к Mac
2. Xcode → Window → Devices and Simulators
3. Перетащи .ipa на устройство
```

### Способ 2: Через TestFlight

```
1. Загрузи .ipa в App Store Connect
2. TestFlight → Internal Testing
3. Добавь себя как тестера
4. Скачай через TestFlight app
```

### Способ 3: Через Diawi (быстро)

```
1. Зайди на diawi.com
2. Upload .ipa
3. Получишь ссылку
4. Открой на iPhone в Safari
5. Установи
```

---

## 🔄 Автоматические билды

### Билд при каждом push:

В `codemagic.yaml` добавь:

```yaml
triggering:
  events:
    - push
  branch_patterns:
    - pattern: 'main'
      include: true
```

Теперь каждый `git push` = новый билд! 🚀

---

## 🐛 Troubleshooting

### "No scheme found"

**Решение:**
```
1. В Xcode: Product → Scheme → Manage Schemes
2. Убедись что DiiaApp scheme is Shared ✓
3. Commit .xcodeproj/xcshareddata/
```

### "Code signing error"

**Решение:**
```
1. Проверь Bundle ID в Codemagic settings
2. Должен совпадать с codemagic.yaml
3. Пересоздай сертификаты
```

### "Build failed - xcodebuild"

**Решение:**
```
1. Проверь что проект билдится локально (⌘B)
2. Проверь Xcode version (15.0)
3. Посмотри полный лог в Codemagic
```

### "Archive not found"

**Решение:**
```yaml
# В codemagic.yaml проверь путь:
archivePath: $HOME/Library/Developer/Xcode/Archives/DiiaApp.xcarchive
```

---

## 📊 Статус билда

Codemagic покажет:
- ✅ Success - всё ок, скачивай IPA
- ❌ Failed - смотри логи
- ⏸ Pending - в очереди
- ⚙️ Building - идёт процесс

---

## 💡 Pro Tips

### 1. Badges в README

Добавь в GitHub README:
```markdown
![Build Status](https://api.codemagic.io/apps/APP_ID/status_badge.svg)
```

### 2. Slack уведомления

В `codemagic.yaml`:
```yaml
publishing:
  slack:
    channel: '#ios-builds'
    notify:
      success: true
```

### 3. Несколько workflow

```yaml
workflows:
  debug-build:
    # Для разработки
  
  release-build:
    # Для продакшна
```

---

## 🎯 Чеклист перед билдом

- [ ] Проект билдится локально (⌘B)
- [ ] Код на GitHub
- [ ] `codemagic.yaml` в корне репо
- [ ] Bundle ID настроен
- [ ] Code signing настроен в Codemagic
- [ ] Email для уведомлений указан

---

## 📬 Результат

После успешного билда:

1. **Email** → `nutipovottakvot@gmail.com`
   - Ссылка на билд
   - Статус
   - Логи

2. **Artifacts** в Codemagic:
   - `DiiaApp.ipa` - установочный файл
   - `.dSYM` - для дебага крашей

3. **Установка** на iPhone через один из способов выше

---

Готово! Теперь можешь билдить Дію через Codemagic! 🇺🇦

---

## 🆘 Нужна помощь?

- Документация: [docs.codemagic.io](https://docs.codemagic.io)
- Support: support@codemagic.io
- Или пиши мне! 😊

