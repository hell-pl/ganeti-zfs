# debugging options
#set -x
#set >&2

dir=/usr/share/ganeti/extstorage/zfs/

host_config="$dir/etc/`hostname -s`.sh"
test -r "$host_config" && . "$host_config"

# Parent for zvols
test -n "${EXTP_ZFS+x}" || EXTP_ZFS="zfs/vm" 

# parameters for zfs create
# -s	sparse
# -b 4k	block size sutable for ext4 filesystem
# lz4	compression with low cpu overhead
test -n "${EXTP_CREATE+x}" || EXTP_CREATE="-s -b 4k -o compression=lz4"

# on zfs destroy remove dependent snapshots
test -n "${EXTP_DESTROY+x}" || EXTP_DESTROY="-R"
