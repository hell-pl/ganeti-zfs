# debugging options
#set -x
#set >&2

dir=/srv/ganeti/extstorage/zfs/

host_config="$dir/etc/$(hostname -s).sh"
test -r "${host_config}" && . "${host_config}"

# Parent for zvols
: ${EXTP_ZFS:="rpool"}

# parameters for zfs create
# -b 4k	block size suitable for ext4 filesystem
#       but benchmark it for yourself:
#       https://github.com/zfsonlinux/zfs/issues/824
# lz4	compression with low cpu overhead
#
# If you want sparse provisioning add the "-s" flag.
# This is dangerous because you can overcommit your disk space.
# You can however easily switch any volume to sparse by setting
# its reservation to zero, or non-sparse by settings its
# reservation to volsize.
: ${EXTP_CREATE:="-b 4k -o compression=lz4"}

# on zfs destroy remove dependent snapshots
: ${EXTP_DESTROY:="-R"}
