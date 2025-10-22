# ⚡ Быстрый старт - Билд через Codemagic

## 🎯 Главная инструкция (10 минут)

### Шаг 1: Создай проект в Xcode (2 мин)

```
1. Xcode → New Project → iOS App
2. Name: DiiaApp
3. Bundle ID: com.nutipov.diia (или свой)
4. Interface: SwiftUI
5. Сохрани
```

### Шаг 2: Добавь файлы (3 мин)

```
1. Создай папки в Xcode:
   - Managers/
   - Models/
   - Views/
   - Components/
   - Utilities/

2. Перетащи .swift файлы из Desktop\DiiaApp в проект

3. Замени Info.plist

4. Проверь: ⌘B (должно собраться)
```

### Шаг 3: GitHub (2 мин)

```bash
cd DiiaApp
git init
git add .
git commit -m "Дія iOS app"

# Создай репо на github.com

git remote add origin https://github.com/ТВОЙНИК/diia-ios.git
git push -u origin main
```

### Шаг 4: Codemagic (3 мин)

```
1. codemagic.io → Sign in with GitHub
2. Add application → выбери diia-ios
3. Settings → Code signing → Automatic
4. Start build!
```

### Шаг 5: Получи IPA

```
Artifacts → скачай .ipa
Или на email: nutipovottakvot@gmail.com
```

---

## 🚨 Важные файлы

✅ `codemagic.yaml` - конфиг билда (Bundle ID: com.nutipov.diia)
✅ `ExportOptions.plist` - настройки экспорта
✅ Все .swift файлы в проекте

---

## 💡 Если что-то не так

### Bundle ID не совпадает?

1. В Xcode: Target → Signing → Bundle Identifier
2. В `codemagic.yaml`: bundle_identifier
3. Должны быть одинаковые!

### Билд падает?

1. Проверь что локально собирается (⌘B)
2. Проверь логи в Codemagic
3. Читай `CODEMAGIC_GUIDE.md` → Troubleshooting

---

## 📚 Полная документация

- `CODEMAGIC_GUIDE.md` - подробный гайд по Codemagic
- `README.md` - обзор проекта
- `FIX_BUNDLE_ID.md` - если проблемы с Bundle ID

---

Успехов! 🇺🇦

