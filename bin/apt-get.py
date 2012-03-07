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


def backtick(cmd):
    p = subprocess.Popen(
        ['/bin/bash', '-c', cmd], stdin=subprocess.PIPE, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, close_fds=True)
    stdouterr, unused = p.communicate()
    return stdouterr


def sudo(cmd):
    print 'sudo: %s' % cmd
    p = subprocess.Popen(['/usr/bin/sudo', '/bin/bash', '-c', cmd])
    p.communicate()


GIT_BIN = backtick('which git').rstrip()


def main():
    apt_get_cmd = ' '.join(['/usr/bin/apt-get'] + sys.argv[1:])

    # pre commit
    git('add -A .')
    git('status')
    git('''commit -m 'BEFORE: "%s"' ''' % apt_get_cmd)

    # run actual apt-get command
    sudo(apt_get_cmd)

    # update package list
    sudo('dpkg -l > /etc/eliot-dpkg-list')

    # post commit
    git('add -A .')
    git('status')
    git('''commit -m 'AFTER: "%s"' ''' % apt_get_cmd)


def git(git_cmd):
    sudo('cd /etc && %s %s' % (GIT_BIN, git_cmd))


if __name__ == '__main__':
    main()
