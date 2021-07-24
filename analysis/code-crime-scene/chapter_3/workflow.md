```bash
maat -l maat_evo.log -c git -a revisions

git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --before=2013-11-01 > maat_evo.log

maat -l maat_evo.log -c git -a revisions > maat_freqs.csv

cloc ./ --by-file --csv --quiet --report-file=maat_lines.csv

python2 scripts/merge_comp_freqs.py maat_freqs.csv maat_lines.csv
```
