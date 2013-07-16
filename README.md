Mutt configuration files
========================

My mutt setup uses [offlineimap](http://offlineimap.org/) to maintain a
synchronized local copy of my email, [notmuch](http://notmuchmail.org) for
indexed search and [lbdb](http://www.spinnaker.de/lbdb/) as a contact database.

I use the postsynchook of offlineimap to index new mail. It invokes _notmuch
new_ to index with notmuch and _lbdb-fetchaddr_ to update the inmail module for
lbdb.

This repo does not contain the configuration for offlineimap, nor for notmuch.
For offlineimap, see /usr/share/doc/offlineimap/examples/ for examples, or refer
to [the manual](http://docs.offlineimap.org/en/latest/MANUAL.html#imap-using-name-translations).

The install script will offer to install the postsync hook and set up notmuch if
you haven't already. Please note that the postsync script assumes mail is synced
to ~/Mail/AccountName/ (for indexing with lbdb-fetchaddr).

The main muttrc file will source ~/.muttrc-local if it exists. The provided
example will not be installed by the install script.
