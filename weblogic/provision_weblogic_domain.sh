#!/bin/sh -x

# wait_for(string, file): wait for string to appear in file with timeout
wait_for() {
    res=$(fgrep -c -s "$1" "$2")
    count=60
    while [[ ! $res -gt 0 ]] && [[ $count -gt 0 ]]; do
        sleep 1
        count=$(($count - 1))
        res=$(fgrep -c -s "$1" "$2")
    done
}

# wlst(script, arg, ...): execute wlst script 
wlst() {
    script=$1
    shift
    sudo -i -u oracle ${ORACLE_HOME}/oracle_common/common/bin/wlst.sh \
        ${script} $*
}

# Create Oracle user/group
groupadd -g 54321 oinstall
adduser -m -c "Oracle" -g oinstall -r oracle

# Add vagrant user to Oracle group
usermod -a -G oinstall vagrant

# Add alias for quick sudo to oracle user
echo 'alias so="sudo -i -u oracle"' >> /home/vagrant/.bashrc

# Source Oracle environment settings
source /vagrant/weblogic/environment.sh

# Create Oracle installation directories
mkdir -p ${ORACLE_HOME}
mkdir -p ${DOMAIN_HOME}
mkdir -p ${ORACLE_BASE}/config/applications
chown -R oracle:oinstall /u01
chmod -R 775 /u01

# Setup Oracle environment settings for user oracle
cat /vagrant/weblogic/environment.sh >> /home/oracle/.bashrc

# Add alias for wlst tool for user oracle
echo "alias wlst=\${ORACLE_HOME}/oracle_common/common/bin/wlst.sh" \
    >> /home/oracle/.bashrc

# Run Weblogic Quick Installer (installs Weblogic in dev mode)
sudo -i -u oracle java -jar /vagrant/weblogic/fmw_12.2.1.2.0_wls_quick.jar \
    ORACLE_HOME=${ORACLE_HOME}

# Create domain
admin_user="weblogic"
admin_password="welcome01"
wlst /vagrant/weblogic/wlst/create_domain.py \
    "${admin_user}" "${admin_password}" "${DOMAIN_HOME}"

# Create shortcut link to domain from oracle home-dir
sudo -i -u oracle ln -s "${DOMAIN_HOME}"

# Create upstart jobs for managing servers
sed -e "s|@DOMAIN_HOME|${DOMAIN_HOME}|" \
    /vagrant/weblogic/init/nodemanager.conf > /etc/init/nodemanager.conf
sed -e "s|@DOMAIN_HOME|${DOMAIN_HOME}|" \
    /vagrant/weblogic/init/adminserver.conf > /etc/init/adminserver.conf
initctl reload-configuration

# Start AdminServer
start nodemanager
start adminserver

# Wait for AdminServer to start
wait_for "Server state changed to RUNNING" \
    "${DOMAIN_HOME}/servers/AdminServer/logs/AdminServer.log"

# Store user config for online wlst scripting
admin_url="t3://localhost:7001"
wlst /vagrant/weblogic/wlst/store_user_config.py \
    "${admin_user}" "${admin_password}" "${admin_url}"
