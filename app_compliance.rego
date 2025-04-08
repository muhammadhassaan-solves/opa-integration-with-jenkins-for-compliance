package jenkins.compliance

default allow = false

deny[msg] if {
  input.app.debug == true
  msg := "Application DEBUG mode is enabled. Compliance check failed."
}

deny[msg] if {
  input.app.protocol != "https"
  msg := "Application must use HTTPS protocol."
}

allow if {
  count(deny) == 0
}
