### Deploy using Flux CICD.
```sh
1. Clone this Repo.
2. Install maven and docker
3. Build the project using: $ mvn clean install
4. Create image from Dockerfile: $ docker build -t <image_name>:1.0
5. And push to Hub
6. FLUX:
```
```json
a. $ export GHUSER="khann-adill"
b. $ fluxctl install \
--git-user=${GHUSER} \
--git-email=${GHUSER}@users.noreply.github.com \
--git-url=git@github.com:${GHUSER}/play-with-kubectl \
--git-path=./Project/notes/kube \
--git-branch=master \
--namespace=flux | kubectl apply -f -
```
