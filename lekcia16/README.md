#МПТ - МОДУЛЬНОЕ ПРИЛОЖЕНИЕ НА DART
Предметная область
мпт

Сущности:
-назначения 
-дисциплины 
-Пользователи 
-Роли 
-Группы

Структура папок
lib/
lekcia16.dart 
src/
cli/ 
main.dart 
input_helper.dart 
data/ 
Database.dart 
repositories/ 
rep_base.dart
rep_discipline.dart
rep_enrollment.dart
rep_group.dart
rep_role.dart
rep_user.dart
domain/ 
models/ 

discipline.dart
enrollment.dart
group.dart
role.dart
user.dart
id.dart
validators/ 
datetime_validator.dart
number_validator.dart
text_validator.dart
test/
user_test.dart




Что вынесено в каждый слой и почему

1 Domain 
-Модели данных - чистые Dart-классы без зависимостей от БД или ввода/вывода
-Валидаторы - независимые правила проверки данных
-Почему: позволяет легко менять БД или интерфейс, не затрагивая бизнес-логикy

2 Data 
-Databasе - работа с SQLite, создание таблиц, внешние ключи
-Repositories - CRUD-операции, преобразование map ↔ model
-Почему: изолирует работу с БД, позволяет заменить SQLite на JSON или другую БД

3 CLI 
-Menu - навигация, вызов репозиториев
-Input helper - повторный ввод с валидацией
-Почему: отделяет пользовательский интерфейс от бизнес-логики



Валидации

Реализовано 3 типа валидации:

1 Обязательное текстовое поле (не пустая строка после trim)

2 Числовое поле > 0 

3 дата короче только в указанном типе



Перечень тестов

Тест CRUD для товаров 
-Create - добавление товара
-Read - чтение списка и по ID
-Update - обновление цены и названия
-Delete - удаление товара

Запуск тестов:
dart test