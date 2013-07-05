mod_passenger
=============

Passenger - Will install and configure mod_passenger for CentOS 5 or 6.  
	It will also create the passenger.conf, although no individual VHOST toggles.
	Does not work with nginx!


This formula will install mod_passenger via "gem.installed", and then create the mod_passenger Apache module.
CAVEAT: gem.installed is flaky with multiple gems installed at the same time.  Do not expect this to properly
upgrade a pre-exsiting gem due to said limitations.


Required Packaages: 
```bash
httpd
ruby
```
Required Pillar data
```yaml
apache-config:
  passenger_version: 4.0.5
rails:
  rails_environment: (staging|production|integration)
```
Optional Pillar data
```yaml
apache-config:
  passenger_version: 3.0.19
  passenger_max_requests:  500
  passenger_use_global_queue: on
  passenger_max_pool_size:  10
  passenger_max_instances:  2
```
