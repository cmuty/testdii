# 🚀 Повний гід: Збірка iOS додатку в Codemagic

## Крок 1: Підготовка GitHub репозиторію

### 1.1. Створи GitHub репозиторій

1. Зайди на [github.com](https://github.com)
2. Натисни **New repository**
3. Назва: `diia-ios` (або своя)
4. Опис: `iOS копія додатку Дія`
5. Public або Private (на вибір)
6. Натисни **Create repository**

### 1.2. Завантаж код на GitHub

```bash
# Перейди в папку проекту
cd DiiaApp

# Ініціалізуй git (якщо ще не зроблено)
git init

# Додай всі файли
git add .

# Створи коміт
git commit -m "Initial commit: Дія iOS app готовий до білду"

# Додай remote репозиторій
git remote add origin https://github.com/YOUR_USERNAME/diia-ios.git

# Завантаж код
git branch -M main
git push -u origin main
```

✅ Код тепер на GitHub!

---

## Крок 2: Реєстрація в Codemagic

### 2.1. Створи акаунт

1. Зайди на [codemagic.io](https://codemagic.io)
2. Натисни **Sign up for free**
3. Обери **Sign in with GitHub**
4. Дозволь Codemagic доступ до репозиторіїв

### 2.2. Перевір план

- Free plan: 500 хвилин білду на місяць
- Для тестування - цілком достатньо!

✅ Акаунт створено!

---

## Крок 3: Додавання додатку в Codemagic

### 3.1. Додай репозиторій

1. В Codemagic натисни **Add application**
2. Обери **GitHub**
3. Знайди свій репозиторій `diia-ios`
4. Натисни **Select**

### 3.2. Налаштування білду

1. Codemagic автоматично виявить `codemagic.yaml` ✅
2. Обери **Use codemagic.yaml**
3. Натисни **Finish**

✅ Додаток доданий!

---

## Крок 4: Налаштування Code Signing (ВАЖЛИВО!)

iOS додатки потребують підпису для встановлення на реальні пристрої.

### Варіант A: Automatic Code Signing (Рекомендовано для початківців)

#### 4.1. Підготовка Apple ID

**Потрібно:**
- Apple ID (безкоштовний)
- Не потрібен платний Apple Developer Program ($99/рік)

#### 4.2. Налаштування в Codemagic

1. Зайди в свій додаток в Codemagic
2. Натисни на **Settings** (⚙️)
3. Обери **Code signing identities**
4. Клікни на **iOS code signing**

#### 4.3. Підключення Apple ID

1. Натисни **Add key**
2. Обери **App Store Connect API key**
3. Зайди на [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
4. Users and Access → Keys → App Store Connect API
5. Натисни **+** (створити ключ)
6. Введи назву: `Codemagic`
7. Access: **Developer**
8. Натисни **Generate**
9. **ВАЖЛИВО**: Скачай .p8 файл (можна тільки один раз!)
10. Запам'ятай:
    - Key ID (8 символів)
    - Issuer ID (UUID)

#### 4.4. Додай ключ в Codemagic

1. Поверніся в Codemagic
2. App Store Connect API:
   - **Issuer ID**: вставити з App Store Connect
   - **Key ID**: вставити з App Store Connect
   - **API Key**: відкрити .p8 файл і скопіювати весь вміст
3. Натисни **Save**

#### 4.5. Налаштуй Bundle ID

1. В Codemagic → Settings → Environment variables
2. Додай змінну:
   - **Name**: `BUNDLE_ID`
   - **Value**: `com.nutipov.diia` (або свій)
   - **Group**: (залиш порожнім)
   - **Secure**: ❌
3. Натисни **Add**

✅ Code Signing налаштовано!

---

### Варіант B: Manual Code Signing (Для досвідчених)

<details>
<summary>Натисни, щоб розгорнути</summary>

#### Вимоги:
- Mac з Xcode
- Apple Developer Program ($99/рік)

#### Кроки:

1. **Створи сертифікат:**
   ```bash
   # У Xcode
   Xcode → Settings → Accounts
   → Manage Certificates → + → Apple Development
   ```

2. **Експортуй сертифікат:**
   ```bash
   # У Keychain Access
   Keychain Access → Certificates
   → Знайди "Apple Development"
   → Right-click → Export
   → Збережи як .p12
   → Встанови пароль
   ```

3. **Створи Provisioning Profile:**
   - [developer.apple.com](https://developer.apple.com)
   - Certificates, IDs & Profiles
   - Provisioning Profiles → +
   - Development
   - Обери Bundle ID
   - Обери сертифікат
   - Обери пристрої
   - Скачай .mobileprovision

4. **Завантаж в Codemagic:**
   - Settings → Code signing
   - Upload certificate (.p12)
   - Upload provisioning profile (.mobileprovision)

</details>

---

## Крок 5: Запуск першого білду

### 5.1. Запусти білд

1. В Codemagic → твій додаток
2. Натисни **Start new build**
3. Обери:
   - **Workflow**: `ios-diia-workflow`
   - **Branch**: `main`
4. Натисни **Start build**

### 5.2. Спостерігай за процесом

Білд проходить етапи:
```
⏳ Queued               (0-2 хв)
📥 Cloning repository   (30 сек)
🔧 Setting up          (1 хв)
🏗️ Building             (3-5 хв)
📦 Exporting IPA       (1 хв)
✅ Publishing          (30 сек)
```

**Загальний час: 7-10 хвилин**

### 5.3. Перевір логи

Натисни на етап, щоб побачити деталі:
- Зелені ✅ - успіх
- Червоні ❌ - помилка

✅ Білд завершено!

---

## Крок 6: Скачування IPA

### 6.1. Після успішного білду

1. Прокрути вниз до **Artifacts**
2. Знайди `DiiaApp.ipa`
3. Натисни **Download**

### 6.2. Перевір email

На `nutipovottakvot@gmail.com` прийде лист:
- Статус білду
- Посилання на артефакти
- Логи

✅ IPA скачано!

---

## Крок 7: Встановлення на iPhone

### Метод 1: Через Xcode (найпростіший з Mac)

1. Підключи iPhone до Mac (USB)
2. Відкрий Xcode
3. **Window** → **Devices and Simulators**
4. Обери свій iPhone
5. Перетягни `DiiaApp.ipa` на вікно
6. Дочекайся встановлення

### Метод 2: Через Diawi (без Mac)

1. Зайди на [diawi.com](https://diawi.com)
2. Перетягни `DiiaApp.ipa`
3. Встанови пароль (опційно)
4. Натисни **Send**
5. Скопіюй посилання
6. Відкрий на iPhone в **Safari**
7. Натисни **Install**
8. **Settings** → **General** → **VPN & Device Management**
9. Довіряй розробнику

### Метод 3: Через TestFlight (для тестування)

1. Зайди на [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. My Apps → + → New App
3. TestFlight → Internal Testing
4. Завантаж `.ipa`
5. Додай себе як тестера
6. Скачай TestFlight app на iPhone
7. Встанови додаток

✅ Додаток встановлено!

---

## Крок 8: Автоматизація білдів

### 8.1. Білд при кожному push

Вже налаштовано в `codemagic.yaml`:

```yaml
triggering:
  events:
    - push
  branch_patterns:
    - pattern: '*'
```

Тепер при кожному:
```bash
git add .
git commit -m "Update"
git push
```

Автоматично запуститься новий білд! 🚀

### 8.2. Білд тільки для main гілки

Змінити в `codemagic.yaml`:

```yaml
branch_patterns:
  - pattern: 'main'
    include: true
  - pattern: '*'
    include: false
```

---

## 🐛 Можливі помилки та рішення

### ❌ "No matching provisioning profiles found"

**Причина**: Bundle ID не налаштований або немає сертифікатів

**Рішення**:
1. Перевір Bundle ID в Settings → Environment variables
2. Перевір Code Signing в Settings → Code signing identities
3. Спробуй перезапустити білд

---

### ❌ "xcodebuild: error: 'DiiaApp.xcodeproj' does not exist"

**Причина**: Файл проекту не було закомічено в git

**Рішення**:
```bash
git add DiiaApp.xcodeproj
git commit -m "Add Xcode project"
git push
```

---

### ❌ "Build failed at 'Build iOS app' step"

**Причина**: Помилки компіляції в коді

**Рішення**:
1. Спочатку зібери проект локально в Xcode (⌘B)
2. Виправ всі помилки
3. Закоміть і push:
   ```bash
   git add .
   git commit -m "Fix build errors"
   git push
   ```

---

### ❌ "Archive not found"

**Причина**: Невірний шлях до архіву

**Рішення**:
Перевір в `codemagic.yaml`:
```yaml
archivePath: $HOME/build/DiiaApp.xcarchive
```

---

### ❌ "Code signing error"

**Причина**: Проблеми з сертифікатами

**Рішення**:
1. Видали старі сертифікати в Settings → Code signing
2. Додай нові
3. Перезапусти білд

---

## 📊 Моніторинг білдів

### Статуси:

- ✅ **Success** - все ок, скачуй IPA
- ❌ **Failed** - дивись логи
- ⏸️ **Canceled** - білд скасовано
- ⏳ **Pending** - в черзі
- ⚙️ **Building** - йде процес

### Email нотифікації:

Налаштовано в `codemagic.yaml`:
```yaml
publishing:
  email:
    recipients:
      - nutipovottakvot@gmail.com
```

Можна додати більше email:
```yaml
recipients:
  - email1@gmail.com
  - email2@gmail.com
```

---

## 🎯 Чеклист перед білдом

- [ ] Код на GitHub
- [ ] `codemagic.yaml` в корені репо
- [ ] `.xcodeproj` директорія закомічена
- [ ] Bundle ID вказаний
- [ ] Code signing налаштований
- [ ] Email для нотифікацій вказаний
- [ ] Проект збирається локально (⌘B)

---

## 💡 Корисні поради

### 1. Badge статусу білду в README

Додай в `README.md`:
```markdown
![Build Status](https://api.codemagic.io/apps/YOUR_APP_ID/status_badge.svg)
```

Знайди `YOUR_APP_ID` в Settings → General → Application ID

### 2. Slack нотифікації

В `codemagic.yaml`:
```yaml
publishing:
  slack:
    channel: '#ios-builds'
    webhook_url: $SLACK_WEBHOOK
```

### 3. Збереження логів

Після кожного білду скачай логи:
- Натисни на білд
- Справа вгорі → Download logs

### 4. Кешування для швидших білдів

В `codemagic.yaml`:
```yaml
cache:
  cache_paths:
    - $HOME/Library/Caches/CocoaPods
```

---

## 📚 Додаткові ресурси

- [Документація Codemagic](https://docs.codemagic.io)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)

---

## 🆘 Потрібна допомога?

### Codemagic Support:
- Email: support@codemagic.io
- Docs: [docs.codemagic.io](https://docs.codemagic.io)
- Slack: [codemagic-io.slack.com](https://codemagic-io.slack.com)

### Цей проект:
- Email: nutipovottakvot@gmail.com
- GitHub Issues: створи issue в репозиторії

---

**Успіхів з білдом! 🚀🇺🇦**

