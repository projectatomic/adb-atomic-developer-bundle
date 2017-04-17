if [ $(whoami) != "root" ]; then
   echo "Try with sudo or root user"
   exit 1
fi

curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-openshift-setup/service_script/openshift --output /opt/adb/openshift
curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-openshift-setup/service_script/openshift_provision --output /opt/adb/openshift_provision
curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-openshift-setup/service_script/openshift.service --output /usr/lib/systemd/system/openshift.service
curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-openshift-setup/service_script/openshift_option --output /etc/sysconfig/openshift_option
chmod +x /opt/adb/openshift /opt/adb/openshift_provision
systemctl daemon-reload
