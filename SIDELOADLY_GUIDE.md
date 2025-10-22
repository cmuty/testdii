# 📲 Гід: Установка Дії через Sideloadly / AltStore

## 🎯 Для чого це потрібно?

**Sideloadly** та **AltStore** дозволяють встановлювати додатки на iPhone **БЕЗ**:
- ❌ Платного Apple Developer аккаунту ($99/рік)
- ❌ Jailbreak
- ❌ Складних налаштувань

**Потрібно тільки**:
- ✅ Безкоштовний Apple ID
- ✅ Комп'ютер (Windows/Mac)
- ✅ USB кабель для підключення iPhone

---

## 📥 Частина 1: Отримання IPA з Codemagic

### Крок 1: Запусти білд в Codemagic

1. Зайди на [codemagic.io](https://codemagic.io)
2. Обери проект **DiiaApp**
3. Натисни **Start new build**
4. Workflow: `ios-diia-workflow`
5. Branch: `main`
6. Натисни **Start build**

### Крок 2: Дочекайся завершення

⏱️ Білд займе **7-10 хвилин**

Етапи:
```
✅ Информация о сборке
✅ Сборка приложения (без подписи)
✅ Создание IPA для Sideloadly/AltStore
✅ Информация о файлах
```

### Крок 3: Скачай IPA

1. Прокрути вниз до **Artifacts**
2. Знайди `DiiaApp.ipa`
3. Натисни **Download**
4. Збережи файл (наприклад, на Desktop)

✅ **IPA готовий для встановлення!**

---

## 🔧 Частина 2: Встановлення через Sideloadly

### Що таке Sideloadly?

Найпростіший інструмент для встановлення IPA файлів на iPhone.
- 🪟 Працює на Windows і Mac
- 🆓 Безкоштовний
- 🚀 Швидкий і надійний

### Крок 1: Скачай Sideloadly

1. Зайди на [sideloadly.io](https://sideloadly.io)
2. Скачай для своєї ОС:
   - 🪟 **Windows** → SideloadlySetup.exe
   - 🍎 **Mac** → Sideloadly.dmg
3. Встанови програму

### Крок 2: Підготовка iPhone

1. **Підключи iPhone до комп'ютера** (USB)
2. На iPhone натисни **Trust This Computer**
3. Введи код розблокування iPhone

### Крок 3: Налаштування Sideloadly

1. Відкрий **Sideloadly**
2. Інтерфейс простий:
   ```
   ┌─────────────────────────────────┐
   │ IPA File: [Browse...]           │
   │ Apple Account: your@email.com   │
   │ Password: ••••••••              │
   │ Device: Your iPhone             │
   │                                  │
   │        [Start] [Advanced]       │
   └─────────────────────────────────┘
   ```

### Крок 4: Встановлення Дії

1. **IPA File**: Натисни **Browse** → Обери `DiiaApp.ipa`
2. **Apple Account**: Введи свій Apple ID (безкоштовний)
3. **Password**: Введи пароль від Apple ID
4. **Device**: Має автоматично визначитись твій iPhone
5. Натисни **Start**

### Крок 5: Процес встановлення

Sideloadly покаже прогрес:
```
⏳ Verifying IPA...
⏳ Signing with your Apple ID...
⏳ Installing to device...
✅ Done!
```

⏱️ Займе **1-3 хвилини**

### Крок 6: Довіра розробнику (перший раз)

На iPhone:
1. **Settings** (Налаштування)
2. **General** (Загальні)
3. **VPN & Device Management** (Керування пристроєм)
4. Під **Developer App** знайди свій Apple ID
5. Натисни на нього
6. Натисни **Trust "[your email]"**
7. Підтверди **Trust**

✅ **Дія встановлена!** 🇺🇦

---

## 🔄 Частина 3: Встановлення через AltStore

### Що таке AltStore?

Альтернатива Sideloadly з додатковими можливостями:
- 📱 Працює БЕЗ комп'ютера після налаштування
- 🔄 Автоматичне оновлення підпису (через Wi-Fi)
- 📦 Власний "App Store" для sideloaded додатків

### Крок 1: Встановлення AltStore на комп'ютері

**Windows:**
1. Скачай [AltServer](https://altstore.io)
2. Встанови iTunes (якщо немає)
3. Встанови iCloud (якщо немає)
4. Запусти AltServer (іконка в system tray)

**Mac:**
1. Скачай [AltServer](https://altstore.io)
2. Перетягни в Applications
3. Запусти AltServer (іконка в menu bar)

### Крок 2: Встановлення AltStore на iPhone

1. Підключи iPhone до комп'ютера (USB)
2. Натисни на іконку AltServer в tray/menu bar
3. **Install AltStore** → Обери свій iPhone
4. Введи Apple ID та пароль
5. Дочекайся встановлення

### Крок 3: Довіра AltStore (перший раз)

На iPhone:
1. **Settings** → **General** → **VPN & Device Management**
2. Знайди свій Apple ID
3. **Trust**

### Крок 4: Налаштування AltStore

1. Відкрий **AltStore** на iPhone
2. **Settings** (іконка ⚙️)
3. Введи Apple ID та пароль
4. Увімкни **Background Refresh**

### Крок 5: Встановлення Дії через AltStore

**Варіант A: Через комп'ютер**
1. Скопіюй `DiiaApp.ipa` на iPhone (AirDrop/Files)
2. Відкрий файл на iPhone
3. Обери **Open in AltStore**
4. Натисни **Install**

**Варіант B: Через iTunes File Sharing**
1. iTunes → iPhone → File Sharing → AltStore
2. Перетягни `DiiaApp.ipa`
3. На iPhone відкрий AltStore → My Apps
4. Знайди Дію → Install

✅ **Дія встановлена через AltStore!** 🇺🇦

---

## ⚡ Частина 4: Важлива інформація

### 🔄 Переустановка кожні 7 днів

**Безкоштовні Apple ID** мають обмеження:
- ⏰ Підпис діє **7 днів**
- Після цього додаток не запуститься
- Потрібно переустановити

**Рішення:**

**Sideloadly:**
- Кожні 7 днів: підключи iPhone → Sideloadly → Start

**AltStore:**
- Автоматично оновлює підпис через Wi-Fi! ✨
- Умови:
  - iPhone і комп'ютер в одній Wi-Fi мережі
  - AltServer запущений на комп'ютері
  - Background Refresh увімкнений

### 📊 Ліміт додатків

Безкоштовний Apple ID:
- Максимум **3 додатки** одночасно
- Включаючи сам AltStore (якщо використовуєш)

Платний Apple Developer ($99/рік):
- ⏰ Підпис діє **1 рік**
- ♾️ Безліч додатків

### 🔐 Безпека

**Чи безпечно вводити Apple ID?**
- ✅ Так, якщо скачуєш Sideloadly/AltStore з офіційних сайтів
- ✅ Пароль не зберігається
- ✅ Використовується тільки для підпису

**Рекомендації:**
- Використовуй App-Specific Password (якщо увімкнена 2FA)
- Створи окремий Apple ID для sideloading (опційно)

### 📱 Сумісність

**iOS версії:**
- ✅ iOS 12.2 і новіші
- ✅ Працює на iPhone та iPad

**Комп'ютери:**
- ✅ Windows 10/11
- ✅ macOS 10.14.4+

---

## 🎯 Частина 5: Порівняння методів

| Функція | Sideloadly | AltStore |
|---------|-----------|----------|
| Простота | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Швидкість | ⚡ Швидко | 🐢 Повільніше |
| Автооновлення | ❌ Ні | ✅ Так (Wi-Fi) |
| Потрібен ПК | Кожні 7 днів | Для оновлень |
| Додаткові функції | Базові | App Store, Delta |

**Рекомендації:**
- 🚀 **Для швидкого тесту**: Sideloadly
- 🏠 **Для постійного використання**: AltStore (якщо є домашній ПК)

---

## 🐛 Частина 6: Вирішення проблем

### ❌ "Could not find the application"

**Рішення:**
1. Переустанови iTunes (Windows)
2. Перезавантаж iPhone
3. Довіряй комп'ютеру заново

### ❌ "This app cannot be installed because its integrity could not be verified"

**Рішення:**
1. Видали старі версії Дії
2. Settings → General → iPhone Storage → DiiaApp → Delete
3. Спробуй знову

### ❌ "Maximum number of apps"

**Рішення:**
1. Видали інші sideloaded додатки
2. Ліміт: 3 додатки на безкоштовному Apple ID

### ❌ "Installation failed" в Sideloadly

**Рішення:**
1. **Advanced Options** → увімкни **Remove Plugins**
2. Спробуй інший Apple ID
3. Створи App-Specific Password:
   - [appleid.apple.com](https://appleid.apple.com)
   - Security → App-Specific Passwords
   - Використовуй його замість звичайного пароля

### ❌ "Verification failed" в AltStore

**Рішення:**
1. AltStore → Settings → Sign Out
2. Sign In заново
3. Перевір дату/час на iPhone (має бути автоматично)

---

## 💡 Частина 7: Поради та хитрощі

### 🚀 Швидке оновлення Дії

Коли вийде нова версія:

1. **Codemagic**: Білд запуститься автоматично при git push
2. **Email**: Отримаєш нову IPA на `nutipovottakvot@gmail.com`
3. **Sideloadly/AltStore**: Встанови нову версію поверх старої
   - Дані збережуться! (якщо не змінився Bundle ID)

### 📁 Збереження IPA файлів

Створи папку для версій:
```
Desktop/
  Дія IPA/
    DiiaApp_v1.0.ipa
    DiiaApp_v1.1.ipa
    DiiaApp_v1.2.ipa
```

### ⏰ Нагадування про переустановку

Встанови нагадування в Calendar:
- **Кожного понеділка** (або кожні 6 днів)
- "Переустановити Дію через Sideloadly"

### 🔔 Push нотифікації

**Увага:** Sideloaded додатки НЕ мають push notifications
- Це обмеження Apple для free Apple ID
- Потрібен платний Apple Developer для push

### 🎨 Зміна іконки (advanced)

1. Відкрий `DiiaApp.ipa` як ZIP
2. Payload/DiiaApp.app/AppIcon...png
3. Заміни зображення
4. Запакуй назад в ZIP → перейменуй в .ipa
5. Встанови через Sideloadly

---

## 📚 Частина 8: Корисні посилання

### Офіційні сайти:
- **Sideloadly**: [sideloadly.io](https://sideloadly.io)
- **AltStore**: [altstore.io](https://altstore.io)
- **Codemagic**: [codemagic.io](https://codemagic.io)

### Документація:
- [Sideloadly FAQ](https://sideloadly.io/#faq)
- [AltStore FAQ](https://altstore.io/faq/)
- [Apple Developer](https://developer.apple.com)

### Спільноти:
- [r/sideloaded](https://reddit.com/r/sideloaded) - Reddit
- [r/AltStore](https://reddit.com/r/AltStore) - Reddit

---

## ✅ Чеклист встановлення

### Підготовка:
- [ ] IPA скачано з Codemagic
- [ ] iPhone підключений до ПК (USB)
- [ ] "Trust This Computer" на iPhone
- [ ] Apple ID готовий

### Sideloadly:
- [ ] Sideloadly встановлено
- [ ] IPA вибрано в Sideloadly
- [ ] Apple ID введено
- [ ] Встановлення завершено
- [ ] Довіра розробнику налаштована

### AltStore:
- [ ] AltServer встановлено на ПК
- [ ] AltStore встановлено на iPhone
- [ ] Background Refresh увімкнений
- [ ] IPA скопійовано на iPhone
- [ ] Встановлення через AltStore завершено

---

## 🎉 Готово!

Тепер у тебе є **Дія на iPhone**! 🇺🇦

**Насолоджуйся додатком!**

### Що далі?

1. Встанови нагадування на переустановку (кожні 7 днів)
2. Слідкуй за оновленнями на GitHub
3.Ділися відгуками!

---

**Слава Україні! 🇺🇦**

