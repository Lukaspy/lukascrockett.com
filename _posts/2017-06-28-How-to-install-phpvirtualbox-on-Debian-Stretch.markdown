---
layout: post
title:  "How to install phpvirtualbox on Debian 9.0 (Stretch)"
date: 2017-06-28
---

Phpvirtualbox is a web applicaton that allows you to manage Oracle's Virtualbox VMs. Although Phpvirtual box is currently (As of 28-06-2017) 
a verion behind Virtualbox development, a simple workaround can be applied. 

First we need to install Apache and PHP (Plus its components.) in order to serve Phpvirtualbox:
{% highlight shell %}
sudo apt-get update
sudo apt-get install apache2 php php-xml php-soap 
{% endhighlight %}

Next we can install the latest version of virtualbox from Oracle's debian repositories:
{% highlight shell %}
#Add virtual box to sources.list.d
sudo vim /etc/apt/sources.list.d/virtualbox.list
#Inside add the offical Oracle repos
deb http://download.virtualbox.org/virtualbox/debian stretch contrib
{% endhighlight %}

Then we add the Virtualbox pub key
{% highlight shell %}
#Download key
curl -O https://www.virtualbox.org/download/oracle_vbox_2016.asc
#Add key to apt
sudo apt-key add oracle_vbox_2016.asc
{% endhighlight %}

Now we are able to install Virtualbox
{% highlight shell %}
sudo apt-get update
sudo apt-get install virtualbox-5.1
{% endhighlight %}

In order to use the built in rdp client, usb 2&3, plus some other features, we need to install the [Virtualbox Extension Pack](https://www.virtualbox.org/wiki/Downloads)
{% highlight shell %}
#You use wget to download the pack (After obtaining the most recent version's link)
cd /tmp
wget http://download.virtualbox.org/virtualbox/5.1.22/Oracle_VM_VirtualBox_Extension_Pack-5.1.22-115126.vbox-extpack
#Now we can intstall the pack with vboxmanage
vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.1.22-115126.vbox-extpack
{% endhighlight %}

In order to allow phpvirtualbox the ability to access the vboxwebserver, we need to create a user that belongs to the vboxusers group.
{% highlight shell %}
#Add user named 'vbox' whose primary group is vboxusers
useradd -d /home/vbox -m -g vboxusers -s /bin/bash vbox
#Give user 'vbox' a password
passwd vbox
{% endhighlight %}

Phpvirtualbox uses a service called vboxwebsrv provided by Virtualbox to manage all the aspects of a VM. This service is not enabled by default, so we need to 
make it start at boot
{% highlight shell %}
#Create an entry in init.d that starts the vboxwebsrv
sudo vim /etc/init.d/vboxweb
#Inside the file add the following:
#!/bin/bash
sudo -u vbox  vboxwebsrv &
{% endhighlight %}
The file should look like this:
![/etc/init.d/vboxweb]({{site.url}}/assets/img/posts/2017-06-28/screenshot1.jpg)
Now we need to enable the execute bit and tell init to run the file at boot
{% highlight shell %}
sudo chmod +x /etc/init.d/vboxweb
sudo update-rc.d vboxweb defaults
{% endhighlight %}

The Virtualbox internals are now finished! We can proceed to the phpvirualbox setup.
{% highlight shell %}
#Download the newest version of phpvirtualbox
cd /tmp
wget http://sourceforge.net/projects/phpvirtualbox/files/latest/download -O phpvirtualbox.zip
unzip phpvirtualbox.zip -d /var/www/html/phpvirtualbox
{% endhighlight %}

We need to tell phpvirtualbox which user to run as, in this case we will use the user we created earlier 'vbox'
{% highlight shell %}
sudo mv /var/www/html/phpvirtualbox/config.php-example /var/www/html/phpvirtualbox/config.php
#In the config.php file change the '$username' and '$password' values to that of the vbox user
sudo vim /var/www/html/phpvirtualbox/config.php
{% endhighlight %}
This is what the file should look like once you are done:
![/var/www/html/phpvirtualbox/config.php]({{site.url}}/assets/img/posts/2017-06-28/screenshot2.jpg)

When installing phpvirtualbox I generally change apache's default document root to /var/www/html/phpvirtualbox, but this is a matter of preference, if you wish
to do so, run the following commands.
{% highlight shell %}
sudo vim /etc/apache2/sites-available/000-default.conf
#Then change the doc root from /var/www/html to /var/www/html/phpvirtualbox by editing the 'DocumentRoot' line
{% endhighlight %}
![/etc/apache2/sites-available/000-default.conf]({{site.url}}/assets/img/posts/2017-06-28/screenshot3.jpg)

At this point you could reboot and point your browser to your server, but you would get a version missmatch error, in order to rectify this, you must apply a
workaround
{% highlight shell %}
cd /var/www/html/phpvirtualbox/endpoints/lib/
sudo vim config.php
#You must comment out the 'define('PHPVBOX_VER', '5.0-5');' line and add 'define('PHPVBOX_VER', '5.1-0');'
{% endhighlight %}
![/var/www/html/phpvirtualbox/endpoints/lib/config.php]({{site.url}}/assets/img/posts/2017-06-28/screenshot4.jpg)
Then add a symbolic link to the following files.
{% highlight shell %}
sudo ln -s /var/www/html/phpvirtualbox/endpoints/lib/vboxweb-5.0.wsdl/var/www/html/phpvirtualbox/endpoints/lib/vboxweb-5.1.wsdl
sudo ln -s /var/www/html/phpvirutalbox/endpoints/lib/vboxwebService-5.0.wsdl /var/www/html/phpvirtualbox/endpoints/lib/vboxwebService-5.1.wsdl
{% endhighlight %}

After running the last commands and rebooting, you should be able to access the phpvirtualbox interface at the server's ip or domain name.
Congratulations! You now have a working phpvirtualbox install!
![phpvirtualbox]({{site.url}}/assets/img/posts/2017-06-28/screenshot5.png)

