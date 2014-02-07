basedir=`dirname $0`
confdir=$basedir/../conf
scriptdir=$basedir/../scripts
datadir=$basedir/../data

if [ -f $scriptdir/$1/setup.hql ]
then
  hive --config $confdir -v -f $scriptdir/$1/setup.hql;
fi

hive --config $confdir -v -f $scriptdir/$1/run.hql --hivevar datadir=$datadir

if [ -f $scriptdir/$1/cleanup.hql ]
then
  hive --config $confdir -v -f $scriptdir/$1/cleanup.hql;
fi
