Gammu_RssTail
=============

Receive rss by sms using python-rsstail and gammu

## Requirements

1.  Debian/Ubuntu/...
2.  A cellphone who works with gammu. See list here of supported phones [here][1].
3.  [gammu][2] : Who will provide the ability to control your phone from a computer. Install it with `sudo apt-get install gammu`
4.  [rsstail][3] : the python version not [the original][4]. This tools will output to the terminal the rss. You can install it with pip : `pip install rsstail` To install pip check [this post][5] on StackOverFlow.

## Configuration

1.  First connect your phone with usb cable or bluetooth to your computer. Thanks to Mathieu L'Allemand who did [a great post][6] for the Sony K750i.

![K750i and Raspberry (credit Mathieu Lallemand)][7]

1.  Configure the phone using `gammu-config` in your terminal and set parameters who can be found on the [gammu phone database][1].
2.  To test your phone simply do an `echo "My first message" | /usb/bin/gammu --send SMS TEXT +*yournumber*` You can get all the available command of gammu [here][8].
3.  Grab your rss feeds. Like in my example the football results of the french *Ligue 1* (I did this bot for a friend who loves football). My rss in the example looks like this : <http://www.matchendirect.fr/rss/foot-ligue-1-c10.xml>.
4.  Put it in rsstail like : `rsstail http://www.matchendirect.fr/rss/foot-ligue-1-c10.xml` I have to force encoding because of the type of my rss feed who have [some problems][9] (W3C say *Your feed appears to be encoded as "UTF-8", but your server is reporting "US-ASCII"*). So for me the command is `PYTHONIOENCODING=utf8 rsstail --nofail http://www.matchendirect.fr/rss/foot-ligue-1-c10.xml` with `--nofail` to don't exit if I have errors, and `PYTHONIOENCODING` to force **utf8** encoding.
5.  We had the option to sort only the last line with `-n 1` and format it a little bit `--format 'Football News: {title}'` After we had :

>     Title: Ligue 1 : Rennes - PSG (score final : 1-3) 
>     
>     Title: Ligue 1 : Rennes - PSG en direct   
>     
>     Title: Ligue 1 : Montpellier - Saint-Etienne (score final : 0-1)  
>     
>     Title: Ligue 1 : Montpellier - Saint-Etienne en direct
>     

Now we have :

     Football News: Ligue 1 : PSG - Lille (score final : 2-2)
    

1.  But we have a problem. We want only feed with *"score"* mentioned. For that we use `grep`with the option `--line-buffered` otherwise it will doesn't work. We will have :
    
``PYTHONIOENCODING=utf8 rsstail --nofail -n 1 --format 'Football News: {title}' http://www.matchendirect.fr/rss/foot-ligue-1-c10.xml | grep --line-buffered "score"``
 

2.  We will now pipe it using a `while ... read` loop to run command on every new line.
    
```bash
while read line  
do  
command  
done
```

3.  We will modify a little bit the `gammu` command adding `-text` to specify the text submitted. The loop will look like :
    
``while read line; do /usr/bin/gammu --sendsms TEXT +*yournumber* -text "$line"; done``
 

4.  With everything together we will have this :

```bash    
user@host:~# PYTHONIOENCODING=utf8 rsstail --nofail --format 'Football News: {title}' http://www.matchendirect.fr/rss/foot-ligue-1-c10.xml | grep --line-buffered "score" | while read line; do /usr/bin/gammu --sendsms TEXT +*yournumber* -text "$line"; done
```

Enjoy !


 [1]: http://wammu.eu/phones/
 [2]: http://wammu.eu/gammu/
 [3]: http://python-rsstail.readthedocs.org/en/latest/
 [4]: http://www.vanheusden.com/rsstail/
 [5]: https://stackoverflow.com/questions/5585875/what-is-the-official-preferred-way-to-install-pip-and-virtualenv-systemwide
 [6]: http://translate.google.com/translate?sl=fr&tl=en&js=n&prev=_t&hl=en&ie=UTF-8&u=http://mathieu-lallemand.blogspot.fr/2013/06/envoyer-des-sms-avec-un-raspberry-pi.html&act=url
 [7]: http://4.bp.blogspot.com/-GQahF4-wXjY/Uamx6QF9CfI/AAAAAAAAISw/1uvb7Mhnuuw/s320/IMG_20130601_102316.jpg
 [8]: http://wammu.eu/docs/manual/gammu/
 [9]: http://validator.w3.org/feed/check.cgi?url=http://www.matchendirect.fr/rss/foot-ligue-1-c10.xml
 [10]: https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet