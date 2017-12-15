listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_cert_file = "/etc/vault.d/vault.crt"
  tls_key_file = "/etc/vault.d/vault.key"
}

storage "file" {
  path = "/mnt/vault/data"
}
