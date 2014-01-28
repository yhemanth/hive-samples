basedir=`dirname $0`
confdir=$basedir/../conf
scriptdir=$basedir/../scripts
hive --config $confdir -v -f $scriptdir/$1/run.hql
