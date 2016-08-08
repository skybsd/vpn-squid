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

The operative line in squid.conf that controls the settings for splash page redirection is: 
external_acl_type splash_page ipv4 ttl=5 concurrency=100 %SRC /usr/lib/squid3/ext_session_acl -T 30 -b /var/lib/squid3/session 

Where: -
ttl = The amount of seconds the splash page will be displayed 
-T = Overall amount of time in seconds before squid resets the user session in the database 

After the splash page is displayed to a user for TTL seconds, it is the responsibility of the browser to refresh 
the page to allow the user to continue to their original destination URL. This browser refresh is executed via 
an automated trigger within the splash page with no user action required by the following HTML meta refresh method: 

<META HTTP-EQUIV="refresh" CONTENT="6"> 

Where CONTENT="6" refers to the length of time in seconds to wait before instructing the client browser to refresh 
the page, which automatically directs the browser back to the original URL the end user initially wanted to browse 
to. 

Squid proxy splash page redirection requirements and tuning is explained in greater detail here: 
http://wiki.squid-cache.org/ConfigExamples/Portal/Splash


