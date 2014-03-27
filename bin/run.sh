basedir=`dirname $0`
confdir=$basedir/../conf
scriptdir=$basedir/../scripts
datadir=$basedir/../data
unique_id=`date "+%Y_%m_%d_%H_%M_%S"`

if [ -f $scriptdir/$1/setup.hql ]
then
  hive --config $confdir -v -f $scriptdir/$1/setup.hql --hivevar unique_id=$unique_id;
fi
echo datadir $datadir
hive --config $confdir -v -f $scriptdir/$1/run.hql --hivevar datadir=$datadir --hivevar unique_id=$unique_id

if [ -f $scriptdir/$1/cleanup.hql ]
then
  hive --config $confdir -v -f $scriptdir/$1/cleanup.hql --hivevar unique_id=$unique_id;
fi
