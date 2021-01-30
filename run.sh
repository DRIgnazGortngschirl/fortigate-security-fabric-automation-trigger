IP=$1

sed 's/" /"\n/g' INPUT-$IP >FORMATED-$IP

DATE=$(grep "^date" FORMATED-$IP | sed 's/date=//g' | sed 's/time=//g' | sed 's/logid=.*//g' | sed 's/ *$//')
LEVEL=$(grep "^level" FORMATED-$IP | sed 's/level=//g' | tr -d '",')
VDOM=$(grep "^vd" FORMATED-$IP | sed 's/vd=//g' | tr -d '",')
LOGDESCRIPTION=$(grep "^logdesc" FORMATED-$IP | sed 's/logdesc=//g' | tr -d '",')
USER=$(grep "^user" FORMATED-$IP | sed 's/user=//g' | tr -d '",')
SRCIP=$(grep "^srcip" FORMATED-$IP | sed 's/srcip=//g' | sed 's/dstip.*//g' | tr -d '",' | sed 's/ *$//')
DSTIP=$(grep "^srcip" FORMATED-$IP | sed 's/.*dstip=//g' | sed 's/action.*//g' | tr -d '",' | sed 's/ *$//')
ACTION=$(grep "^srcip" FORMATED-$IP | sed 's/.*action=//g' | tr -d '",')
MSG=$(grep "^msg" FORMATED-$IP | sed 's/msg=//g' | tr -d '",')
STATUS=$(grep "^status" FORMATED-$IP | sed 's/status=//g' | tr -d '",')

ERROR=$DATE$LEVEL$VDOM$LOGDESCRIPTION$USER$SRCIP$DSTIP$ACTION$MSG
if [ -z $ERROR ]; then
    DATE=$(date)
    MSG=Error
    echo "$DATE,$MSG" >>log.txt
    echo "$(cat INPUT-$IP FORMATED-$IP >>error.log)"
    echo "------------------------------------------" >>error.log
else
    echo "$IP,$DATE,$LEVEL,$VDOM,$LOGDESCRIPTION,$USER,$SRCIP,$DSTIP,$ACTION,$MSG,$STATUS" >>log.txt
fi
rm INPUT-$IP -f
rm FORMATED-$IP -f
