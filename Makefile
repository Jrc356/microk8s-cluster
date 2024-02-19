.PHONY: argocd
argocd:
	kubectl port-forward svc/argo-cd-argocd-server -n argocd 8080:443

.PHONY: dashboard
dashboard:
	kubectl port-forward svc/dashboard-kubernetes-dashboard -n dashboard 8081:443