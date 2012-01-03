#!/bin/bash
path=/home/myatsumoto/ruby/jkfd/api
db=jkfd.memo
estcmd gather -cl -il ja -sd -cm ${path}/${db} ${path}
estcmd purge -cl ${path}/${db}
estcmd extkeys ${path}/${db}
