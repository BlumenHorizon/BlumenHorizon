#!/bin/bash

# 📋 Список веток для обновления
branches=(
    "main-athens"
    "main-madrid"
    "main-globally"
    "main-larnaca"
    "main-limassol"
    "main-paris"
    "main-monaco"
    "main-cannes"
)

# 🔍 Проверка текущей ветки
current_branch=$(git branch --show-current)
if [[ "$current_branch" != "main" ]]; then
    echo "❌ Ошибка: Вы должны находиться на ветке **main** перед запуском скрипта."
    exit 1
fi

echo "🚀 **Начинаем обновление веток**..."
echo "========================================"

# 🔄 Проходим по всем веткам и сливаем изменения
for branch in "${branches[@]}"; do
    echo "🔀 Переключение на ветку «$branch»..."
    git switch "$branch" && git merge main
    
    if [[ $? -ne 0 ]]; then
        echo ""
        echo "⚠️ Конфликты при слиянии с «$branch»!"
        echo "📝 Разрешите конфликты вручную и завершите слияние."
        echo ""
        git merge --quit
        exit 1
    fi
    
    echo "📤 Отправка изменений в удалённый репозиторий..."
    git push origin "$branch"
    
    echo "✅ Ветка «$branch» успешно обновлена!"
    echo "========================================"
    echo ""
done

# 🏠 Возвращаемся на основную ветку
git switch main

echo ""
echo "🎉 Все ветки успешно обновлены!"
echo "========================================"