SETLOCAL ENABLEDELAYEDEXPANSION
SET "param=%*"
SET "disp="&SET "disp[x]="&SET "disp[y]="&SET "final="
SET "param[C]=#"
SET /A "max=dif=param[num]=cur=0", "param[X]=param[NS]=param[Y]=param[D]=param[A]=param[W]=param[XR]=param[XS]=param[YR]=param[YS]=1", "param[NS]=2"
(ECHO %param:/=&SET /A "param[num]+=1"&SET param[!param[num]!]=%)>NUL
FOR /L %%P in (1, 1, %param[num]%) DO (
    FOR /F "tokens=1-2 delims= " %%G in ("!param[%%P]!") DO (
        IF defined param[%%G] (
            SET "param[%%G]=%%H"
        ) else (
            ECHO Invalid Switch /%%G
            GOTO :EOF
        )
    )
)
IF %param[D]% NEQ 2 (
    SET /A "param[D]-=1"
)
FOR /F %%Q in (%~1) DO (
    SET /A "num=%%Q / param[A]", "cur+=1", "scale[x]=((cur - 1) * param[XS]) + param[XR]"
    IF !num! GTR !max! (
        SET /A "dif=num - max"
        FOR /L %%G in (1, 1, !dif!) DO (
            SET /A "scale[ycur]+=1", "scale[y]=((scale[ycur] - 1) * param[YS]) + param[YR]"
            SET "disp=!disp!%ESC%[D%ESC%[A%param[C]%"
            SET "disp[y]=!disp[y]!%ESC%[%param[X]%G%ESC%[A!scale[y]!"
        )
        SET "add=!disp!"
        SET "max=!num!"
    ) else IF !num! EQU 0 (
        SET "add=%ESC%[A"
    ) else (
        SET /A "dif=(max - num) * 7"
        IF !dif! EQU 0 (
            SET "add=!disp!"
        ) else (
            FOR %%L in (!dif!) DO (
                SET "add=!disp:~0,-%%L!"
            )
        )
    )
    FOR /L %%G in (1, 1, %param[W]%) DO (
        SET "final=!final!!add!%ESC%[C%ESC%[!num!B"
    )
    SET "final=!final!!width[disp]!%ESC%[%param[D]%C"
    IF %param[D]% LSS 2 (
        SET /A "scale[num]=((cur - 1) * (param[W] + param[D] + 1)) + param[X] + param[NS]"
    ) else (
        SET /A "scale[num]=((cur - 1) * (param[W] + param[D])) + param[X] + param[NS]"
    )
    SET "disp[x]=!disp[x]!%ESC%[!scale[num]!G!scale[x]!"
)

ENDLOCAL&SET "final=%ESC%[%param[Y]%;%param[X]%H%ESC%[%max%B%disp[y]%%ESC%[%max%B%ESC%[%param[NS]%G%ESC%[2C%final%%disp[x]%"
