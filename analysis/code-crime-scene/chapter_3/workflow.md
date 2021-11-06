1. Clone your project and cd in it

2. Travelling back in a precise date

```bash
git checkout `git rev-list -n 1 --before="2013-11-01" master
```

3. Detailed logs with churn (added, removed)

```bash
git log --numstat
```

4. Analyze change frequencies (parse log files and summarize number of times each modules occur)

```bash
git log --pretty=format:'[%h] %an %ad %s' \
--date=short --numstat --before=2013-11-01 > maat_evo.log
```

5. Overview of the log information

```bash
maat -l maat_evo.log -c git -a summary
```

6. Analyze change frequencies

```bash
maat -l maat_evo.log -c git -a revisions > maat_freqs.csv
```

7. Add complexity dimension

```bash
cloc ./ --by-file --csv --quiet --report-file=maat_lines.csv
```

8. Merge complexity and efforts

```bash
python2 scripts/merge_comp_freqs.py maat_freqs.csv maat_lines.csv
```
