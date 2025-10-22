# 🔧 Як змінити Bundle ID (якщо потрібно)

## ⚠️ Для Sideloadly/AltStore це НЕ потрібно!

**Sideloadly автоматично підписує IPA твоїм Apple ID**, тому Bundle ID можна залишити за замовчуванням: `com.nutipov.diia`

---

## 📝 Коли потрібно змінювати Bundle ID?

- Якщо збираєш локально в Xcode
- Якщо хочеш завантажити в App Store
- Якщо `com.nutipov.diia` вже зайнятий в твоєму Apple Developer аккаунті

---

## 🛠️ Як змінити для Codemagic білду

### Варіант 1: Змінити в codemagic.yaml (найпростіше)

```yaml
# Файл: codemagic.yaml

environment:
  vars:
    BUNDLE_ID: "com.ТВОЄ_ІМЯ.diia"  # ← Змінити тут
```

**Приклад:**
```yaml
BUNDLE_ID: "com.oleg.diia"
BUNDLE_ID: "com.ukraine.diia"
BUNDLE_ID: "ua.mycompany.diia"
```

### Варіант 2: Змінити в Xcode проекті

1. Відкрий `DiiaApp.xcodeproj` в Xcode
2. Обери target **DiiaApp**
3. Tab **Signing & Capabilities**
4. Змінити **Bundle Identifier**
5. Збережи (⌘S)
6. Закоміть:
   ```bash
   git add .
   git commit -m "Update Bundle ID"
   git push
   ```

7. Оновити в `codemagic.yaml` теж!

---

## 🎯 Формат Bundle ID

**Правильно:**
- ✅ `com.yourname.diia`
- ✅ `ua.yourcompany.diia`
- ✅ `com.example.diya`

**Неправильно:**
- ❌ `diia` (занадто коротко)
- ❌ `com.дія.app` (кирилиця)
- ❌ `com.your name.diia` (пробіли)
- ❌ `COM.Example.Diia` (великі літери)

**Формат:**
```
[reverse-domain].[app-name]
```

---

## ✅ Перевірка після зміни

1. **Codemagic:** Запусти новий білд
2. **Логи:** Шукай `Building with Bundle ID: com.yourname.diia`
3. **IPA:** Скачай і встанови через Sideloadly
4. **iPhone:** Перевір що працює

---

## 🔄 Повернути назад

```yaml
# codemagic.yaml
BUNDLE_ID: "com.nutipov.diia"  # За замовчуванням
```

```bash
git add codemagic.yaml
git commit -m "Revert Bundle ID"
git push
```

---

## 💡 Порада

**Для Sideloadly/AltStore:**  
Залиш `com.nutipov.diia` — все працюватиме ідеально! 🎉

---

**Є питання?** Пиши: nutipovottakvot@gmail.com
