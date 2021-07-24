```bash
git clone https://github.com/hibernate/hibernate-orm.git
git checkout `git rev-list -n 1 --before="2013-09-05" main`

git log --pretty=format:'[%h] %an %ad %s' --date=short \
--numstat --before=2013-09-05 --after=2012-01-01 > hib_evo.log

maat -l hib_evo.log -c git -a summary

cloc ./ --by-file --csv --quiet --report-file=hib_lines.csv
maat -l hib_evo.log -c git -a revisions > hib_freqs.csv
python2 scripts/merge_comp_freqs.py hib_freqs.csv hib_lines.csv

python2 scripts/csv_as_enclosure_json.py -h
```
