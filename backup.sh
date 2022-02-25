#!/bin/sh

NOW_DATE=$(date '+%Y-%m-%d-%H-%M')

RESTORE_FROM_INSTANCE_ID='rajesh-pgsql'

echo "Creating manual snapshot of ${RESTORE_FROM_INSTANCE_ID}"

SNAPSHOT_ID=$(aws rds create-db-cluster-snapshot \
        --db-cluster-snapshot-identifier ${RESTORE_FROM_INSTANCE_ID}-manual-${NOW_DATE} \
        --db-cluster-identifier ${RESTORE_FROM_INSTANCE_ID})

echo $SNAPSHOT_ID

while state=$(aws rds describe-db-cluster-snapshots \
        --db-cluster-snapshot-identifier ${RESTORE_FROM_INSTANCE_ID}-manual-${NOW_DATE} \
        --query 'DBClusterSnapshots[0].[Status]' --output text); do
  if [ "$state" = "available" ]; then
    echo "Finished creating new snapshot ${RESTORE_FROM_INSTANCE_ID}-manual-${NOW_DATE} from ${RESTORE_FROM_INSTANCE_ID}"
    break
  else
    echo $state
  fi
  sleep 5;
done
