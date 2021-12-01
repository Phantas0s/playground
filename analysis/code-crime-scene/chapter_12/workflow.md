```
git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat \
--before=2013-09-05 --after=2012-01-01 > hib_evo.log
```

`maat -l hib_evo.log -c git -a authors`

`maat -c git -l hib_evo.log -a coupling --temporal-period 1`

`maat -c git -l hib_evo.log -a main-dev > main_devs.csv`
-> Mr. Ebersole (57% code ownership)
`maat -c git -l hib_evo.log -a entity-ownership`
