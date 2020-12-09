sources = isrgrootx1.signing_policy \
          letsencryptauthorityx3.signing_policy \
          letsencryptauthorityx4.signing_policy \
	  lets-encrypt-r3.signing_policy \
	  lets-encrypt-r4.signing_policy \

targets = 23c2f850.signing_policy 4042bcee.signing_policy \
          4a0a35c0.signing_policy 4f06f81d.signing_policy \
          6187b673.signing_policy 929e297e.signing_policy \
	  8d33f237.signing_policy dec71a0b.signing_policy \
	  9f194ecd.signing_policy dd7d39a7.signing_policy \
          23c2f850.0 4042bcee.0 4a0a35c0.0 4f06f81d.0 6187b673.0 8d33f237.0 929e297e.0 9f194ecd.0 dec71a0b.0 dd7d39a7.0 \
          isrgrootx1.pem \
          letsencryptauthorityx3.pem letsencryptauthorityx4.pem \
	  lets-encrypt-r3.pem lets-encrypt-r4.pem

installfiles = $(targets) $(sources)

installdir = /etc/grid-security/certificates

GET = curl -O
INSTALL = install
LINK = ln -s

all : $(targets)

install : all
	$(INSTALL) $(installfiles) $(DESTDIR)$(installdir)

clean :
	$(RM) *.0 *.signing_policy *.pem

check : all
	openssl verify -CApath . letsencryptauthorityx3.pem
	openssl verify -CApath . letsencryptauthorityx4.pem

23c2f850.signing_policy : letsencryptauthorityx4.signing_policy
	$(LINK) letsencryptauthorityx4.signing_policy 23c2f850.signing_policy
4042bcee.signing_policy : isrgrootx1.signing_policy
	$(LINK) isrgrootx1.signing_policy 4042bcee.signing_policy
4a0a35c0.signing_policy : letsencryptauthorityx3.signing_policy
	$(LINK) letsencryptauthorityx3.signing_policy 4a0a35c0.signing_policy
4f06f81d.signing_policy : letsencryptauthorityx3.signing_policy
	$(LINK) letsencryptauthorityx3.signing_policy 4f06f81d.signing_policy
6187b673.signing_policy : isrgrootx1.signing_policy
	$(LINK) isrgrootx1.signing_policy 6187b673.signing_policy
8d33f237.signing_policy : lets-encrypt-r3.signing_policy
	$(LINK) lets-encrypt-r3.signing_policy 8d33f237.signing_policy
929e297e.signing_policy : letsencryptauthorityx4.signing_policy
	$(LINK) letsencryptauthorityx4.signing_policy 929e297e.signing_policy
9f194ecd.signing_policy : lets-encrypt-r4.signing_policy
	$(LINK) lets-encrypt-r4.signing_policy 9f194ecd.signing_policy
dec71a0b.signing_policy : lets-encrypt-r3.signing_policy
	$(LINK) lets-encrypt-r3.signing_policy dec71a0b.signing_policy
dd7d39a7.signing_policy : lets-encrypt-r4.signing_policy
	$(LINK) lets-encrypt-r4.signing_policy dd7d39a7.signing_policy

23c2f850.0 : letsencryptauthorityx4.pem
	$(LINK) letsencryptauthorityx4.pem 23c2f850.0
4042bcee.0 : isrgrootx1.pem
	$(LINK) isrgrootx1.pem 4042bcee.0
4a0a35c0.0 : letsencryptauthorityx3.pem
	$(LINK) letsencryptauthorityx3.pem 4a0a35c0.0
4f06f81d.0 : letsencryptauthorityx3.pem
	$(LINK) letsencryptauthorityx3.pem 4f06f81d.0
6187b673.0 : isrgrootx1.pem
	$(LINK) isrgrootx1.pem 6187b673.0
8d33f237.0 : lets-encrypt-r3.pem
	$(LINK) lets-encrypt-r3.pem 8d33f237.0
929e297e.0 : letsencryptauthorityx4.pem
	$(LINK) letsencryptauthorityx4.pem 929e297e.0
9f194ecd.0 : lets-encrypt-r4.pem
	$(LINK) lets-encrypt-r4.pem 9f194ecd.0
dec71a0b.0 : lets-encrypt-r3.pem
	$(LINK) lets-encrypt-r3.pem dec71a0b.0
dd7d39a7.0 : lets-encrypt-r4.pem
	$(LINK) lets-encrypt-r4.pem dd7d39a7.0

isrgrootx1.pem :
	$(GET) https://letsencrypt.org/certs/isrgrootx1.pem
lets-encrypt-r3.pem :
	$(GET) https://letsencrypt.org/certs/lets-encrypt-r3.pem
lets-encrypt-r4.pem :
	$(GET) https://letsencrypt.org/certs/lets-encrypt-r4.pem
letsencryptauthorityx3.pem :
	$(GET) https://letsencrypt.org/certs/letsencryptauthorityx3.pem
letsencryptauthorityx4.pem :
	$(GET) https://letsencrypt.org/certs/letsencryptauthorityx4.pem
