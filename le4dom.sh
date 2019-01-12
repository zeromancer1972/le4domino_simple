#!/bin/sh

echo "*** REMOVING OLD STUFF ***"

rm /etc/letsencrypt/archive/* -r
rm /etc/letsencrypt/live/* -r
rm /etc/letsencrypt/renewal/*

echo "*** CATCHING CERTS ***"

cd letsencrypt

# replace the -d option with your domain(s)

../letsencrypt/letsencrypt-auto certonly --register-unsafely-without-email --standalone -d notesx.net,www.notesx.net,aveedo.notesx.net,oliverbusse.notesx.net,bookmarks.notesx.net
# ../letsencrypt/letsencrypt-auto certonly --test-cert --register-unsafely-without-email --standalone -d notesx.net,www.notesx.net,aveedo.notesx.net,oliverbusse.notesx.net,bookmarks.notesx.net

echo "*** COPYING... ***"

# replace the last folder name with the first domain name you used above

cp /etc/letsencrypt/archive/notesx.net/* /tmp
chmod 777 /tmp/*.pem

echo "*** IMPORTING KEYS ***"

sudo -H -u notes bash -c '/opt/ibm/domino/bin/tools/startup kyrtool =/local/notesdata/notes.ini import roots -k /local/notesdata/keystore2.kyr -i /tmp/fullchain1.pem'
sudo -H -u notes bash -c '/opt/ibm/domino/bin/tools/startup kyrtool =/local/notesdata/notes.ini import keys -k /local/notesdata/keystore2.kyr -i /tmp/privkey1.pem'
sudo -H -u notes bash -c '/opt/ibm/domino/bin/tools/startup kyrtool =/local/notesdata/notes.ini import certs -k /local/notesdata/keystore2.kyr -i /tmp/cert1.pem'

echo "*** DONE. ***"

