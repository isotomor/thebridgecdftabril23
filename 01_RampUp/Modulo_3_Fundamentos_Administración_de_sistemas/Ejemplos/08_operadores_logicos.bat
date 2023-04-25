@echo off
SET /A a= 5
SET /A b= 10
IF %a% GEQ 10 (
    IF %b% LEQ 0 (
        ECHO %a% is NOT less than 10 OR %b% is NOT greater than 0
    ) ELSE (
        ECHO %a% is less than 10 OR %b% is greater than 0
    )
) ELSE (
    ECHO %a% is less than 10 OR %b% is greater than 0
)