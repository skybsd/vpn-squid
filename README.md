VPN-SQUID Summary 

Description 
vpn-squid is a transparent squid proxy container used to temporarily redirect 
SMI's Non-proxy vpn users to a temporary splash page that instructs them to upgrade 


Design 
vpn-squid is a docker container derived from a third-party base docker container that implements a squid proxy server 
as a container that runs within the network space of our vpn-strongswan container. 

It is further modified to redirect only http (tcp/80) traffic sent by vpn end users using Mobile Safari on iPhones and iPads

The base docker container is called squid-in-a-can - source: https://github.com/jpetazzo/squid-in-a-can 

SMI modifies squid-in-a-can via our config files that are parse via a Dockerfile. 


Configuration 
squid.conf
We use a customised squid.conf that is configured for transparent redirection of Mobile Safari traffic over http to 
our splash page hosted within the container itself. 

Squid proxy splash page redirection requirements and tuning is explained in greater detail here: 
http://wiki.squid-cache.org/ConfigExamples/Portal/Splash


