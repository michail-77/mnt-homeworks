# Домашнее задание к занятию 10 «Jenkins»

## Подготовка к выполнению

1. Создать два VM: для jenkins-master и jenkins-agent.
![1](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/вирт.машины.png)

2. Установить Jenkins при помощи playbook.
![2](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/установка%20jenkins.png)

3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.
![3](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/узлы.png)

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
![4](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/freestyle.png)
![5](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/freestyle2.png)

2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
![6](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/DeclarativePipelineJob.png)

3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
![7](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/jenkinsfile.png)

4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.
![8](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/multybranch.png)
![9](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/multybranch2.png)

5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
![10](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/script.jpg)

6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
![11](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/без%20флагов.jpg)
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
![12](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/09-ci-04-jenkins/image/scripted.png)
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.  
[Vector-role](https://github.com/michail-77/vector-role-molecule/tree/main)  
[Declarative_Pipeline](https://github.com/michail-77/vector-role-molecule/blob/main/Jenkinsfile)  
[Scripted_Pipeline](https://github.com/michail-77/vector-role-molecule/blob/main/ScriptedJenkinsfile)  

9. Сопроводите процесс настройки скриншотами для каждого пункта задания!!

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
