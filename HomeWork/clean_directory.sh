bash
#!/bin/bash

dir_path=$1

# Проверяем существование директории
if [ -d "$dir_path" ]; then
    echo "Найдена директория: $dir_path"
    # Удаление файлов с расширением .bak, .tmp, .backup
    find "$dir_path" -type f \( -name '.bak' -o -name '.tmp' -o -name '*.backup' \) -delete

    echo "Файлы .bak, .tmp, .backup успешно удалены из директории: $dir_path"
else
    echo "Директория $dir_path не существует"