#!/bin/bash

# Функция: создание файла или каталога
create_item() {
    read -p "Создать файл (f) или каталог (d)? " type
    read -p "Введите имя: " name
    if [[ $type == "f" ]]; then
        touch "$name" && echo "Файл '$name' создан."
    elif [[ $type == "d" ]]; then
        mkdir "$name" && echo "Каталог '$name' создан."
    else
        echo "Неверный выбор."
    fi
}

# Функция: удаление файла или каталога
delete_item() {
    read -p "Введите имя файла/каталога для удаления: " name
    if [ -e "$name" ]; then
        rm -r "$name" && echo "'$name' удалён."
    else
        echo "Файл или каталог не существует."
    fi
}

# Функция: переименование файла или каталога
rename_item() {
    read -p "Введите текущее имя: " old_name
    read -p "Введите новое имя: " new_name
    if [ -e "$old_name" ]; then
        mv "$old_name" "$new_name" && echo "Переименовано в '$new_name'."
    else
        echo "Файл или каталог не существует."
    fi
}

# Функция: перемещение файла или каталога
move_item() {
    read -p "Введите имя файла/каталога: " name
    read -p "Введите путь назначения: " destination
    if [ -e "$name" ]; then
        mv "$name" "$destination" && echo "'$name' перемещён в '$destination'."
    else
        echo "Файл или каталог не существует."
    fi
}

# Функция: изменение прав доступа
change_permissions() {
    read -p "Введите имя файла/каталога: " name
    read -p "Введите новые права (например, 755): " perms
    if [ -e "$name" ]; then
        chmod "$perms" "$name" && echo "Права доступа изменены на $perms."
    else
        echo "Файл или каталог не существует."
    fi
}

# Функция: изменение владельца/группы
change_owner() {
    read -p "Введите имя файла/каталога: " name
    read -p "Введите нового владельца (и группу, через ':', например user:group): " owner
    if [ -e "$name" ]; then
        sudo chown "$owner" "$name" && echo "Владелец изменён на $owner."
    else
        echo "Файл или каталог не существует."
    fi
}

# Функция: просмотр содержимого текущего каталога
list_directory() {
    echo "Текущий каталог: $(pwd)"
    ls -al
}

# Функция: смена каталога
change_directory() {
    read -p "Введите путь к каталогу: " path
    if [ -d "$path" ]; then
        cd "$path"
        echo "Перешли в каталог: $(pwd)"
    else
        echo "Каталог не существует."
    fi
}

# Главное меню
show_menu() {
    echo "========== МЕНЮ =========="
    echo "1. Создать файл/каталог"
    echo "2. Удалить файл/каталог"
    echo "3. Переименовать файл/каталог"
    echo "4. Переместить файл/каталог"
    echo "5. Изменить права доступа"
    echo "6. Изменить владельца/группу"
    echo "7. Показать содержимое каталога (ls)"
    echo "8. Перейти в другой каталог (cd)"
    echo "0. Выход"
    echo "=========================="
}

# Основной цикл
while true; do
    show_menu
    read -p "Выберите действие: " choice
    case $choice in
        1) create_item ;;
        2) delete_item ;;
        3) rename_item ;;
        4) move_item ;;
        5) change_permissions ;;
        6) change_owner ;;
        7) list_directory ;;
        8) change_directory ;;
        0) echo "Выход..."; break ;;
        *) echo "Неверный выбор. Повторите попытку." ;;
    esac
    echo
done
