#!/usr/bin/env bash
# See https://github.com/helm/charts/blob/master/stable/kibana/templates/configmap-dashboardimport.yaml

echo "Waiting up to 60 seconds for Kibana to get in green overall state..."
for i in {1..60}; do
  curl -s kibana:5601/api/status | python -c 'import sys, json; print json.load(sys.stdin)["status"]["overall"]["state"]' 2> /dev/null | grep green > /dev/null && break || sleep 1
done

echo -e "Importing ${DASHBOARD_FILE} dashboard..."
if ! python -c 'import sys, json; print json.load(sys.stdin)' < "${DASHBOARD_FILE}" &> /dev/null ; then
  echo "file is not valid JSON, assuming it's an URL..."
  TMP_FILE="$(mktemp)"
  curl -s -L ${DASHBOARD_FILE} > ${TMP_FILE}
  curl -s --connect-timeout 60 --max-time 60 -XPOST kibana:5601/api/kibana/dashboards/import?force=true -H 'kbn-xsrf:true' -H 'Content-type:application/json' -d @${TMP_FILE}
  rm ${TMP_FILE}
else
  echo "Valid JSON found in ${DASHBOARD_FILE}, importing..."
  curl -s --connect-timeout 60 --max-time 60 -XPOST kibana:5601/api/kibana/dashboards/import?force=true -H 'kbn-xsrf:true' -H 'Content-type:application/json' -d @./${DASHBOARD_FILE}
fi

if [ "$?" != "0" ]; then
  echo -e "\nImport of ${DASHBOARD_FILE} dashboard failed... Exiting..."
  exit 1
else
  echo -e "\nImport of ${DASHBOARD_FILE} dashboard finished :-)"
fi