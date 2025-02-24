.PHONY: argocd
argocd:
	kubectl port-forward svc/argo-cd-argocd-server -n argocd 8080:80

.PHONY: dashboard
dashboard:
	kubectl port-forward svc/dashboard-kubernetes-dashboard-web -n dashboard 8081:8000
