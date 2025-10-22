# 🚀 Інструкція: Push проекту на GitHub

## ✅ Проект готовий до завантаження!

Всі необхідні файли створено. Залишилось тільки завантажити на GitHub.

---

## 📋 Що буде завантажено

### ✅ Включено в Git:
```
✓ DiiaApp.xcodeproj/           # Xcode проект (ВАЖЛИВО!)
✓ Assets.xcassets/             # Assets
✓ codemagic.yaml               # CI/CD конфігурація
✓ ExportOptions.plist          # Параметри експорту
✓ *.swift                      # Всі Swift файли
✓ Info.plist                   # Конфігурація додатку
✓ *.md                         # Документація
✓ .gitignore                   # Git правила
```

### ❌ Виключено з Git (.gitignore):
```
✗ xcuserdata/                  # Персональні налаштування
✗ build/                       # Тимчасові файли
✗ DerivedData/                 # Кеш Xcode
✗ .DS_Store                    # macOS файли
✗ *.ipa                        # Готові IPA (будуть в Codemagic)
```

---

## 🌐 Крок 1: Створи GitHub репозиторій

### Варіант A: Через веб-інтерфейс

1. Зайди на [github.com](https://github.com)
2. Натисни **"+"** → **New repository**
3. Заповни:
   ```
   Repository name: diia-ios
   Description: 🇺🇦 Копія додатку Дія для iOS
   Visibility: Public або Private (на вибір)
   ❌ НЕ створюй README, .gitignore, license
   ```
4. Натисни **Create repository**
5. **Скопіюй URL репозиторію**, наприклад:
   ```
   https://github.com/ТВІЙ_USERNAME/diia-ios.git
   ```

### Варіант B: Через GitHub CLI (якщо встановлено)

```bash
gh repo create diia-ios --public --description "🇺🇦 Копія додатку Дія для iOS"
```

---

## 💻 Крок 2: Push код на GitHub

### На Windows (PowerShell):

```powershell
# Перевір що ти в папці проекту
cd C:\Users\nutip\OneDrive\Desktop\DiiaApp

# Ініціалізуй Git (якщо ще не зроблено)
git init

# Додай всі файли
git add .

# Подивись що буде закомічено
git status

# Створи коміт
git commit -m "Initial commit: Дія iOS готова до білду в Codemagic 🇺🇦"

# Додай remote (ЗАМІНИТИ на свій URL!)
git remote add origin https://github.com/ТВІЙ_USERNAME/diia-ios.git

# Перевір remote
git remote -v

# Push на GitHub
git branch -M main
git push -u origin main
```

### На Mac/Linux:

```bash
# Перейди в папку проекту
cd ~/Desktop/DiiaApp

# Ініціалізуй Git
git init

# Додай всі файли
git add .

# Створи коміт
git commit -m "Initial commit: Дія iOS готова до білду в Codemagic 🇺🇦"

# Додай remote (ЗАМІНИТИ на свій URL!)
git remote add origin https://github.com/ТВІЙ_USERNAME/diia-ios.git

# Push на GitHub
git branch -M main
git push -u origin main
```

---

## 🔐 Якщо просить авторизацію

### Personal Access Token (рекомендовано):

1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. **Generate new token (classic)**
3. Назва: `Diia iOS`
4. Scopes: обери `repo` (всі підпункти)
5. **Generate token**
6. **СКОПІЮЙ TOKEN** (показується один раз!)
7. При push використай token як пароль:
   ```
   Username: ТВІЙ_USERNAME
   Password: ТОКЕН_ЯКИЙ_СКОПІЮВАВ
   ```

### SSH (альтернатива):

```bash
# Згенеруй SSH ключ
ssh-keygen -t ed25519 -C "твій-email@gmail.com"

# Додай в ssh-agent
ssh-add ~/.ssh/id_ed25519

# Скопіюй публічний ключ
cat ~/.ssh/id_ed25519.pub

# Додай на GitHub:
# Settings → SSH and GPG keys → New SSH key
```

Потім використовуй SSH URL:
```bash
git remote set-url origin git@github.com:ТВІЙ_USERNAME/diia-ios.git
git push -u origin main
```

---

## ✅ Крок 3: Перевір на GitHub

Зайди на свій репозиторій на GitHub і перевір:

### ✓ Має бути видно:

```
📁 DiiaApp.xcodeproj/
📁 Assets.xcassets/
📁 Components/
📁 Managers/
📁 Models/
📁 Utilities/
📁 Views/
📄 codemagic.yaml              ← ВАЖЛИВО!
📄 DiiaApp.swift
📄 ContentView.swift
📄 Info.plist
📄 ExportOptions.plist
📄 README.md
📄 .gitignore
... та інші файли
```

### ❌ НЕ має бути:

```
✗ xcuserdata/
✗ build/
✗ DerivedData/
✗ .DS_Store
```

---

## 🎉 Готово! Що далі?

### 1. Налаштуй Codemagic

Читай: `CODEMAGIC_SETUP.md`

Коротко:
1. Зайди на [codemagic.io](https://codemagic.io)
2. Sign in with GitHub
3. Add application → вибери `diia-ios`
4. Start build!

### 2. Скачай IPA

Після білду (7-10 хв):
- Artifacts → `DiiaApp.ipa`
- Або email на nutipovottakvot@gmail.com

### 3. Встанови на iPhone

Читай: `SIDELOADLY_GUIDE.md`

Коротко:
1. Скачай [Sideloadly](https://sideloadly.io)
2. Підключи iPhone
3. Вибери IPA → Введи Apple ID → Start
4. Готово! 🇺🇦

---

## 🔄 Майбутні оновлення

Коли зміниш код:

```bash
# Додай зміни
git add .

# Коміт
git commit -m "Опис змін"

# Push
git push

# Codemagic автоматично запустить новий білд! 🚀
```

---

## 🆘 Troubleshooting

### ❌ "fatal: not a git repository"

**Рішення:**
```bash
git init
```

### ❌ "Updates were rejected"

**Рішення:**
```bash
git pull origin main --rebase
git push
```

### ❌ "Permission denied"

**Рішення:**
- Використай Personal Access Token
- Або налаштуй SSH (див. вище)

### ❌ "Large files detected"

**Рішення:**
```bash
# Подивись розміри
git ls-files -s | sort -k 4 -n -r | head -20

# Видали великі файли (якщо є)
git rm --cached path/to/large/file
git commit -m "Remove large file"
```

Файли IPA не потрібно комітити! (вони в `.gitignore`)

---

## 📊 Перевірка перед push

```bash
# Скільки файлів буде закомічено?
git status

# Що саме?
git status -s

# Які зміни?
git diff

# Перегляд .gitignore
cat .gitignore
```

---

## 💡 Корисні команди Git

```bash
# Перегляд історії
git log --oneline

# Відміна останнього коміту (перед push)
git reset --soft HEAD~1

# Відміна змін у файлі
git checkout -- файл.swift

# Перегляд remote
git remote -v

# Клонування репо на інший комп
git clone https://github.com/ТВІЙ_USERNAME/diia-ios.git
```

---

## 📝 Рекомендовані коміти в майбутньому

```bash
# Гарні приклади commit messages:

git commit -m "Add COVID certificate screen"
git commit -m "Fix Face ID authentication bug"
git commit -m "Update UI colors to match Diia 3.0"
git commit -m "Improve document card animation"
git commit -m "Add Ukrainian localization"
```

**Формат:**
- Англійською (для міжнародної спільноти)
- Коротко і зрозуміло
- Що зроблено, не як

---

## 🎯 Чеклист першого push

- [ ] GitHub репозиторій створено
- [ ] Git ініціалізовано (`git init`)
- [ ] Всі файли додано (`git add .`)
- [ ] Коміт створено (`git commit`)
- [ ] Remote додано (`git remote add origin ...`)
- [ ] Push зроблено (`git push -u origin main`)
- [ ] Файли видно на GitHub
- [ ] `codemagic.yaml` є в репо
- [ ] `.xcodeproj` є в репо

**Все готово? → Йди в Codemagic!** 🚀

---

**Slava Ukraini! 🇺🇦**

