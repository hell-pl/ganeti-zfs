This is a much-simplified version of https://github.com/ffzg/ganeti-extstorage-zfs
which does not spoof LVM.  It can therefore be used on systems with a mixture of
LVM and ZFS storage.

The ganeti extstorage interface is defined at
http://docs.ganeti.org/ganeti/master/html/man-ganeti-extstorage-interface.html

Checkout this repo as /usr/share/ganeti/extstorage/zfs on each node.

Enable on the master node:

~~~
gnt-cluster modify --enabled-disk-templates plain,drbd,ext
gnt-cluster modify --ipolicy-disk-templates plain,drbd,ext
~~~

And on every node:

~~~
mkdir /var/log/ganeti/extstorage
~~~

Example of use:

~~~
gnt-instance add -n <node> -o noop --no-start --no-install --no-name-check --no-ip-check \
  -t ext --disk 0:size=1G,provider=zfs --disk 1:size=2G,provider=zfs foobar
~~~

TODO: add snapshot function (for gnt-backup export)
