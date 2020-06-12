# Superset Deployment on aws using Ansible

This playbook installs and configures  [Superset](https://superset.incubator.apache.org/) on aws.

## Installation
1. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

2. Add aws instance ip address and user name to hosts file, 

    - [server1]
      YOUR_INSTANCE_IP ansible_user=YOUR_USER_NAME

3. Download Amazon EC2 key pairs `MY-KEY-PAIR.pem` in `KEY_PATH`

4. Change the `superset_host: 0.0.0.0, superset_port: 8088, virtualenv_path: "~"` in the yml file if needed

5. Run the playbook to install superset with `ansible-playbook  --private-key KEY_PATH/MY-KEY-PAIR.pem -i HOST_PATH/hosts --extra-vars "my_host=YOUR_INSTANCE_IP" ansible-superset-playbook/install_superset.yml`

6. Start a development web server after installation. The playbook will keep run in background `ansible-playbook  --private-key KEY_PATH/MY-KEY-PAIR.pem -i HOST_PATH/hosts --extra-vars "my_host=YOUR_INSTANCE_IP" ansible-superset-playbook/run_superset.yml`
go to `YOUR_INSTANCE_IP:superset_port` to check it.


