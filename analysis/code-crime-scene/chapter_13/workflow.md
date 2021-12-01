* `maat -c git -l hib_evo.log -a entity-effort`

* `git clone https://github.com/scala/scala.git`
* `gco 2.12.x`
* `git checkout `git rev-list -n 1 --before="2013-12-31" origin/2.11.x``

* `git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat --before=2013-12-31 --after=2011-12-31 > scala_evo.log`
* `maat -c git -l scala_evo.log -a main-dev > scala_main_dev.csv`
* `cloc ./ --by-file --csv --quiet --report-file=scala_lines.csv`
* `python scripts/csv_main_dev_as_knowledge_json.py --structure scala_lines.csv --owners scala_main_dev.csv --authors scala_author_colors.csv > scala_knowledge_131231.json`

```
python scripts/csv_main_dev_as_knowledge_json.py \
--structure scala_lines.csv --owners scala_main_dev.csv \
--authors scala_ex_programmers.csv > scala_knowledge_loss.json
```
