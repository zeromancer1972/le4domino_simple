# le4domino_simple

This is a shell script to update Letsencrypt SSL for Domino w/o LE4D.

## Why?

I created this script to make it easier for me to update my Letsencrypt certificate on my Domino server. Unfortunately I cannot use the great [LE4D from Midpoints](https://midpoints.de/de-solutions-LE4D) to do that automatically as the server is not running FP8+ or is a 10.0.x server yet.

I followed this guide [https://blogs.gwbasics.be/blog.nsf/dx/lets-encrypt-tls-certificate-in-domino.htm](https://blogs.gwbasics.be/blog.nsf/dx/lets-encrypt-tls-certificate-in-domino.htm) and created a simple script that I have to run once the certificate is going to expire.

## Preparations

Login as root on your machine und cd to your home directory.

The script needs the Letsencrypt helper scripts to be installed on your machine. You can grab them with

```plaintext
git clone https://github.com/letsencrypt/letsencrypt
```

You have to install the kyrtool for Domino first. You can download it from Fixcentral. Follow the guide linked above.

Once you've done it just clone this repo on your machine and make the .sh file executable with

```plaintext
chmod 755 le4domino_simple/le4dom.sh
```

The folder structure should look like this:

```plaintext
/root
    /letsencrypt
    /le4domino_simple
```

You have to edit the file to fit your domain names you want to register. The first domain name also controls the name of the folder where Letsencrypt stores the `.pem` files. Change the folder names in the script accordingly.

The script also assumes that your Domino server user is called "notes".

## Performing the update

If everything is set up, stop your HTTP server of Domino as the script will spin up a temporary web server on port 80. Then execute the script with

```plaintext
sh le4domino_simple/le4dom.sh
```

## Warning

Do not run the script for testing or more than once or twice BEFORE you are sure that everything is working. If you want to test run it, then comment out line 12 and uncomment the next line. This will run the script with the

```plaintext
--test-cert 
```

parameter that prevents Letsencrypt from locking you out when you run the requests unusually often.
