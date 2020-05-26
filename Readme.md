pip install ansible
export ANSIBLE_KEEP_REMOTE_FILES=1
ansible-playbook site.yml -vvvv
func new
5
ansible_azure_rm_functionapp
 
cd ansible_azure_rm_functionapp/
func init

#ansible-galaxy install azure.azure_preview_modules
pip3.5 install  -e git+https://github.com/ansible/ansible.git@v2.9.9#egg=ansible
pip3.5 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
ansible-galaxy collection install azure.azcollection --force