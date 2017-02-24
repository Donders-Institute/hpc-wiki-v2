## Preparing data for exercise

1. Query the torquemon database to get 7-day accounting, do it with root account on dccn-l018

```bash
% cd /var/log/torque/torquemon_db
% sqlite3 mm_trackTorqueJobs_201409.db 'select timestamp,uid,nj_matlab,nj_batch from accounting where timestamp <= 1410170400;' > cluster_accounting.dat
```

2. Reformat the data: convert timestamp to date string, and filter out the lines with 0 matlab and batch jobs

```bash
for l in `cat cluster_accounting.dat`; do ts=`echo $l | cut -f 1 -d '|'`; td=`date -d @${ts} +'%Y-%m-%d'`; echo $l | sed "s:${ts}:${td}:g"; done  | awk -F '|' '{ if ($3 > 0 || $4 > 0) print $1,$2,$3,$4; }'
```
