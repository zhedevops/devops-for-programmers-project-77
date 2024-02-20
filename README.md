### Требования:
Операционная система: Ubuntu (Linux)
#### Утилиты:
- Ansible, версия 2.16.1
- GNU Make, версия 4.3
- Terraform, версия 1.7.3

### Подготовка инфраструктуры на YandexCloud:

Зарегистрируйтесь на Terraform Cloud. Создайте проект и рабочее пространство для сохранения состояния инфраструктуры. Укажите их в backend.tf

Подготовьте переменные, запишите их в файл `terraform/secret.auto.tfvars`<br>

`yc_token` - oAuth-токен для авторизации на YandexCloud<br>
`yc_cloud_id` - идентификатор облака YandexCloud<br>
`yc_folder_id` - идентификатор каталога YandexCloud<br>
`db_name` - название БД<br>
`db_user` - пользователь БД<br>
`db_password` - пароль пользователя БД<br>
`domain` - домен для приложения<br>
`datadog_api_key` - API-ключ datadog<br>
`datadog_app_key` - ключ приложения datadog<br>

Инициализация конфигурации Terraform:
```commandline
make tf-init
```
Создание облачной инфраструктуры YandexCloud:
```commandline
make tf-apply
```
Удаление облачной инфраструктуры YandexCloud:
```commandline
make tf-destroy
```
#### Вспомогательные команды:
`make tf-reconfigure` - переинициализация конфигурации Terraform<br>
`make tf-validate` - валидация конфигурации Terraform<br>

### Запуск приложения [ghost](https://hub.docker.com/_/ghost), версия 5.79.3:
<i>(Включая агент [datadog.datadog](https://galaxy.ansible.com/ui/standalone/roles/datadog/datadog/) (DD), версия 4.22.0)</i><br>

Добавьте в `ansible/group_vars/all/vault.yml` переменные, зашифруйте файл<br>

`DB_CLIENT` - тип БД-клиента - mysql (<i>postgresql в настоящий момент в разработке</i>)<br>
`DB_HOST` - хост БД<br>
`DB_NAME` - название БД<br>
`DB_USER` - пользователь БД<br>
`DB_PASSWORD` - пароль пользователя БД<br>
`DATADOG_KEY` - API-ключ datadog

Добавьте в `ansible/group_vars/all/vars.yml` переменные<br>

`GHOST_PORT` - номер порта, на котором будет доступно приложение<br>
`GHOST_URL` - название домена или localhost<br>

Команда запуска:<br>
```commandline
make deploy
```
### Ссылка на запущенное приложение:
[ghost](http://zhedev.ru)

### Hexlet tests and linter status:
[![Actions Status](https://github.com/zhedevops/devops-for-programmers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/zhedevops/devops-for-programmers-project-77/actions)