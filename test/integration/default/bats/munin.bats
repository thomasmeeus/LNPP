@test "Test if the Munin package is installed" {
  run bash -c "dpkg --get-selections | grep munin-node"
  [ $status -eq 0 ]
}

