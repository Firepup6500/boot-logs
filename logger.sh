#!/bin/bash
. '/home/firepup650/projects/boot-logs/.env'

function handle_signal()
{
    /usr/bin/curl "$SLACK_WEBHOOK_URL" -X POST -H "Content-Type: application/json" -d "{\"hostname\":\"$(hostname)\",\"state\":\"shutting down\"}" --connect-timeout 2&&echo BOOT-LOGS:Post to slack OK||echo BOOT-LOGS:Post to slack FAILED
    exit 0
}

/usr/bin/curl "$SLACK_WEBHOOK_URL" -X POST -H "Content-Type: application/json" -d "{\"hostname\":\"$(hostname)\",\"state\":\"booting up\"}" --connect-timeout 2&&echo BOOT-LOGS:Post to slack OK||echo BOOT-LOGS:Post to slack FAILED

trap handle_signal SIGTERM


while true
do
    sleep 60
done
