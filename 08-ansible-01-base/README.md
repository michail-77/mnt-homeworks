# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
```
[user@localhost playbook]$ ansible --version
ansible [core 2.11.12] 

```

2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.

### Ответ:
```
[user@localhost playbook]$ ansible-playbook -i inventory/test.yml site.yml
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with 
Ansible 2.12. Current version: 3.6.8 (default, Jun 26 2023, 20:26:30) [GCC 8.5.0 20210514 (Red Hat 
8.5.0-20)]. This feature will be removed from ansible-core in version 2.12. Deprecation warnings 
can be disabled by setting deprecation_warnings=False in ansible.cfg.
/home/user/.local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature

PLAY [Print os facts] ******************************************************************************

TASK [Gathering Facts] *****************************************************************************
ok: [localhost]

TASK [Print OS] ************************************************************************************
ok: [localhost] => {
    "msg": "CentOS"
}

TASK [Print fact] **********************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *****************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.

### Ответ:
```
TASK [Print fact] **********************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

```

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

### Ответ:
```
[user@localhost playbook]$ docker ps
CONTAINER ID   IMAGE      COMMAND       CREATED          STATUS          PORTS     NAMES
dfeb7a798560   ubuntu     "/bin/bash"   55 seconds ago   Up 54 seconds             ubuntu
2258513f458c   centos:7   "/bin/bash"   3 minutes ago    Up 3 minutes              centos7
[user@localhost playbook]$ 
```

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

### Ответ:
```
[user@localhost playbook]$ ansible-playbook -i inventory/prod.yml site.yml
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. 
Current version: 3.6.8 (default, Jun 26 2023, 20:26:30) [GCC 8.5.0 20210514 (Red Hat 8.5.0-20)]. This feature 
will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting 
deprecation_warnings=False in ansible.cfg.
/home/user/.local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature

PLAY [Print os facts] ******************************************************************************************

TASK [Gathering Facts] *****************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP *****************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


```

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.

### Ответ:
```
Добавляем факты в group_vars.
```

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

### Ответ:
```
[user@localhost playbook]$ ansible-playbook -i inventory/prod.yml site.yml
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. 
Current version: 3.6.8 (default, Jun 26 2023, 20:26:30) [GCC 8.5.0 20210514 (Red Hat 8.5.0-20)]. This feature 
will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting 
deprecation_warnings=False in ansible.cfg.
/home/user/.local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature

PLAY [Print os facts] ******************************************************************************************

TASK [Gathering Facts] *****************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *****************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

### Ответ:
```
[user@localhost playbook]$ ansible-vault encrypt group_vars/deb/examp.yml
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. 
Current version: 3.6.8 (default, Jun 26 2023, 20:26:30) [GCC 8.5.0 20210514 (Red Hat 8.5.0-20)]. This feature 
will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting 
deprecation_warnings=False in ansible.cfg.
/home/user/.local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
New Vault password: 
Confirm New Vault password: 
Encryption successful
[user@localhost playbook]$ ansible-vault encrypt group_vars/el/examp.yml
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. 
Current version: 3.6.8 (default, Jun 26 2023, 20:26:30) [GCC 8.5.0 20210514 (Red Hat 8.5.0-20)]. This feature 
will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting 
deprecation_warnings=False in ansible.cfg.
/home/user/.local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
New Vault password: 
Confirm New Vault password: 
Encryption successful

```

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

### Ответ:
```
[user@localhost playbook]$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. 
Current version: 3.6.8 (default, Jun 26 2023, 20:26:30) [GCC 8.5.0 20210514 (Red Hat 8.5.0-20)]. This feature 
will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting 
deprecation_warnings=False in ansible.cfg.
/home/user/.local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
Vault password: 

PLAY [Print os facts] ******************************************************************************************

TASK [Gathering Facts] *****************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *****************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

### Ответ:
```
[user@localhost playbook]$ ansible-doc -t connection -l
local    execute on controller 
```

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

### Ответ:
prod.yml
```
 el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  loc:
    hosts:
      localhost:
        ansible_connection: local
```

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

### Ответ:
```
[user@localhost playbook]$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. 
Current version: 3.6.8 (default, Jun 26 2023, 20:26:30) [GCC 8.5.0 20210514 (Red Hat 8.5.0-20)]. This feature 
will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting 
deprecation_warnings=False in ansible.cfg.
/home/user/.local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
Vault password: 

PLAY [Print os facts] ******************************************************************************************

TASK [Gathering Facts] *****************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ************************************************************************************************
ok: [localhost] => {
    "msg": "CentOS"
}
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **********************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *****************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.


## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.

### Ответ:
```
[user@localhost playbook]$ ansible-vault decrypt group_vars/deb/examp.yml
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. 
Current version: 3.6.8 (default, Jun 26 2023, 20:26:30) [GCC 8.5.0 20210514 (Red Hat 8.5.0-20)]. This feature 
will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting 
deprecation_warnings=False in ansible.cfg.
/home/user/.local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
Vault password: 
Decryption successful
[user@localhost playbook]$ ansible-vault decrypt group_vars/el/examp.yml
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. 
Current version: 3.6.8 (default, Jun 26 2023, 20:26:30) [GCC 8.5.0 20210514 (Red Hat 8.5.0-20)]. This feature 
will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting 
deprecation_warnings=False in ansible.cfg.
/home/user/.local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
Vault password: 
Decryption successful

```

2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
