# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.


### Ответ: 
Подготавливаем inventory-файл [`prod.yml`](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/08-ansible-02-playbook/playbook/inventory/prod.yml) 

2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2.

### Ответ: 
Дописал: [vars.yml](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/08-ansible-02-playbook/playbook/group_vars/clickhouse/vars.yml) и [site.ym](https://github.com/michail-77/mnt-homeworks/blob/MNT-video/08-ansible-02-playbook/playbook/site.yml)

3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.

### Ответ: 
При выполнении Tasks скачался vector 0.31.0 и установился на удаленной машине.
```yaml
[root@b47fbf673666 ~]# vector --version
vector 0.31.0 (x86_64-unknown-linux-gnu 0f13b22 2023-07-06 13:52:34.591204470)
```
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

### Ответ: 
Ошибки:
```yaml
[root@centos8 playbook]# ansible-lint site.yml
WARNING  Listing 6 violation(s) that are fatal
name[missing]: All tasks should be named.
site.yml:11 Task/Handler: block/always/rescue 

risky-file-permissions: File permissions unset or incorrect.
site.yml:12 Task/Handler: Get clickhouse distrib

risky-file-permissions: File permissions unset or incorrect.
site.yml:18 Task/Handler: Get clickhouse distrib

fqcn[action-core]: Use FQCN for builtin module actions (meta).
site.yml:30 Use `ansible.builtin.meta` or `ansible.legacy.meta` instead.

jinja[spacing]: Jinja2 spacing could be improved: create_db.rc != 0 and create_db.rc !=82 -> create_db.rc != 0 and create_db.rc != 82 (warning)
site.yml:32 Jinja2 template rewrite recommendation: `create_db.rc != 0 and create_db.rc != 82`.

yaml[new-line-at-end-of-file]: No new line character at the end of file
site.yml:59

Read documentation for instructions on how to ignore specific rule violations.

                       Rule Violation Summary                        
 count tag                           profile    rule associated tags 
     1 jinja[spacing]                basic      formatting (warning) 
     1 name[missing]                 basic      idiom                
     1 yaml[new-line-at-end-of-file] basic      formatting, yaml     
     2 risky-file-permissions        safety     unpredictability     
     1 fqcn[action-core]             production formatting           

Failed: 5 failure(s), 1 warning(s) on 1 files. Last profile that met the validation criteria was 'min'.
```
Исправил ошибки:
```yaml
[user@centos8 playbook]$ ansible-lint site.yml

Passed: 0 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'production'.
```

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.

### Ответ: 
Запускаем playbook с флагом --check:

```yaml
[user@centos8 playbook]$ ansible-playbook -u root -i inventory/prod.yml site.yml --check --ask-pass
SSH password: 

PLAY [Install Clickhouse] **************************************************************************

TASK [Gathering Facts] *****************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Get clickhouse distrib] **********************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib (rescue)] *************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Install clickhouse packages] *****************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Flush handlers to restart clickhouse] ********************************************************

TASK [Create database] *****************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
skipping: [clickhouse-01]

PLAY [Install vector] ******************************************************************************

TASK [Gathering Facts] *****************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Get vector distrib] **************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Install vector packages] *********************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Flush handlers to restart vector] ************************************************************

PLAY RECAP *****************************************************************************************
clickhouse-01              : ok=6    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0   
```

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

### Ответ: 
Запускаем playbook с флагом --diff:
```yaml
[user@centos8 playbook]$ ansible-playbook -u root -i inventory/prod.yml site.yml --diff --ask-pass
SSH password: 

PLAY [Install Clickhouse] **************************************************************************

TASK [Gathering Facts] *****************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Get clickhouse distrib] **********************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib (rescue)] *************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Install clickhouse packages] *****************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Flush handlers to restart clickhouse] ********************************************************

TASK [Create database] *****************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

PLAY [Install vector] ******************************************************************************

TASK [Gathering Facts] *****************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Get vector distrib] **************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Install vector packages] *********************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Flush handlers to restart vector] ************************************************************

PLAY RECAP *****************************************************************************************
clickhouse-01              : ok=7    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
```

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

### Ответ: 
Еще раз запускаем playbook с флагом --diff:
Playbook идемпотентен.
```yaml
[user@centos8 playbook]$ ansible-playbook -u root -i inventory/prod.yml site.yml --diff --ask-pass
SSH password: 

PLAY [Install Clickhouse] **************************************************************************

TASK [Gathering Facts] *****************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Get clickhouse distrib] **********************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib (rescue)] *************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Install clickhouse packages] *****************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Flush handlers to restart clickhouse] ********************************************************

TASK [Create database] *****************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

PLAY [Install vector] ******************************************************************************

TASK [Gathering Facts] *****************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Get vector distrib] **************************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Install vector packages] *********************************************************************
[WARNING]: sftp transfer mechanism failed on [172.17.0.2]. Use ANSIBLE_DEBUG=1 to see detailed
information
ok: [clickhouse-01]

TASK [Flush handlers to restart vector] ************************************************************

PLAY RECAP *****************************************************************************************
clickhouse-01              : ok=7    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
```

9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook).
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
