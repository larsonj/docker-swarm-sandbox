@echo off
setlocal enableextensions enabledelayedexpansion

FOR /L %%G IN (0,1,5) DO echo %%G

for /L %%i in (0,1,3) DO (
	for /L %%j in (0,1,5) DO (
			echo %%i,%%j
		)
	)

goto end

FOR /L %%i IN (1,1,3) DO (
    docker-machine create --driver amazonec2 ^
        --amazonec2-vpc-id vpc-8fc036e9 ^
        --amazonec2-zone e ^
        --amazonec2-instance-type t2.nano ^
        --amazonec2-tags environment,test domain,dockerSwarmDemo ^
        swarm-%%1
)
:
:end
echo. & echo fini^^!
endlocal
