apt-get install python3 python3-pip
# pip3 install ansible
pip3 install  -e git+https://github.com/ansible/ansible.git@v2.9.9#egg=ansible
ansible-galaxy collection install azure.azcollection --force
pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
