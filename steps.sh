# Make sure we have all the package repos we need!
sudo yum install epel-release -y
# Set up Sensu's repository
echo '[sensu]
name=sensu
baseurl=https://repositories.sensuapp.org/yum/$releasever/$basearch/
gpgcheck=0
enabled=1' | sudo tee /etc/yum.repos.d/sensu.repo
# Get Redis installed and started
sudo yum install redis -y
sudo systemctl start redis.service
# Install Sensu itself
sudo yum install sensu -y
# Provide minimal transport configuration (used by client, server and API)
echo '{
  "transport": {
    "name": "redis"
  }
}' | sudo tee /etc/sensu/config.json
# provide minimal client configuration
echo '{
 "client": {
   "environment": "development",
   "subscriptions": [
     "dev"
   ]
 }
}' |sudo tee /etc/sensu/conf.d/client.json
sudo mkdir /etc/sensu/conf.d/{checks,handlers,mutators,filters}
# Ensure config file permissions are correct
sudo chown -R sensu:sensu /etc/sensu
# Start Sensu server, API and client services
sudo systemctl start sensu-{server,api,client}.service
# Install curl and jq helper utilities
sudo yum install curl jq -y
# Use curl to query the API, verify that the client has registered
curl -s http://127.0.0.1:4567/clients | jq .
[
  {
    "timestamp": 1458625739,
    "version": "0.29.0",
    "subscriptions": [
      "dev"
    ],
    "environment": "development",
    "address": "127.0.0.1",
    "name": "localhost.localdomain"
  }
]
# Install uchiwa dashboard
sudo yum install uchiwa -y
# Provide minimal uchiwa conifguration, pointing at API on localhost
echo '{
 "sensu": [
   {
     "name": "sensu",
     "host": "127.0.0.1",
     "port": 4567
   }
 ],
 "uchiwa": {
   "host": "0.0.0.0",
   "port": 3000
 }
}' |sudo tee /etc/sensu/uchiwa.json
# Start uchiwa service
systemctl start uchiwa.service
# Uchiwa should now be listening for http requests on port 3000
# Install nagios disk check plugin, but don't configure a check...yet
sudo yum install nagios-plugins-disk -y
# The location for the plugin above is at: /usr/lib64/nagios/plugins/check_disk