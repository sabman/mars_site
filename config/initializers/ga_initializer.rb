$: << "/d/mac/1/sburq/root/opt"
require 'lib/init_ga'
require 'lib/config/smac_locations'
#ProdDb.connection.execute("ALTER SESSION set NLS_LANGUAGE ='AMERICAN'")
#ProdDb.connection.execute("ALTER SESSION set NLS_TERRITORY ='AMERICA'")
#ProdDb.connection.execute("ALTER SESSION set NLS_CURRENCY ='$'")
#ProdDb.connection.execute("ALTER SESSION set NLS_ISO_CURRENCY ='AMERICA'")
#ProdDb.connection.execute("ALTER SESSION set NLS_NUMERIC_CHARACTERS ='.,'")
#ProdDb.connection.execute("ALTER SESSION set NLS_CALENDAR ='GREGORIAN'")
#puts "ProdDb connection exe"
ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
#ProdDb.connection.execute("ALTER SESSION set NLS_DATE_LANGUAGE ='AMERICAN'")
#ProdDb.connection.execute("ALTER SESSION set NLS_SORT ='BINARY'")
#ProdDb.connection.execute("ALTER SESSION set NLS_TIME_FORMAT ='HH.MI.SSXFF AM'")
#ProdDb.connection.execute("ALTER SESSION set NLS_TIMESTAMP_FORMAT ='DD-MON-RR HH.MI.SSXFF AM'")
#ProdDb.connection.execute("ALTER SESSION set NLS_TIME_TZ_FORMAT ='HH.MI.SSXFF AM TZR'")
#ProdDb.connection.execute("ALTER SESSION set NLS_TIMESTAMP_TZ_FORMAT ='DD-MON-RR HH.MI.SSXFF AM TZR'")
#ProdDb.connection.execute("ALTER SESSION set NLS_DUAL_CURRENCY ='$'")
#ProdDb.connection.execute("ALTER SESSION set NLS_COMP ='BINARY'")
#ProdDb.connection.execute("ALTER SESSION set NLS_LENGTH_SEMANTICS ='CHAR'")
#ProdDb.connection.execute("ALTER SESSION set NLS_NCHAR_CONV_EXCP ='FALSE'")
$KCODE = 'u' # see: https://rails.lighthouseapp.com/projects/8994/tickets/2308-activesupportparameterize-incorrectly-assumes-you-have-set-kcodeu
