from debian
RUN apt-get update
RUN apt-get install -y ansible

ADD ./run_ansible_bootstrap.sh ./run_ansible_bootstrap.sh
ADD inventory/bootstrap.py inventory/bootstrap.py 
ADD bootstrap/000_bootstrap_yum.yml bootstrap/000_bootstrap_yum.yml
RUN ./run_ansible_bootstrap.sh bootstrap/000_bootstrap_yum.yml

ADD bootstrap/001_bootstrap_ansible.yml bootstrap/001_bootstrap_ansible.yml
RUN ./run_ansible_bootstrap.sh bootstrap/001_bootstrap_ansible.yml

ADD requirements.yml /opt/bootstrap/requirements.yml
ADD bootstrap/003_bootstrap_install_collections.yml bootstrap/003_bootstrap_install_collections.yml
RUN ./run_ansible_bootstrap.sh bootstrap/003_bootstrap_install_collections.yml

ADD bootstrap/004_bootstrap_install_roles.yml bootstrap/004_bootstrap_install_roles.yml
RUN ./run_ansible_bootstrap.sh bootstrap/004_bootstrap_install_roles.yml


ADD bootstrap/005_bootstrap_install_azure.yml bootstrap/005_bootstrap_install_azure.yml
RUN ./run_ansible_bootstrap.sh bootstrap/005_bootstrap_install_azure.yml

# now do a azure deploy
ADD site.yml site.yml
#ADD secrets/azureProfile.json /root/.azure/azureProfile.json
ADD secrets/.azure /root/.azure/
RUN ./run_ansible_bootstrap.sh site.yml
