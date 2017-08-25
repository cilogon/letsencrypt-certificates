# letsencrypt-certificates
You get user certificates from [CILogon](https://cilogon.org/) but you also need host certificates.
You looked over the list of [IGTF](https://igtf.net) CAs but they don't meet your needs.
Why not use the [Let's Encrypt CA](https://letsencrypt.org/)?
How do you set up `/etc/grid-security` for the Let's Encrypt CA?

## Getting your host certificate
Follow the Let's Encrypt [Getting Started](https://letsencrypt.org/getting-started/) guide.

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
make
sudo make install
```

## Caveats
Like other Internet CAs and unlike IGTF CAs, Let's Encrypt issues end entity certificates with subject DNs outside a controlled namespace (i.e., `"/CN=*"`), so the signing_policy file is not enforcing a strong namespace restriction.

Let's Encrypt does not issue CRLs for end-entity certificates (see the [Certification Practice Statement](http://cps.root-x1.letsencrypt.org)).

Make sure to have a process in place to renew your certificates (e.g., [Certbot](https://certbot.eff.org/)).
