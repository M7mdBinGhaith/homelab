# Common Tasks

## Overview
Reusable automation tasks for common ansible Operations or Software installtions. This is meant to be used as a modular component to be integrated in larger workflows. Thus reducing redundant tasks in larger workflows 

### Usage
Import tasks into other automations with:
```yaml
- name: Import common tasks
  ansible.builtin.include_tasks: ../common/task-name.yml
```

## Deployment
Tasks are imported and executed in other workflows.
