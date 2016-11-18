@echo off
setlocal enableextensions enabledelayedexpansion
SET /A COUNT=1
FOR /L %%i IN (1,1,5) DO (
  rem ECHO !COUNT!
  SET /A COUNT+=1
  rem echo [%%i]
)
endlocal

@echo off
setlocal enableextensions enabledelayedexpansion
FOR /L %%i IN (1,1,5) DO (
  echo [%%i]
)
endlocal


FOR /f "tokens=*" %%i IN ('docker-machine ip swarm01') DO (
    echo docker swarm init --advertise-addr %%i
     
    )