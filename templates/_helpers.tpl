{{/*
Generate certificates for custom-metrics api server
*/}}
{{- define "optscale-k8s-collector.gen-certs" -}}
{{- $ca := genCA "optscale-k8s-collector" 3650 -}}
{{- $cert := genSelfSignedCert "localhost.com" (list "127.0.0.1") (list "localhost") 3650 -}}
tls.crt: |
{{ $cert.Cert | indent 2 }}
tls.key: |
{{ $cert.Key | indent 2 }}
{{- end -}}
