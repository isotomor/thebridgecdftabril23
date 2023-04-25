@echo off
SET /A a=5
SET /A b=10
if %a% EQU %b% echo A is equal to than B
if %a% NEQ %b% echo A is not equal to than B
if %a% LSS %b% echo A is less than B
if %a% LEQ %b% echo A is less than or equal B
if %a% GTR %b% echo A is greater than B
if %a% GEQ %b% echo A is greater than or equal to B