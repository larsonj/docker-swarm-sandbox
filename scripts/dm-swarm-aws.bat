@echo off
setlocal enableextensions enabledelayedexpansion

FOR /L %%i IN (1,1,2) DO (
    docker-machine create --driver amazonec2 ^
        --amazonec2-vpc-id vpc-8fc036e9 ^
        --amazonec2-zone e ^
        --amazonec2-instance-type t2.nano ^
        --amazonec2-tags environment,test,domain,dockerSwarmDemo ^
        swarm-%%i
)
endlocal

echo Pointing current node to swarm-1
FOR /f "tokens=*" %%i IN ('docker-machine env swarm-1') DO %%i

FOR /f "tokens=*" %%i IN ('docker-machine ip swarm-1') DO (
        echo Initializing swarm manager, IP=%%i
        docker swarm init --advertise-addr %%i
        echo docker swarm init --advertise-addr %%i
    )
echo Swarm manager initialized

rem  capture swarm manager token
FOR /f "tokens=*" %%i IN ('docker swarm join-token -q manager') DO (
        SET SM_TOKEN=%%i
    )

rem  capture swarm manager IP
FOR /f "tokens=*" %%i IN ('docker-machine ip swarm-1') DO (
        SET SM_IP=%%i
    )

FOR /L %%i IN (2,1,3) DO (
    rem point next swarm joiner machine
    echo dm env swarm-%%i
    FOR /f "tokens=*" %%j IN ('docker-machine env swarm-%%i') DO %%j
    echo command executed [%%j]

    rem capture joiner IP address
    FOR /f "tokens=*" %%k IN ('docker-machine ip swarm-%%i') DO (
            echo setting IP == dm ip swarm-%%i
            SET IP=%%k
        )

    echo swarm-%%i joining and pointing to swarm manager at %SM_IP%
    docker swarm join ^
        --token %SM_TOKEN% ^
        --advertise-addr %IP% ^
        %SM_IP%:2377
    )
endlocal

FOR /L %%i IN (1,1,3) DO (
    rem point next machine
    FOR /f "tokens=*" %%j IN ('docker-machine env swarm-%%i') DO %%j

    echo adding labels for swarm-%%i
    docker node update ^
        --label-add env=prod ^
        swarm-%%i

    )
endlocal

echo ">> The swarm cluster is up and running"