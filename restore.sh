aws rds restore-db-cluster-from-snapshot \
        --db-cluster-identifier restore-plsql \
        --snapshot-identifier rajesh-pgsql-manual-2022-02-24-13-46 \
        --engine aurora-postgresql \
        --vpc-security-group-ids sg-0e853a914be96db97 \
        --db-subnet-group-name rds-private-subnet-group

aws rds create-db-instance \
        --db-instance-identifier restore-plsql-instance-1 \
        --db-instance-class db.t3.medium \
        --engine aurora-postgresql \
        --db-subnet-group-name rds-private-subnet-group \
        --db-cluster-identifier restore-plsql

aws rds describe-db-instances \
        --db-instance-identifier restore-plsql-instance-1 \
        --query 'DBInstances[*].[DBInstanceStatus]'


while state=$(aws rds describe-db-instances \
        --db-instance-identifier restore-plsql-instance-1 \
        --query 'DBInstances[*].[DBInstanceStatus]' --output=text); do
  if [ "$state" = "available" ]; then
    echo "available"
    PGPASSWORD=rajesh233 pg_dump -h ${MYSQL_HOST} \
            -U ${MYSQL_USER} \
            -d ${DATABASE_NAME} >  dump.sql
    echo "dump_done"
    PGPASSWORD=rajesh233  psql -h ${MYSQL_HOST_1} \
            -U ${MYSQL_USER} \
            -d ${DATABASE_NAME} <  dump.sql
    echo "restore_done"
    break
  else
    echo "unavailable"   
  fi
  sleep 30;
done

aws rds describe-db-instances --db-instance-identifier raj-test --query 'DBInstances[].{ID:Endpoint.Address}' --output text

aws rds describe-db-instances --db-instance-identifier raj-test --query 'DBInstances[].DBName[]' --output text

aws rds describe-db-instances --db-instance-identifier raj-test --query 'DBInstances[].MasterUsername[]' --output text

echo "+------------------------------------------------------------------------------------+"
echo "| RDS Snapshot and Restore to Temp Instance                                          |"
echo "+------------------------------------------------------------------------------------+"


 aws rds describe-db-snapshots --db-instance-identifier terraform-20220221095737672600000002 --query="reverse(sort_by(DBSnapshots, &SnapshotCreateTime))[0]|DBSnapshotIdentifier" --output=text
 
 aws rds describe-db-instances --db-instance-identifier  --query 'DBInstances[].VpcSecurityGroups[*].[VpcSecurityGroupId]' --output text

aws rds describe-db-instances --db-instance-identifier  --query 'DBInstances[].DBSubnetGroup[].[DBSubnetGroupName]' --output text


    PGPASSWORD=rajesh233 pg_dump -h ${DESTINATION_HOST} -U ${MYSQL_USER} ${DATABASE_NAME} >  dump.sql
#    echo "dump_done"
#    echo "drop databse"
#    PGPASSWORD=rajesh233 dropdb -h ${MYSQL_HOST_1} -U ${MYSQL_USER} ${DATABASE_NAME}
#    echo "create databse"
#    PGPASSWORD=rajesh233 createdb -h ${MYSQL_HOST_1} -U ${MYSQL_USER} ${DATABASE_NAME}
    echo "dump import"
    PGPASSWORD=rajesh233  psql -h ${MYSQL_HOST_1} -U ${MYSQL_USER} ${DATABASE_NAME} <  dump.sql
    echo "restore_done"
    break
  else
    echo "unavailable"
    
    
     -c "REVOKE CONNECT ON DATABASE ${DATABASE_NAME} FROM public;
     
     https://jarombek.com/blog/jul-26-2021-aws-synthetics-canary



