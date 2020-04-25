Caution with using environment variable provided to docker command(s)

Quick view of the context in [this image](./docker_buildtime_w_runtime_var.png)

There are two types
 00 build-time argument    # define as param `--build-arg` of command `docker build` and become `ARG var=value` in Dockerfile ref. https://vsupalov.com/docker-env-vars/#docker-image-build-time-variables 
                           # has effect to Dockerfile script ie build script
                           # for docker-compose.yaml, the build-time variables provided in .env and visible as ${var_name} in docker-compose syntax
                           #                                                               pls DO NOT mistake this .env file to define variables used inside the container; we have docker compose up --env-file param for that <-- this is stup*d confusing the docker-compose team created!

 01 run-time env variable  # are the env var defined for the running container
                           # define as param `-e` of command `docker run` ref. https://docs.docker.com/engine/reference/commandline/run/
                           # define as .env?
                           #    .env has NO effect with `docker run`
                           #    .env helps define variables used in `docker-compose` script
