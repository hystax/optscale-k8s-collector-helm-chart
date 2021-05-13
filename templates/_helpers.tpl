{{/*
Generate certificates for custom-metrics api server
*/}}
{{- define "optscale-agent.gen-certs" -}}
{{- $ca := genCA "optscale-agent" 3650 -}}
{{- $cert := genSelfSignedCert "foo.com" (list "127.0.0.1") (list "localhost") 365 -}}
tls.crt: |
{{ $cert.Cert | indent 2 }}
tls.key: |
{{ $cert.Key | indent 2 }}
{{- end -}}