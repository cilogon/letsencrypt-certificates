# letsencrypt-certificates
You get user certificates from [CILogon](https://cilogon.org/) but you also need host certificates.
You looked over the list of [IGTF](https://igtf.net) CAs but they don't meet your needs.
Why not use the [Let's Encrypt CA](https://letsencrypt.org/)?
How do you set up `/etc/grid-security`?

## Getting your host certificate
Follow the Let's Encrypt [Getting Started](https://letsencrypt.org/getting-started/) guide.

For example:
```
git clone https://github.com/letsencrypt/letsencrypt
cd letsencrypt/
./letsencrypt-auto --debug certonly --standalone --email human@example.org -d example.org
# cert in /etc/letsencrypt
# then before it expires...
./letsencrypt-auto renew
```

## Setting up /etc/grid-security/host*.pem
```
ln -s /etc/letsencrypt/live/*/cert.pem /etc/grid-security/hostcert.pem
ln -s /etc/letsencrypt/live/*/privkey.pem /etc/grid-security/hostkey.pem
chmod 0600 /etc/letsencrypt/archive/*/privkey*.pem # ugh!
```

## Setting up /etc/grid-security/certificates
```
git clone https://github.com/cilogon/letsencrypt-certificates.git
cd letsencrypt-certificates/
make check
sudo make install
```

## Caveats
Like other Internet CAs and unlike IGTF CAs, Let's Encrypt issues end entity certificates with subject DNs outside a controlled namespace (i.e., `"/CN=*"`), so the signing_policy file is not enforcing a strong namespace restriction.

Let's Encrypt does not issue CRLs for end-entity certificates (see the [Certification Practice Statement](http://cps.root-x1.letsencrypt.org)).

Make sure to have a process in place to renew your certificates (e.g., [Certbot](https://certbot.eff.org/)).

## Troubleshooting

```
# hostname
example.org
# grid-proxy-init -debug -verify -cert /etc/grid-security/hostcert.pem -key /etc/grid-security/hostkey.pem -hours 1 -out /tmp/hostcerttest
 
User Cert File: /etc/grid-security/hostcert.pem
User Key File: /etc/grid-security/hostkey.pem
 
Trusted CA Cert Dir: /etc/grid-security/certificates
 
Output File: /tmp/hostcerttest
Your identity: /CN=example.org
Creating proxy ......++++++
.....++++++
Done
Proxy Verify OK
# openssl verify -CApath /etc/grid-security/certificates /etc/grid-security/hostcert.pem 
/etc/grid-security/hostcert.pem: OK
# if [ "`openssl x509 -in /etc/grid-security/hostcert.pem -noout -modulus`" = "`openssl rsa -in /etc/grid-security/hostkey.pem -noout -modulus`" ]; then echo "Match"; else echo "Different"; fi
Match
# openssl x509 -subject -noout -in /etc/grid-security/hostcert.pem 
subject= /CN=example.org
```
