#! /bin/bash
#Below put cellphone number like tel="068888888 068898989"
tel=""
#See this link to help you to format the rssfeed : http://python-rsstail.readthedocs.org/en/latest/
rsstail --nofail -n 2 --format 'Football News: {title} le {updated}' http://www.matchendirect.fr/rss/foot-ligue-1-c10.xml | grep --line-buffered "score" | while read line
do for t in $tel
        do echo -e $t
done
echo $line
done
