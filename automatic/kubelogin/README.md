# [kubelogin](https://chocolatey.org/packages/kubelogin)

kubelogin is a small command-line utility that allows you to easily login into your kubernetes cluster using OpenID Connect (OIDC).

Here is an example users block config in your `~/.kube/config` file

```yaml
users:
- name: oidc
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - get-token
      - --oidc-issuer-url=https://dex.company.io/dex
      - --oidc-client-id=kubelogin
      - --oidc-client-secret=SomeClientSecretYouBothShare
      - --oidc-extra-scope=profile
      - --oidc-extra-scope=email
      - --oidc-extra-scope=groups
      command: kubelogin
```
