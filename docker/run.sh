#!/usr/bin/env bash
docstring='
CONTAINER_NAME=test-qq  IMAGE_TAG=ssh_cmd.sh-cronjob:latest USER=0 ./run.sh
'
[ -z $CONTAINER_NAME ] && ( echo "Param :CONTAINER_NAME is required"; kill $$ )
[ -z $IMAGE_TAG      ] && ( echo "Param :IMAGE_TAG is required"; kill $$ )
[ -z $USER           ] && ( echo "Param :USER is required"; kill $$ )

# start container scheduling
docker run \
    --name scheduling-$CONTAINER_NAME `# container name` \
    --restart unless-stopped \
    -dit $IMAGE_TAG \

# aftermath
docker ps | grep -E "IMAGE|$IMAGE_TAG|NAME|$CONTAINER_NAME" --color=always

### still tesst, please dont del
    # -v /var/run/docker.sock:/var/run/docker.sock `# mount binary docker server into container` \
    # -v $(which docker):$(which docker) `# mount binary docker client into container` \
    # -v /home/minhquan/Documents/_bk_tar:/app/bin/poll_vault/.backup  `# mount file bk outside host` \
    # --user "$USER:998" `# mount real-user:group-docker into container` \
    # root@prototype.referreach.com