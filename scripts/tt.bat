setlocal enableextensions enabledelayedexpansion

FOR /L %%i IN (1,1,1) DO (
    docker-machine create --driver amazonec2 ^
        --amazonec2-vpc-id vpc-8fc036e9 ^
        --amazonec2-ami ami-8acbff9d ^
        --amazonec2-zone e ^
        --amazonec2-subnet-id subnet-eaca18d6 ^
        --amazonec2-instance-type t2.nano ^
        --amazonec2-tags environment,test,domain,dockerSwarmDemo ^
        swarm-%%i
)
endlocal

        rem --amazonec2-ssh-keypath C:\Users\jcl\.ssh\gi-dev01-key.pem ^
