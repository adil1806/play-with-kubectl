{{- define "chart" -}}
{{- print "%s-%s" .Chart.name .Chart.Version }}
{{- end }}

{{- define "chart.name" -}}
{{- print "%s" .Chart.name }}
{{- end }}

{{- define "chart.labels" -}}
helm.sh/chart: {{ include "chart" . }}
{{- if .Chart.apiVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}

