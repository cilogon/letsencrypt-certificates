sources = isrgrootx1.signing_policy.txt \
          letsencryptauthorityx3.signing_policy.txt \
          letsencryptauthorityx4.signing_policy.txt

targets = 23c2f850.signing_policy 4042bcee.signing_policy \
          4a0a35c0.signing_policy 4f06f81d.signing_policy \
          6187b673.signing_policy 929e297e.signing_policy \
          23c2f850.0 4042bcee.0 4a0a35c0.0 4f06f81d.0 6187b673.0 929e297e.0 \
          isrgrootx1.pem.txt \
          letsencryptauthorityx3.pem.txt letsencryptauthorityx4.pem.txt

installfiles = $(targets) $(sources)

installdir = /etc/grid-security/certificates

GET = curl -O
INSTALL = install
LINK = ln -s

all : $(targets)

install : all
	$(INSTALL) $(installfiles) $(DESTDIR)$(installdir)

clean :
	$(RM) *.0 *.signing_policy *.pem.txt

check : letsencryptauthorityx3.pem.txt letsencryptauthorityx4.pem.txt
	openssl verify -CApath . letsencryptauthorityx3.pem.txt
	openssl verify -CApath . letsencryptauthorityx4.pem.txt

23c2f850.signing_policy : letsencryptauthorityx4.signing_policy.txt
	$(LINK) letsencryptauthorityx4.signing_policy.txt 23c2f850.signing_policy
4042bcee.signing_policy : isrgrootx1.signing_policy.txt
	$(LINK) isrgrootx1.signing_policy.txt 4042bcee.signing_policy
4a0a35c0.signing_policy : letsencryptauthorityx3.signing_policy.txt
	$(LINK) letsencryptauthorityx3.signing_policy.txt 4a0a35c0.signing_policy
4f06f81d.signing_policy : letsencryptauthorityx3.signing_policy.txt
	$(LINK) letsencryptauthorityx3.signing_policy.txt 4f06f81d.signing_policy
6187b673.signing_policy : isrgrootx1.signing_policy.txt
	$(LINK) isrgrootx1.signing_policy.txt 6187b673.signing_policy
929e297e.signing_policy : letsencryptauthorityx4.signing_policy.txt
	$(LINK) letsencryptauthorityx4.signing_policy.txt 929e297e.signing_policy

23c2f850.0 : letsencryptauthorityx4.pem.txt
	$(LINK) letsencryptauthorityx4.pem.txt 23c2f850.0
4042bcee.0 : isrgrootx1.pem.txt
	$(LINK) isrgrootx1.pem.txt 4042bcee.0
4a0a35c0.0 : letsencryptauthorityx3.pem.txt
	$(LINK) letsencryptauthorityx3.pem.txt 4a0a35c0.0
4f06f81d.0 : letsencryptauthorityx3.pem.txt
	$(LINK) letsencryptauthorityx3.pem.txt 4f06f81d.0
6187b673.0 : isrgrootx1.pem.txt
	$(LINK) isrgrootx1.pem.txt 6187b673.0
929e297e.0 : letsencryptauthorityx4.pem.txt
	$(LINK) letsencryptauthorityx4.pem.txt 929e297e.0

isrgrootx1.pem.txt :
	$(GET) https://letsencrypt.org/certs/isrgrootx1.pem.txt
letsencryptauthorityx3.pem.txt :
	$(GET) https://letsencrypt.org/certs/letsencryptauthorityx3.pem.txt
letsencryptauthorityx4.pem.txt :
	$(GET) https://letsencrypt.org/certs/letsencryptauthorityx4.pem.txt
