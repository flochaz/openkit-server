                                                                                                                                                                                                                   
ORIGINAL README : openkit-server
===============

OpenKit is currently in private beta. <a href="http://openkit.io/beta">Sign up for a beta invite here!</a>


After downloading build required gems with:
```
	$ bundle install
```


Start delayed _ job locally with:
```
	$ rake jobs:work
```

See a list of all rake-able jobs:
```
	$ bundle exec rake -T
```

Start server with:
```
	$ rails server
```


FLOCHAZ README: Openkit-server
===============

As part of the Fi-Content-2 project, the usage of openkit.io base work is evaluated. All work will be reverted to the openkit community.

CloudFoundry deployment:
------------

(03/06/2013)
The current deployment test has been done on Cloud Foundry v1

You will need a CloudFoundry account or a local installation of the CloudFoundry platform (using micro CloudFoundry VM for instance) as well as a S3 account

1. Clone repository
<pre>
$ git clone https://github.com/flochaz/openkit-server.git
</pre> 

2. Install Cloud Foundry CLI (VMC or CF)
<pre>
$ gem install vmc
$ vmc -v                                                                                                                                                                                                                           
vmc 0.5.0                               
</pre>

3. Push the app from scratch
<pre>
$ cd openkit-server
$ rm manifest.yml
$ vmc target api.cloudfoundry.com                                                                                                                                                                                                 
Setting target to https://api.cloudfoundry.com... OK                                                                                                                                                                                                                        
$ vmc login                                                                                                                                                                                                                        
target: https://api.cloudfoundry.com                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                            
Email> florianchazal@gmail.com                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                            
Password> ********                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                            
Authenticating... OK

$ vmc push                                                                                                                                                                                                                         
Name> myOwnOpenkit-server

Instances> 1

1: rails3
2: other                                                                                                                                                                                                                                                                    
Framework> rails3                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                            
1: ruby18                                                                                                                                                                                                                                                                   
2: ruby19                                                                                                                                                                                                                                                                   
3: other                                                                                                                                                                                                                                                                    
Runtime> 2                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                            
1: 64M                                                                                                                                                                                                                                                                      
2: 128M                                                                                                                                                                                                                                                                     
3: 256M                                                                                                                                                                                                                                                                     
4: 512M                                                                                                                                                                                                                                                                     
5: 1G                                                                                                                                                                                                                                                                       
Memory Limit> 256M                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                            
Creating myOwnOpenkit-server... OK                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                            
1: myOwnOpenkit-server.cloudfoundry.com                                                                                                                                                                                                                                     
2: none                                                                                                                                                                                                                                                                     
Domain> myOwnOpenkit-server.cloudfoundry.com    
Updating myOwnOpenkit-server... OK                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                            
Create services for application?> y                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                                                            
1: mongodb 2.0                                                                                                                                                                                                                                                              
2: mysql 5.1                                                                                                                                                                                                                                                                
3: postgresql 9.0                                                                                                                                                                                                                                                           
4: rabbitmq 2.4                                                                                                                                                                                                                                                             
5: redis 2.6                                                                                                                                                                                                                                                                
6: redis 2.4                                                                                                                                                                                                                                                                
7: redis 2.2                                                                                                                                                                                                                                                                
What kind?> 2                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                            
Name?> mysql-f26b8                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                            
Creating service mysql-f26b8... OK                                                                                                                                                                                                                                          
Binding mysql-f26b8 to myOwnOpenkit-server... OK                                                                                                                                                                                                                            
Create another service?> n  
Bind other services to application?> n                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                            
Save configuration?> y                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                            
Saving to manifest.yml... OK                                                                                                                                                                                                                                                
Uploading myOwnOpenkit-server... OK                                                                                                                                                                                                                                         
Starting myOwnOpenkit-server... OK                                                                                                                                                                                                                                          
Checking myOwnOpenkit-server...                                                                                                                                                                                                                                             
  0/1 instances: 1 starting                                                                                                                                                                                                                                                 
  0/1 instances: 1 starting                                                                                                                                                                                                                                                 
  0/1 instances: 1 starting                                                                                                                                                                                                                                                 
  0/1 instances: 1 starting                                                                                                                                                                                                                                                 
  0/1 instances: 1 starting                                                                                                                                                                                                                                                 
  0/1 instances: 1 starting                                                                                                                                                                                                                                                 
  0/1 instances: 1 starting                                                                                                                                                                                                                                                 
  0/1 instances: 1 starting                                                                                                                                                                                                                                                 
  0/1 instances: 1 starting                                                                                                                                                                                                                                                 
  0/1 instances: 1 starting                                                                                                                                                                                                                                                 
  1/1 instances: 1 running                                                                                                                                                                                                                                                  
OK           
</pre>

Configure S3 data storage:
<pre>
$ vmc set-env openkit-server AWS_ACCESS_KEY_ID <YOUR AWS ACCESS KEY>
$ vmc set-env openkit-server AWS_S3_BUCKET_NAME <YOUR S3 BUCKET NAME>
$ vmc set-env openkit-server AWS_SECRET_ACCESS_KEY <YOUR AWS SECRET KEY>
</pre>

Then you can access to your application at : myownopenkit-server.cloudfoundry.com

PS: You don't need to configure the mysql database because Cloud Foundry is completely integrated wirth Rails framework and is able to reconfigure automatically the connector.


Leaderboard example usage:
------------

See https://github.com/flochaz/SampleOpenkitWebClient


Release Note
------------

Flochaz Change:

- CORDS capability: In order to plug web based game running in player's browser, it is necessary to add CORDS authorization in headers (returned by OPTIONS call)
- Cloud Foundry manifest and config


License
-------
OpenKit Server
Copyright (C) 2013 OpenKit

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

A copy of the GNU Affero General Public License is included in this 
repository at AGPL-License.txt.


