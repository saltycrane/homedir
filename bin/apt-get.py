#!/usr/bin/env python

'''
http://www.jukie.net/bart/blog/etc-snapshots-with-git

cd /etc
sudo git init
sudo chmod -R og-rwx /etc/.git
sudo git add .
sudo commit -m 'Initial commit'

.gitignore by etckeeper:
# new and old versions of conffiles, stored by dpkg
*.dpkg-*
# new and old versions of conffiles, stored by ucf
*.ucf-*

# old versions of files
*.old

# mount(8) records system state here, no need to store these
blkid.tab
blkid.tab.old

# some other files in /etc that typically do not need to be tracked
nologin
ld.so.cache
mtab
mtab.fuselock
.pwd.lock
network/run
adjtime
lvm/cache
X11/xdm/authdir/authfiles/*
ntp.conf.dhcp
webmin/fsdump/*.status
webmin/webmin/oscache
apparmor.d/cache/*
service/*/supervise/*
service/*/log/supervise/*
sv/*/supervise/*
sv/*/log/supervise/*
*.elc

# editor temp files
*~
.*.sw?
.sw?
\#*\#
DEADJOE

'''
import subprocess
import sys


def main():

    cmd = ' '.join(['/usr/bin/apt-get'] + sys.argv[1:])

    # pre commit
    sudo('cd /etc && /usr/bin/git add -A .')
    sudo('cd /etc && /usr/bin/git status')
    sudo('''cd /etc && /usr/bin/git commit -m 'BEFORE: "%s"' ''' % cmd)

    # run actual apt-get command
    sudo(cmd)

    # update package list
    sudo('dpkg -l > /etc/eliot-dpkg-list')

    # post commit
    sudo('cd /etc && /usr/bin/git add -A .')
    sudo('cd /etc && /usr/bin/git status')
    sudo('''cd /etc && /usr/bin/git commit -m 'AFTER: "%s"' ''' % cmd)


def sudo(cmd):
    print 'sudo: %s' % cmd
    p = subprocess.Popen(['/usr/bin/sudo', '/bin/bash', '-c', cmd])
    p.communicate()


if __name__ == '__main__':
    main()
