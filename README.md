salt-starters
=============

Warning: All of these formulas are specific to CentOS 5/6.   

Formulas:
Passenger - Will install and configure mod_passenger for CentOS 5 or 6.  
	It will also create the passenger.conf, although no individual VHOST toggles.

This is a formula for installing mod_passenger on a CentOX 5/6 based machine.
It will NOT work on any other distro. 

This state requires the following Pillar data be available for the selected host.
If passenger_version is < 3, it'll install the latest build of passenger 3.x
apache-config:
  passenger_version: 4.0.5
rails:
  rails_environment: (staging|production|integration)
OPTIONAL PILLAR DATA:
apache-config:
  passenger_version: 3.0.19
  passenger_max_requests:  500
  passenger_use_global_queue: on
  passenger_max_pool_size:  10
  passenger_max_instances:  2


