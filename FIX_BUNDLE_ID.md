# 🔧 Исправление ошибки Bundle Identifier

## Проблема:
```
No matching profiles found for bundle identifier "com.yourteam.diia" 
and distribution type "development"
```

## ✅ Решение (2 минуты):

### Шаг 1: Открой настройки проекта

1. В Xcode слева в Project Navigator
2. Нажми на **DiiaApp** (самый верхний файл с иконкой проекта)
3. В центре убедись что выбран **TARGETS → DiiaApp**

---

### Шаг 2: Измени Bundle Identifier

1. Найди вкладку **Signing & Capabilities**
2. Найди поле **Bundle Identifier**
3. Измени с:
   ```
   com.yourteam.diia
   ```
   
   на (например):
   ```
   com.nutipov.diia
   ```
   
   Или любой другой уникальный ID вида:
   ```
   com.ТВОЕИМЯ.diia
   ```

---

### Шаг 3: Включи Automatic Signing

1. В той же вкладке **Signing & Capabilities**
2. Поставь галочку **☑ Automatically manage signing**
3. В поле **Team** выбери свой Apple ID
   - Если пусто → добавь Apple ID в Xcode
   - Xcode → Settings (⌘,) → Accounts → + → Apple ID

---

### Шаг 4: Запусти снова

1. Выбери симулятор (iPhone 15 Pro)
2. Нажми **⌘R**
3. Готово! 🎉

---

## 🔐 Если нет Apple Developer аккаунта:

Не проблема! Бесплатный Apple ID работает для разработки:

1. Используй свой обычный Apple ID
2. Bundle ID будет вида: `com.nutipov.diia`
3. Можешь запускать на симуляторе и своём iPhone
4. Ограничение: приложение работает 7 дней, потом переустанови

---

## 📱 Если хочешь на реальный iPhone:

1. Подключи iPhone к Mac
2. В Xcode выбери своё устройство вместо симулятора
3. Нажми ⌘R
4. На iPhone:
   - Settings → General → VPN & Device Management
   - Нажми на свой Apple ID
   - Trust
5. Готово! Работает 7 дней

---

## ⚠️ Частые ошибки:

### "Failed to create provisioning profile"
**Решение:**
- Проверь интернет
- Войди в Apple ID заново (Xcode → Settings → Accounts)

### "A valid provisioning profile for this executable was not found"
**Решение:**
- Product → Clean Build Folder (⌘⇧K)
- Попробуй снова

### "Unable to install..."
**Решение:**
- На iPhone удали старую версию
- Попробуй снова

---

Всё получится! Просто измени Bundle ID и запусти! 🚀

