bash
#!/bin/bash

# Проверяем, была ли предоставлена папка в качестве аргумента
if [ $# -eq 0 ]; then
    echo "Ошибка: не указана целевая папка"
    exit 1
fi

target_directory="$1"

# Проверяем существование целевой папки
if [ ! -d "$target_directory" ]; then
    echo "Ошибка: указанная целевая папка не существует"
    exit 1
fi

# Переходим в целевую папку
cd "$target_directory" || exit 1

# Получаем список файлов в папке
file_list=$(find . -maxdepth 1 -type f)

# Цикл по каждому файлу
for file in $file_list; do
    owner=$(stat -c %U "$file")  # Получаем владельца файла
    if [ ! -d "$owner" ]; then
        mkdir "$owner"  # Создаем папку, если она еще не существует
    fi
    dest_dir="$target_directory/$owner"
    cp --preserve=all "$file" "$dest_dir"  # Копируем файл в папку владельца
    echo "Файл $file скопирован в папку $dest_dir"
done

echo "Копирование завершено"