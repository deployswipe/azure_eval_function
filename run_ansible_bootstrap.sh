echo going to do $*
ansible-playbook -i inventory/bootstrap.py  $* -vvvv
