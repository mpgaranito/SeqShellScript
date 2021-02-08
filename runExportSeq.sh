#!/bin/bash
SEQ_CLI_PATH="/mnt/d/take/ArquivosAnaliseLog/seqcli-2020.4.365-linux-x64/"
DATE_UNIX_ERA=$(date -u +%s)
echo $DATE_UNIX_ERA
echo $(date -u --date=@$DATE_UNIX_ERA)
INICIAL_DAY=$(date -u --date=@$DATE_UNIX_ERA +%0d)
FINAL_DAY=$INICIAL_DAY
INICIAL_MONTH=$(date -u --date=@$DATE_UNIX_ERA +%m)
INICIAL_YEAR=$(date -u --date=@$DATE_UNIX_ERA +%Y)
INICIAL_HOUR=$(date -u --date=@$DATE_UNIX_ERA +%H)
INICIAL_MINUTE=$(date -u --date=@$DATE_UNIX_ERA +%M)
echo $INICIAL_HOUR
if [ $INICIAL_HOUR -gt 0 ]; then
    INICIAL_HOUR=$(expr "$INICIAL_HOUR" - "1")
else
    INICIAL_HOUR=23
    INICIAL_DAY=$(expr "$INICIAL_DAY" - "1")
    if [ $INICIAL_DAY -lt 10 ]; then
        INICIAL_DAY=$(echo '0'$INICIAL_DAY)
    fi
fi
if [ $INICIAL_HOUR -lt 10 ]; then
    echo $INICIAL_HOUR
    INICIAL_HOUR=$(echo '0'$INICIAL_HOUR)
    echo $INICIAL_HOUR
fi
cd $SEQ_CLI_PATH
./seqcli query -q="select * from stream where Application = 'claro-faturamento' and  @Level = 'Debug' limit 100000" --start="$INICIAL_YEAR-$INICIAL_MONTH-$INICIAL_DAY"T"$INICIAL_HOUR:00:00.000Z" --end="$INICIAL_YEAR-$INICIAL_MONTH-$FINAL_DAY"T"$INICIAL_HOUR:59:59.000Z" >files_$INICIAL_YEAR-$INICIAL_MONTH-$FINAL_DAY-$INICIAL_HOUR.txt
