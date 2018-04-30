# debugging options
#set -x
#set >&2

dir=/usr/share/ganeti/extstorage/zfs/

host_config="$dir/etc/`hostname -s`.sh"
test -r "$host_config" && . "$host_config"

# Parent for zvols
test -n "${EXTP_ZFS+x}" || EXTP_ZFS="zfs/vm" 

# parameters for zfs create
# -b 4k	block size sutable for ext4 filesystem
# lz4	compression with low cpu overhead
#
# If you want sparse provisioning add the "-s" flag.
# This is dangerous because you can overcommit your disk space.
# You can however easily switch any volume to sparse by setting
# its reservation to zero, or non-sparse by settings its
# reservation to volsize.
test -n "${EXTP_CREATE+x}" || EXTP_CREATE="-b 4k -o compression=lz4"

# on zfs destroy remove dependent snapshots
test -n "${EXTP_DESTROY+x}" || EXTP_DESTROY="-R"
