# ⚡ Quick Start: Дія на iPhone за 10 хвилин

## 🎯 Мета
Отримати працюючу Дію на iPhone **без Mac**, **без Jailbreak**, **без $99/рік**.

---

## 📋 Що потрібно

✅ iPhone (iOS 15+)  
✅ Комп'ютер (Windows або Mac)  
✅ USB кабель  
✅ Безкоштовний Apple ID  
✅ 10 хвилин часу  

---

## 🚀 3 простих кроки

### Крок 1: Отримай IPA з Codemagic (7 хв)

1. **Зайди на** [codemagic.io](https://codemagic.io)
2. **Sign in with GitHub** (дозволь доступ)
3. **Add application** → вибери репозиторій `diia-ios`
4. **Start new build**
   - Workflow: `ios-diia-workflow`
   - Branch: `main`
5. **Дочекайся** (~7 хвилин) ☕
6. **Скачай** `DiiaApp.ipa` з Artifacts

✅ IPA готовий!

---

### Крок 2: Встанови Sideloadly (2 хв)

#### Windows:
1. Зайди на [sideloadly.io](https://sideloadly.io)
2. Скачай **SideloadlySetup.exe**
3. Встанови (Next → Next → Install)

#### Mac:
1. Зайди на [sideloadly.io](https://sideloadly.io)
2. Скачай **Sideloadly.dmg**
3. Перетягни в Applications

✅ Sideloadly встановлено!

---

### Крок 3: Встанови Дію на iPhone (3 хв)

1. **Підключи iPhone** до комп'ютера (USB)
2. На iPhone натисни **"Trust This Computer"**
3. **Відкрий Sideloadly**
4. **Заповни форму:**
   ```
   IPA File: [Browse...] → вибери DiiaApp.ipa
   Apple Account: твій-email@gmail.com
   Password: твій-пароль
   Device: Автоматично визначиться
   ```
5. **Натисни START**
6. Дочекайся "Done!" (1-3 хв)
7. **На iPhone:**
   - Settings → General → VPN & Device Management
   - Знайди свій email → **Trust**

✅ **Дія встановлена! Відкривай і користуйся!** 🇺🇦

---

## 🎉 Готово!

Тепер у тебе **Дія** на iPhone!

### ⚠️ Важливо знати:

- 📅 **Додаток працює 7 днів**, потім потрібно переустановити (займе 2 хвилини)
- 📲 **Максимум 3 додатки** на безкоштовному Apple ID
- 💾 **Дані збережуться** при переустановці

### 💡 Порада:
Встанов нагадування в Calendar: **"Переустановити Дію"** кожного понеділка

---

## 🔄 Переустановка через 7 днів (2 хв)

Коли додаток перестане відкриватись:

1. Підключи iPhone
2. Відкрий Sideloadly
3. Вибери той самий `DiiaApp.ipa`
4. Введи Apple ID
5. START
6. ✅ Готово!

**Дані НЕ втратяться!**

---

## 🆘 Проблеми?

### ❌ "Maximum number of apps"
**Рішення:** Видали інші sideloaded додатки (ліміт: 3)

### ❌ "Installation failed"
**Рішення:** 
1. Advanced Options → увімкни "Remove Plugins"
2. Спробуй ще раз

### ❌ Додаток не відкривається
**Рішення:** Settings → General → Device Management → Trust

---

## 📚 Більше інформації

- 📖 **Детальний гід**: [SIDELOADLY_GUIDE.md](SIDELOADLY_GUIDE.md)
- 🔧 **Налаштування Codemagic**: [CODEMAGIC_SETUP.md](CODEMAGIC_SETUP.md)
- 📄 **Повний README**: [README.md](README.md)

---

## 🌟 Альтернатива: AltStore

Хочеш **автоматичне оновлення** підпису?

1. Встанови [AltStore](https://altstore.io)
2. Автоматично оновлює через Wi-Fi
3. Не потрібно переустановлювати кожні 7 днів!

📖 Детальніше: [SIDELOADLY_GUIDE.md](SIDELOADLY_GUIDE.md) → Частина 3

---

**Насолоджуйся Дією! 🇺🇦**

Made with ❤️ for Ukraine
