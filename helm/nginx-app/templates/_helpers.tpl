{{- define "my.name" -}}
{{- printf "%s" .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "my.labels" -}}
helm.sh/chart: {{ include "my.name" . }}
app: {{ .Values.appname }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}
